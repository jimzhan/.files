#-------------------
# Battery Status (Mac Only)
#-------------------
BatteryPrompt() {
#%{$fg[red]%}%? ↵%{$reset_color%}
# f1 = 98%
# f2 = discharging
# f3 = 2:02 remaining
    local percent=`pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'`
    local status=`pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f2 -d';'`
#
    local prefix="["
    local suffix="]"
    local power="⌁"
    local battery="⏚ "

    # Running with Power Adaptor
    if [ "${status}" != "discharging" ]; then
        if [ "${percent}" = "100%" ]; then
            # green [⌁ charged]: full charged with power.
            echo -n "%{$fg[green]%}${prefix}${power} ${status}${suffix}"
        else
            # yellow [⌁ 98%]: charging with percentage.
            echo -n "%{$fg[yellow]%}%?${prefix}${power} ${percent}${suffix}%{$reset_color%}"
        fi
    # Running with Battery
    else
        # yellow    [⏚  98%]: running with battery.
        echo -n "%{$fg[yellow]%}%?${prefix}${battery} ${percent}${suffix}%{$reset_color%}"
    fi
}
