#!/usr/bin/env bash

print-N() {
	VAR=$1
	for ((i = 0; i <= VAR; i++)); do
		printf '%s\n' "$i"
	done
}

array-print() {
	arr=$1
	for element in "${arr[@]}"; do
		printf '%s\n' "$element"
	done
}

file-print() {
	while read -r line; do
		printf '%s\n' "$line"
	done <"file"
}
