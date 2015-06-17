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
# f1 = 98%
# f2 = discharging
# f3 = 2:02 remaining
    #local percent=`pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d'%'`
    #status="pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f2 -d';'"
    #----------------------
    # Running with Battery
    #----------------------
    if [ "$(batteryStatus)" = "discharging" ]; then
        if [[ "$(batteryPercentage)" =~ "[0-5][0-9]" ]]; then
            # red [⏚  58%]: running with battery.
            echo -e "%{$fg[red]%}[⏚  $(batteryPercentage)%%]%{$reset_color%}"
        else
            # yellow    [⏚  98%]: running with battery.
            echo -e "%{$fg[yellow]%}[⏚  $(batteryPercentage)%%]%{$reset_color%}"
        fi
    #-----------------
    # Running with AC
    #-----------------
    else
        # Running with Power Adaptor
        if [ "$(batteryPercentage)" = "100" ]; then
            # green [⌁ charged]: full charged with power.
            echo -e "%{$fg[green]%}[⌁$(batteryStatus)]%{$reset_color%}"
        else
            # yellow [⌁ 98%]: charging with percentage.
            echo -e "%{$fg[yellow]%}[⌁$(batteryPercentage)%%]%{$reset_color%}"
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
    echo "%{$fg[yellow]%}❤ %{$reset_color%}"
  fi
}
