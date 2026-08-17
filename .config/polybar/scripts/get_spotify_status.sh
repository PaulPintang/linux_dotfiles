#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
PLAYER="spotify"

# Format of the information displayed
FORMAT="{{ title }} - {{ artist }}"

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
    while IFS= read -r id
    do
        polybar-msg -p "$id" hook spotify-play-pause "$2" >/dev/null 2>&1
    done < <(echo "$1")
}

# Get Spotify status
PLAYERCTL_STATUS=$(playerctl --player="$PLAYER" status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS="$PLAYERCTL_STATUS"
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
    exit 0
fi

if [ "$STATUS" = "Playing" ]; then
    # PLAYING → show PAUSE icon
    update_hooks "$PARENT_BAR_PID" 1

    playerctl --player="$PLAYER" metadata --format "$FORMAT" 2>/dev/null || echo "Spotify"

elif [ "$STATUS" = "Paused" ]; then
    # PAUSED → show PLAY icon
    update_hooks "$PARENT_BAR_PID" 2

    playerctl --player="$PLAYER" metadata --format "$FORMAT" 2>/dev/null

elif [ "$STATUS" = "Stopped" ]; then
    # STOPPED → show PLAY icon
    update_hooks "$PARENT_BAR_PID" 2

    echo "No music is playing"

else
    # NO SPOTIFY → show PLAY icon
    update_hooks "$PARENT_BAR_PID" 2

    echo "Spotify"
fi