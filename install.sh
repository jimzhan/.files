#!/usr/bin/env sh

dotfiles="$HOME/dotfiles"
repos="https://github.com/jimzhan/dotfiles.git"

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

echo "Installing/Updating dotfiles...\n"

if [ ! -e $dotfiles/.git ]; then
  echo "Cloning dotfiles\n"
  git clone $repos $dotfiles
else
  echo "Updating dotfiles\n"
  cd $dotfiles && git pull
fi

# zsh
echo "Setting up zsh...\n"
curl -L http://install.ohmyz.sh | sh
lnif $dotfiles/zshrc $HOME/.zshrc

# vim
echo "Setting up vim...\n"
curl http://j.mp/spf13-vim3 -L -o - | sh
lnif $dotfiles/vimrc.local $HOME/.vimrc.local
lnif $dotfiles/gvimrc.local $HOME/.gvimrc.local

# dev
echo "Setting up dev tools...\n"
lnif $dotfiles/gitconfig $HOME/.gitconfig
lnif $dotfiles/gitignore_global $HOME/.gitignore_global
