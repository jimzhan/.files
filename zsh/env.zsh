#-------------------
# LS Colors
#-------------------
if [ -x /usr/local/bin/gdircolors ]; then
  eval $(gdircolors $HOME/.dotfiles/dircolors/dircolors.256dark)
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export EDITOR="vim"
#export GOPATH="$HOME/Go"
export GOVERSION=$(brew list go | head -n 1 | cut -d '/' -f 6)
export Go=$(brew --prefix)/Cellar/go/$GOVERSION
export PYTHONPATH=".:$HOME/Projects/tornext:$PYTHONPATH"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$HOME/local/bin:$Go/bin:$Go/libexec/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export LESS="-R"
export LESSOPEN="pygmentize -gf terminal $1"
