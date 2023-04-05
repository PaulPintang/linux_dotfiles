
#!/bin/sh

# Send a notification displaying that the battery is charging or discharging
# Pass 1 as an argument for charging, 0 for discharging
# Example usage: chargingnotify 1

# Check if argument is passed
[ $# != 1 ] && printf '0 or 1 must be passed as an argument.\nUsage: %s 0|1\n' "$0" && exit

export XAUTHORITY=/home/paul/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

BATTERY_CHARGING=$1
BATTERY=$(upower -e | grep 'BAT')
BATTERY_LEVEL=$(upower -i $BATTERY | grep percentage | awk '{ print $2 }'| sed s/'%'/''/g)


# Send notifications
if [ "$BATTERY_CHARGING" -eq 1 ]; then
    notify-send -i charging "Battery is charging" "${BATTERY_LEVEL}% of battery charged." -u low -t 5000 -r 9991
    /usr/bin/sudo -u paul /usr/bin/paplay --server=/run/user/1000/pulse/native /home/paul/.local/bin/soundalerts/charging.mp3 > /dev/null 2>&1
elif [ "$BATTERY_CHARGING" -eq 0 ]; then
    notify-send -i discharging "Battery is discharging" "${BATTERY_LEVEL}% of battery remaining." -u low -t 5000 -r 9991
    /usr/bin/sudo -u paul /usr/bin/paplay --server=/run/user/1000/pulse/native /home/paul/.local/bin/soundalerts/discharging.wav> /dev/null 2>&1

fi



