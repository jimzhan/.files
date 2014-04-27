#!/usr/bin/env sh

dotfiles="$HOME/.dotfiles"
repos="https://github.com/jimzhan/dotfiles.git"

zsh="$dotfiles/oh-my-zsh"
vim="https://raw.githubusercontent.com/spf13/spf13-vim/3.0/bootstrap.sh"


# to error out
warn() {
  echo "$1" >&2
}

die() {
  warn "$1"
  exit 1
}

# force remove any existing link or file before creating custom links.
link() {
  if [ -h $2 ] ; then
    unlink $2
  elif [ -e $2 ]; then
    rm $2
  fi
  ln -s $1 $2
}

echo "================================================================================"
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
  link $dotfiles/zshrc	$HOME/.zshrc
  printf '\033[0;34m%s\033[0m\n' "ZSH is successfully set up."
  echo "================================================================================"

  # vim
  printf '\033[0;34m%s\033[0m\n' "Setting up editors..."
  #curl http://j.mp/spf13-vim3 -L -o - | sh
  #lnif $dotfiles/vimrc.local $HOME/.vimrc.local
  #lnif $dotfiles/gvimrc.local $HOME/.gvimrc.local
  link $dotfiles/emacs    $HOME/.emacs
  link $dotfiles/emacs.d  $HOME/.emacs.d

  # dev
  printf '\033[0;34m%s\033[0m\n' "Setting up dev. tools..."
  link $dotfiles/hg               $HOME/.hg
  link $dotfiles/hgrc             $HOME/.hgrc
  link $dotfiles/gitconfig        $HOME/.gitconfig
  link $dotfiles/gitignore_global $HOME/.gitignore_global
#================================================================================
else
  echo "TODO dotfiles updating..."
  cd $dotfiles
fi
