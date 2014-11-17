#-------------------
# LS Colors
#-------------------
if [ -x /usr/local/bin/gdircolors ]; then
  eval $(gdircolors $HOME/.dotfiles/dircolors/dircolors.256dark)
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export EDITOR="vim"
#-------------------
# Golang Environment
#-------------------
export GOVERSION=$(brew list go | head -n 1 | cut -d '/' -f 6)
export Go=$(brew --prefix)/Cellar/go/$GOVERSION
export GOPATH="$HOME/Go"
export GOBIN="$GOPATH/bin"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$HOME/local/bin:$GOBIN:$Go/bin:$Go/libexec/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export LESS="-R"
