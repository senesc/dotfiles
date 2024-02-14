#!/bin/bash

LIST=$(hyprctl clients -j | jq -r '.[] | .address + "\t[" + .class + "] - " + .title')
# echo "$LIST"
SEL=$(echo "$LIST" | cut -f 2 | wofi --dmenu --define 'dmenu-print_line_num=true' --define 'insensitive=true' --define 'matching=fuzzy')
if [[ $? -ne 0 ]]; then
	exit
fi
SEL=$((SEL+1))
# echo $SEL
# echo "$LIST" | cut -f 1 | awk "NR==$SEL"
hyprctl dispatch focuswindow address:$(echo "$LIST" | cut -f 1 | awk "NR==$SEL")
