escape=$'\033'
percent=$'\%'
#--------------------------
# Battery Status (Mac Only)
#--------------------------
function batteryPercentage() {
    echo -e `pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d'%'`
}

function batteryStatus() {
    echo -e `pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f2 -d';'`
}

BatteryPrompt() {
#%{$fg[red]%}%? ↵%{$reset_color%}
# f1 = 98%
# f2 = discharging
# f3 = 2:02 remaining
    # Running with Battery
    if [ "$(batteryStatus)" = "discharging" ]; then
        # yellow    [⏚  98%]: running with battery.
        echo -n "%{$fg[yellow]%}[⏚ $(batteryPercentage)%%]%{$reset_color%}"
    # Running with Power Adaptor
    else
        if [ "$(batteryPercentage)" = "100" ]; then
            # green [⌁ charged]: full charged with power.
            echo -n "%{$fg[green]%}[⌁$(batteryStatus)]%{$reset_color%}"
        else
            # yellow [⌁ 98%]: charging with percentage.
            echo -n "%{$fg[yellow]%}[⌁$(batteryPercentage)%%]%{$reset_color%}"
        fi
    fi
}

#----------------------------------
# Internet Connectivity (Mac Only)
#----------------------------------
# work with $HOME/.online via $HOME/Library/LaunchAgents/io.goanywhere.connectivity.plist
OnlinePrompt() {
  if [ -f $HOME/.online ]; then
    echo "%{$fg[red]%}❤ %{$reset_color%}"
  else
    echo "%{$fg[grey]%}❤ %{$reset_color%}"
  fi
}
