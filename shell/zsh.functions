function z_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[cyan]%}$me%{$reset_color%}:"
  fi
}

function z_version() {
  if {echo $fpath | grep -q "plugins/rvm"}; then
    echo "%{$fg[grey]%}$(rvm_prompt_info)%{$reset_color%}"
  fi
}

function usePowerline() {
  export XDG_CONFIG_HOME="$HOME/.config"
  export POWERLINE_COMMAND="$HOME/Library/Python/2.7/bin/powerline"
  export POWERLINE_CONFIG="$HOME/Library/Python/2.7/bin/powerline-config"
  if [ -x $HOME/Library/Python/2.7/bin/powerline-daemon ]; then
    $HOME/Library/Python/2.7/bin/powerline-daemon -q
  fi

  if [ -f $Python/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
    source $Python/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
  fi
}

# work with $HOME/.online via $HOME/Library/LaunchAgents/io.goanywhere.connectivity.plist
function prompt_online() {
  if [ -f $HOME/.online ]; then
    echo '%{%F{red}%}❤ '
  else
    echo '%{%F{grey}%}❤ '
  fi
}
