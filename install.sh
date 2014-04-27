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
    unlink $1
  elif [ -e $2 ]; then
    rm $1
  fi
  ln -s $1 $2
}

echo "================================================================================"
printf '\033[0;34m%s\033[0m\n' "Setting up preferences...\n"

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
echo "Setting up zsh...\n"
export ZSH="$zsh"
$zsh/tools/install.sh
# zsh install .zshrc template by default.
if [ -e $HOME/.zshrc ]; then
    echo "Replacing default .zshrc...\n"
    rm $HOME/.zshrc
fi
lnif $prefs/zshrc	$HOME/.zshrc

# vim
echo "Setting up editors...\n"
#curl http://j.mp/spf13-vim3 -L -o - | sh
#lnif $prefs/vimrc.local $HOME/.vimrc.local
#lnif $prefs/gvimrc.local $HOME/.gvimrc.local
#link $prefs/emacs    $HOME/.emacs
#link $prefs/emacs.d  $HOME/.emacs.d

# dev
#echo "Setting up dev tools...\n"
#link $prefs/hg               $HOME/.hg
#link $prefs/hgrc             $HOME/.hgrc
link $prefs/gitconfig        $HOME/.gitconfig
link $prefs/gitignore_global $HOME/.gitignore_global
