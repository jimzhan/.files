source "$HOME/.files/shell/prompt.zsh"
#----------------------------------
# Environment Variables & Functions
#----------------------------------
export EDITOR="vim"
# local Python, leave the system's one intact.
export Python="$HOME/Library/Python/2.7"

# This Enviroment Vairable Shared by ZSH & Vim.
export ColorTheme="base16-solarized"

# https://github.com/chriskempson/base16-shell
BASE16_SHELL="$HOME/.files/lib/base16-shell/$ColorTheme.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

local cwd="%{$fg[blue]%}%3~%{$reset_color%}"
local host="%{$fg[yellow]%}%m%{$reset_color%}"
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'

local linebreak=$'\n'
local lineup=$'\e[1A'
local linedown=$'\e[1B'
local address="`ifconfig | grep "inet " | grep -v 127.0.0. | awk '{ print $2  }'`"

#-------------------
# Powerline + Prompt
#-------------------
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"


# Plain Prompt
PROMPT='╭ ${cwd} $(git_prompt_info) $(z_version)${linebreak}╰ $(prompt_online) '
RPROMPT=%{${lineup}%}%{$fg[blue]%}%t%{$reset_color%}%{${linedown}%}

# Welcome Message (Apple Logo & Hardware Info.)
#if [ -x /usr/local/bin/archey ]; then
  #archey -c
#fi

#-------------------
# LS Colors
#-------------------
if [ -x /usr/local/bin/gdircolors ]; then
  eval $(gdircolors $HOME/.files/shell/dircolors.256dark)
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#-------------------
# Golang Environment
#-------------------
export GoVersion=$(brew list go | head -n 1 | cut -d '/' -f 6)
export Go=$(brew --prefix)/Cellar/go/$GoVersion
export GOPATH="$HOME/Go"
export GOBIN="$GOPATH/bin"
export GoAnywhere="$GOPATH/src/github.com/goanywhere"
#-------------------
# System Paths
#-------------------
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Library/Python/2.7/bin:$GOBIN:$Go/bin:$Go/libexec/bin:/usr/local/opt/gettext/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export LESS="-R"