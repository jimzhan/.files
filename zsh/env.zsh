source "$HOME/.files/zsh/prompt.zsh"
export Vim=$HOME/.vim
#export VimRoot=$(brew --prefix)/Cellar/vim/$(brew list vim | head -n 1 | cut -d '/' -f 6)
#-------------------
# Workspace
#-------------------
export Projects=$HOME/Projects
#-------------------
# FUCKING JAVA
#-------------------
export JAVA_HOME="$(/usr/libexec/java_home)"
export JAVACMD=$JAVA_HOME/bin/java
export AntVersion=$(brew list ant | head -n 1 | cut -d '/' -f 6)
export ANT_HOME=$(brew --prefix)/Cellar/ant/$AntVersion/libexec
export ANT_OPTS="-Xmx512m -XX:MaxPermSize=256M"
#export ANT_HOME="$HOME/Hybris/bin/platform/apache-ant-1.9.1"
export ANT_LIB=$ANT_HOME/lib
export CLASSPATH=".:$CLASSPATH"
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
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Library/depot_tools:$HOME/Library/Python/2.7/bin:$HOME/bin:$GOBIN:$Go/bin:$Go/libexec/bin:$GOBIN:/usr/local/opt/gettext/bin:/usr/local/opt/redis/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
if [ -d $HOME/Library/Python/2.7/lib/python/site-packages/django/bin ]; then
    export PATH="$HOME/Library/Python/2.7/lib/python/site-packages/django/bin:$PATH"
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export LESS="-R"

#----------------------------------
# Custom Proxy File
#----------------------------------
if [ -f "$HOME/Proxy" ]; then
    source "$HOME/Proxy"
fi
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
# Plain Prompt
PROMPT='╭ ${cwd} $(git_prompt_info) $(z_version)${linebreak}╰ $(OnlinePrompt) '
#RPROMPT=%{${lineup}%}%{$fg[blue]%}%t%{$reset_color%}%{${linedown}%}
RPROMPT=%{${lineup}%}$(BatteryPrompt)%{${linedown}%}

# Welcome Message (Apple Logo & Hardware Info.)
#if [ -x /usr/local/bin/archey ]; then
    #archey -c
#fi

#-------------------
# LS Colors
#-------------------
if [ -x /usr/local/bin/gdircolors ]; then
  eval $(gdircolors $HOME/.files/zsh/dircolors.256dark)
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


