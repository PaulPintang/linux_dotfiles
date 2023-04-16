#!/bin/bash
Dir=/mnt/phone/

# Select device
Devices=$(simple-mtpfs -l)

if [ ! -n "$Devices" ]; then
	notify-send "No devices found"
	exit
else
  Device=$(echo "$Devices" | dmenu -p "Select device:" || notify-send "No device selected")
  Id=${Device%%:*}
  Name=${Device##*: }
	if [ ! -d "$Dir$Name" ]; then
		mkdir "$Dir$Name"
	fi
fi

if [ ! -n "$(find "$Dir$Name" -maxdepth 0 -empty)" ]; then
  fusermount -u "$Dir$Name" && notify-send "Android Mount" "$Name Unmounted"
else
  simple-mtpfs --device "$Id" "$Dir$Name" -o allow_root && notify-send "Android Mount" "$Name Mounted in $Dir$Name"
fi
