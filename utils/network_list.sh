#!/usr/bin/env bash

declare -a bssids
declare -A ssids
declare -A modes
declare -A chans
declare -A rates
declare -A signals
declare -A bars
declare -A securities

cmd="nmcli device wifi list"

while read -r a b c d e f g h i; do
	if [ ${#bssids[@]} -ge 10 ]; then
		break
	fi
	if [[ -z "$b" ]]; then
		continue
	fi
	if [[ "$a" == "IN-USE" ]]; then
		continue
	fi
	if [[ "$a" == "*" ]]; then
		continue
	fi
	if [[ "$b" == "--" ]]; then
		continue
	fi
	if [[ "$c" != "Infra" ]]; then
		continue
	fi
	
	bssids+=( "${a}" )
	ssids["${a}"]="${b}"
	modes["${a}"]="${c}"
	chans["${a}"]="${d}"
	rates["${a}"]="${e} ${f}"
	signals["${a}"]="${g}"
	bars["${a}"]="${h}"
	securities["${a}"]="${i}"
done < <($cmd)

output="["

for i in "${!bssids[@]}"
do
	id="${bssids[$i]}"
	output="${output}{\"bssid\":\"${id}\", \"ssid\":\"${ssids[$id]}\", \"bars\":\"${bars[$id]}\", \"signal\": \"${signals[$id]}\", \"rate\": \"${rates[$id]}\"}"
	
	if [ "$((i+1))" -ne "${#bssids[@]}" ]; then
		output="${output}, "
	fi
done

output="${output}]"

echo "$output"
