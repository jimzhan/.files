#!/usr/bin/env sh

prefs="$HOME/.dotfiles"
repos="https://github.com/jimzhan/dotfiles.git"
zsh="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

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

echo "Setting up preferences...\n"

if [ ! -e $prefs/.git ]; then
  echo "Cloning preferences\n"
  git clone $repos $prefs
else
  echo "Updating preferences\n"
  cd $prefs && git pull
fi

# zsh
echo "Setting up zsh...\n"
curl -L $zsh | ZSH=$HOME/.dotfiles/oh-my-zsh sh
# zsh install .zshrc template by default.
cp $prefs/zshrc $HOME/.zshrc

# vim
echo "Setting up editors...\n"
curl http://j.mp/spf13-vim3 -L -o - | sh
lnif $prefs/vimrc.local $HOME/.vimrc.local
lnif $prefs/gvimrc.local $HOME/.gvimrc.local
lnif $prefs/emacs    $HOME/.emacs
lnif $prefs/emacs.d  $HOME/.emacs.d

# dev
echo "Setting up dev tools...\n"
lnif $prefs/hg               $HOME/.hg
lnif $prefs/hgrc             $HOME/.hgrc
lnif $prefs/gitconfig        $HOME/.gitconfig
lnif $prefs/gitignore_global $HOME/.gitignore_global
