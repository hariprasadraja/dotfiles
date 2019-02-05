#!/usr/bin/env bash

file-first-N-lines() {
	# Usage: head "n" "file"
	mapfile -tn "$1" line <"$2"
	printf '%s\n' "${line[@]}"
}

file-last-N-lines() {
	# Usage: tail "n" "file"
	mapfile -tn 0 line <"$2"
	printf '%s\n' "${line[@]: -$1}"
}

file-ln-count() {
	# Usage: lines "file"
	mapfile -tn 0 lines <"$1"
	printf '%s\n' "${#lines[@]}"
}

file-extract() {
	# Usage: extract file "opening marker" "closing marker"
	while IFS=$'\n' read -r line; do
		[[ "$extract" && "$line" != "$3" ]] &&
			printf '%s\n' "$line"

		[[ "$line" == "$2" ]] && extract=1
		[[ "$line" == "$3" ]] && extract=
	done <"$1"
}

file-get-functions() {
	# Usage: get_functions
	IFS=$'\n' read -d "" -ra functions < <(declare -F)
	printf '%s\n' "${functions[@]//declare -f /}"
}

#read environment and set it into directory
function file-set-environment() {
	if [ ! -e $1 ]; then
		echo $1"- does not exist"
	fi
	set -a
	file="temp.env"
	sed 's/(/\\(/g; s/)/\\)/g; s/?/\\?/g; s/&/\\&/g; s/\$/\\$/g;' $1 &>$file
	cat $file
	. $file
	rm $file
}

function file-golang-stackparse() {
	if [ ! -f "${1}" ]; then
		echo "file does not exist"
		exit 1
	fi

	file="temp.txt"
	cat ${1} | awk '{gsub(/\\n/,"\n")}1' | awk '{gsub(/\\/,"")}1' | awk '{gsub(/\{/,"\n{")}1' | awk '{gsub(/t\/go\/src\//,"\t")}1' &>$file
	cat $file
}

file-open-csv() {
	# file-open-csv prints the csv file into the human readable format
	# $1 should be a valid csv file.
	local filename=$(basename -- "$1")
	local errMsg=""
	if [[ "${filename}" == "" ]]; then
		errMsg="file name should not be empty"
		__handle-error "${errMsg}"
	fi

	local extension="${filename##*.}"
	if [[ "${extension}" != "csv" ]]; then
		errMsg="file extension should be '.csv' but got '${extension}'"
		__handle-error "${errMsg}" $(${FUNCNAME[0]})
	fi

	column -s, -t <$1 | less -#2 -N -S
}
