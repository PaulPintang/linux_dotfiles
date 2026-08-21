#!/bin/sh

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=i3
export DESKTOP_SESSION=i3

# Cursor
export XCURSOR_THEME="Banana"
export XCURSOR_SIZE=28

# Qt
export QT_QPA_PLATFORMTHEME=qt5ct

# Merge Xresources
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

# Start D-Bus environment
dbus-update-activation-environment --systemd \
    DISPLAY \
    XAUTHORITY \
    XDG_CURRENT_DESKTOP \
    DESKTOP_SESSION \
    XCURSOR_THEME \
    XCURSOR_SIZE

# Start XSettings daemon
xsettingsd &

exec i3