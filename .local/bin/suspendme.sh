#!/bin/bash
BATTERY=$(upower -e | grep 'BAT')
sec=5
while :
do
    BATTERY_PERCENTAGE=$(upower -i $BATTERY | grep percentage | awk '{ print $2 }'| sed s/'%'/''/g)
    CABLE=$(upower -d | grep -n2 line-power | grep online | awk '{ print $3 }')
   
    if [[ "$BATTERY_PERCENTAGE" -le "5" && $CABLE = "no" ]]; then
      while [ $sec -ge 0 ]; do
        notify-send "Warning: Low Battery, connect your charger!" "Laptop will suspend in $sec "seconds"" -u critical -r 9991 -t 2000
        let "sec=sec-1"
        sleep 1
      done
      systemctl suspend
    fi

sleep 1m
done
