#!/bin/bash
# Toggles between light and dark theme.
# Should work on all Wayland sessions for GTK apps.

COLOR="'prefer-light'"
CURR=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ $CURR == $COLOR ]]
then
	COLOR='prefer-dark'
fi

gsettings set org.gnome.desktop.interface color-scheme $COLOR
