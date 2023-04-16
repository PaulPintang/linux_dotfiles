#!/bin/bash
BATTERY=$(upower -e | grep 'BAT')

while :
do
    BATTERY_PERCENTAGE=$(upower -i $BATTERY | grep percentage | awk '{ print $2 }'| sed s/'%'/''/g)
    CABLE=$(upower -d | grep -n2 line-power | grep online | awk '{ print $3 }')

    if [[ "$BATTERY_PERCENTAGE" -le "20" && $CABLE = "no" ]]; then
        notify-send -i lowbatt "WARNING: Low Battery" "$BATTERY_PERCENTAGE% of battery remaining!" -u critical -r 9991 -t 8000;
        paplay /home/paul/.local/bin/soundalerts/low.wav
    elif [[ "$BATTERY_PERCENTAGE" -ge "98" && $CABLE = "yes" ]]; then
        notify-send -i fullbatt "Battery Full: 100%" "Please disconnect your charger!" -u low -r 9991 -t 8000 
      	paplay /home/paul/.local/bin/soundalerts/full.wav
    fi
sleep 1m
done
