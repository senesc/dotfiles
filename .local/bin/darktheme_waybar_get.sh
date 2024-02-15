#!/bin/bash
# Checks if GTK dark theme is enables.
# Output is Waybar-compliant JSON.
# Should work on all Wayland sessions.

sleep 0.3s
LIGHT=$(gsettings get org.gnome.desktop.interface color-scheme)
if [[ $LIGHT == "'prefer-dark'" ]]
then
	# TEXT="      "
	TEXT=""
	TOOLTIP="Dark theme is selected."
	CLASS="dark"
else
	# TEXT="   "
	TEXT=" "
	TOOLTIP="Light theme is selected."
	CLASS="light"
fi

echo "{\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\",\"class\":\"$CLASS\",\"percentage\":0}"
