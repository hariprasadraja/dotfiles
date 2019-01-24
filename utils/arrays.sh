#!/usr/bin/env bash
# Author: Hariprasad
# Reference:
# https://github.com/dylanaraps/pure-bash-bible

# <---- Arrays Utility Functions ---->

array-reverse() {
	# Usage: reverse_array "array"
	shopt -s extdebug
	f() (printf '%s\n' "${BASH_ARGV[@]}")
	f "$@"
	shopt -u extdebug
}

array-distinct() {
	# Usage: remove_array_dups "array"
	declare -A tmp_array

	for i in "$@"; do
		[[ "$i" ]] && IFS=" " tmp_array["${i:- }"]=1
	done

	printf '%s\n' "${!tmp_array[@]}"
}

array-random() {
	# Usage: random_array_element "array"
	local arr=("$@")
	printf '%s\n' "${arr[RANDOM % $#]}"
}

array-cycle() {
	printf '%s ' "${arr[${i:=0}]}"
	((i = i >= ${#arr[@]} - 1 ? 0 : ++i))
}
