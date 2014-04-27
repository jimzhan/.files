#!/usr/bin/env sh

prefs="$HOME/.dotfiles"
repos="https://github.com/jimzhan/dotfiles.git"

zsh="$prefs/oh-my-zsh"
vim="https://raw.githubusercontent.com/spf13/spf13-vim/3.0/bootstrap.sh"


# to error out
warn() {
  echo "$1" >&2
}

die() {
  warn "$1"
  exit 1
}

lnif() {
  if [ ! -e $2 ] ; then
    ln -s $1 $2
  fi
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

if [ ! -e $prefs/.git ]; then
  echo "Start cloning..."
  git clone --recursive $repos $prefs
else
  echo "Start updating..."
fi

cd $prefs
# fetch submodules (zsh)
git submodule foreach git pull


# zsh (as dotfiles's submodule)
printf '\033[0;34m%s\033[0m\n' "Setting up ZSH..."
export ZSH="$zsh"
rm $HOME/.zcompdump* $HOME/.zsh*
$zsh/tools/install.sh
link $prefs/zshrc	$HOME/.zshrc

# vim
printf '\033[0;34m%s\033[0m\n' "Setting up VIM..."
#curl http://j.mp/spf13-vim3 -L -o - | sh
#lnif $prefs/vimrc.local $HOME/.vimrc.local
#lnif $prefs/gvimrc.local $HOME/.gvimrc.local
#link $prefs/emacs    $HOME/.emacs
#link $prefs/emacs.d  $HOME/.emacs.d

# dev
printf '\033[0;34m%s\033[0m\n' "Setting up dev. tools..."
#link $prefs/hg               $HOME/.hg
#link $prefs/hgrc             $HOME/.hgrc
link $prefs/gitconfig        $HOME/.gitconfig
link $prefs/gitignore_global $HOME/.gitignore_global
