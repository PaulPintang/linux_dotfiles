#!/bin/sh

# Check if a device is connected by bluetooth using bluetoothctl
info=$(bluetoothctl info | grep Name)
device=$(bluetoothctl info | grep Name | awk -F ': ' '{print $2}')
percentage=$(bluetoothctl info | grep "Battery Percentage" | awk -F '[(|)]' '{print $2}')

# Show some output when it is
if [ -n "$info" ]; 
then
    # Connected to a device
    echo "$device - $percentage%"
else 
    # Not connected to a device, hide label
    echo ''
fi
