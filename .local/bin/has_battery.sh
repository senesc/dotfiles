#!/bin/bash
# Checks for presence of battery, i.e. if current device is a laptop.
# Returns 0 if any battery is available, 1 otherwise.

for d in $(ls /sys/class/power_supply/)
do
	d=/sys/class/power_supply/$d/type
	if grep -q 'Battery' $d; then
		# echo "Battery found at $d"
		exit 0
	# else
	# 	echo "$d not a battery"
	fi
done
exit 1
