#!/bin/sh

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=i3
export DESKTOP_SESSION=i3
export QT_QPA_PLATFORMTHEME=qt5ct

# Merge Xresources (if you use them)
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

# Start D-Bus environment
dbus-update-activation-environment --systemd \
    DISPLAY \
    XAUTHORITY \
    XDG_CURRENT_DESKTOP \
    DESKTOP_SESSION

# Start an XSettings daemon (install xsettingsd first)
xsettingsd &

exec i3
