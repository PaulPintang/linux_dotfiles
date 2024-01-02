#!/bin/bash

function send_notification() {
	brightness=$(printf "%.0f\n" $(brillo -G))
	dunstify -a "changebrightness" -u normal -r 9991 -h int:value:"$brightness" -i brightness "Brightness: $brightness%" -t 2000
xiv.foreground: #00C0FF
}

case $1 in
up)
	brillo -A 5 -q
	send_notification $1
	;;
down)
	brillo -U 5 -q
	send_notification $1
	;;
esac
