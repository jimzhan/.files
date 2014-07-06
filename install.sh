#!/usr/bin/env sh

dotfiles="$HOME/.dotfiles"
repos="https://github.com/jimzhan/dotfiles.git"

zsh="$dotfiles/zsh/oh-my-zsh"
vim="https://raw.githubusercontent.com/spf13/spf13-vim/3.0/bootstrap.sh"
spf13="$HOME/.spf13-vim-3"

Xcode=$HOME/Library/Developer/Xcode
XcodeKeys=$Xcode/UserData/KeyBindings
XcodeThemes=$Xcode/UserData/FontAndColorThemes
XcodeFileTemplates="$Xcode/Templates/File Templates"
XcodeProjectTemplates="$Xcode/Templates/Project Templates"


# to error out
warn() {
  echo "$1" >&2
}

die() {
  warn "$1"
  exit 1
}

# forcely remove any existing link or directory.
deldir() {
  if [ -L $1 ]; then
    unlink "$1"
  elif [ -d $1 ]; then
    rm -rf "$1"
  fi
}

# forcely remove any existing link or file before creating custom links.
link() {
  if [ -h $2 ] ; then
    unlink $2
  elif [ -e $2 ]; then
    rm $2
  fi
  ln -s $1 $2
}

# setup Xcode's themes & file/project templates.
setup_xcode() {
  if [ -d $Xcode ]; then

    if [ $1 = true ]; then
      printf '\033[0;34m%s\033[0m\n' "Start setting up Xcode..."
    else
      printf '\033[0;34m%s\033[0m\n' "Updating Xcode preferences..."
    fi

    #deldir $XcodeKeys
    #ln -s $dotfiles/Xcode/UserData/KeyBindings		$XcodeKeys

    deldir $XcodeThemes
    ln -s $dotfiles/Xcode/UserData/FontAndColorThemes	$XcodeThemes

    #deldir "$XcodeProjectTemplates"
    #ln -s "$dotfiles/Xcode/Project Templates"		"$XcodeProjectTemplates"

    #deldir "$XcodeFileTemplates"
    #ln -s "$dotfiles/Xcode/File Templates"		"$XcodeFileTemplates"

  fi
}

echo "\n======================================================================"
printf '\033[0;34m%s\033[0m\n' "Setting up preferences..."

if [ ! -d $dotfiles ]; then
  # setup a brand new system
  git clone --recursive $repos $dotfiles
  cd $dotfiles
  git submodule foreach git pull

  # zsh (as dotfiles's submodule)
  printf '\033[0;34m%s\033[0m\n' "Setting up ZSH..."
  export ZSH="$zsh"
  chsh -s /bin/zsh
  link $dotfiles/zsh/zshrc	$HOME/.zshrc
  printf "\e[32m[✔]\e[0m Successfully installed ZSH."
  echo "======================================================================"

  # vim
  printf '\033[0;34m%s\033[0m\n' "Setting up editors..."
  curl $vim -L -o - | sh
  link $dotfiles/vim/vimrc.local	        $HOME/.vimrc.local
  link $dotfiles/vim/gvimrc.local	        $HOME/.gvimrc.local
  link $dotfiles/vim/vimrc.before.local     	$HOME/.vimrc.before.local
  link $dotfiles/vim/vimrc.bundles.local    	$HOME/.vimrc.bundles.local

  #link $dotfiles/emacs/emacs    $HOME/.emacs
  #link $dotfiles/emacs/emacs.d  $HOME/.emacs.d

  # dev
  printf '\033[0;34m%s\033[0m\n' "Setting up git & ssh..."
  link $dotfiles/git/gitconfig        $HOME/.gitconfig
  link $dotfiles/git/gitignore_global $HOME/.gitignore_global
  if [ ! -d "$HOME/.ssh" ]; then
    mkdir $HOME/.ssh
  fi
  link $dotfiles/ssh/config     $HOME/.ssh/config

  setup_xcode true
#================================================================================
else
  cd $dotfiles
  #printf '\033[0;34m%s\033[0m\n' "Updating ZSH..."
  #git pull
  #git submodule foreach git pull

  #if [ -d $spf13 ]; then
  #  printf '\033[0;34m%s\033[0m\n' "Updating VIM..."
  #  curl $vim -L -o - | sh
  #fi

  setup_xcode false
fi
