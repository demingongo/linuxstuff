#!/usr/bin/env bash

declare -a devices
declare -A types
declare -A states
declare -A connections

cmd="nmcli device status"

while read -r a b c d; do
	if [[ -z "$a" ]]; then
		continue
	fi
	if [[ "$a" == "lo" ]]; then
		continue
	fi
	if [[ "$c" != "connected" ]]; then
		continue
	fi
	if [[ "$a" != "DEVICE" ]]; then
		devices+=( "${a}" )
		types["${a}"]="${b}"
		states["${a}"]="${c}"
		connections["${a}"]="${d}"
	fi
done < <($cmd)

if [ ${#devices[@]} -gt 0 ]; then
	device=${devices[0]}
	echo "{\"connection\":\"${connections[$device]}\", \"type\":\"${types[$device]}\", \"device\":\"${device}\"}"
else
	echo ""
fi

#for device in "${devices[@]}"
#do
#	echo "$device as ${types[$device]} ${states[$device]} to ${connections[$device]}"
#done
