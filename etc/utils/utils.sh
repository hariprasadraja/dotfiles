#!/usr/bin/env bash
# Reference:
# https://github.com/dylanaraps/pure-bash-bible

# <---- Arrays Utility Functions ---->

# bold=$(tput bold)
# underline=$(tput sgr 0 1)
# reset=$(tput sgr0)

# purple=$(tput setaf 171)
# red=$(tput setaf 1)
# green=$(tput setaf 76)
# tan=$(tput setaf 3)
# blue=$(tput setaf 38)

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

term-size() {
	# Usage: get_term_size

	# (:;:) is a micro sleep to ensure the variables are
	# exported immediately.
	shopt -s checkwinsize
	(
		:
		:
	)
	printf '%s\n' "$LINES $COLUMNS"
}

window-size() {
	# Usage: get_window_size
	printf '%b' "${TMUX:+\\ePtmux;\\e}\\e[14t${TMUX:+\\e\\\\}"
	IFS=';t' read -d t -t 0.05 -sra term_size
	printf '%s\n' "${term_size[1]}x${term_size[2]}"
}

window-cursor-pos() {
	# Usage: get_cursor_pos
	IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
	printf '%s\n' "$x $y"
}

sleep() {
	cmd=$(command -v sleep)
	if [ "${cmd}" ]; then
		sleep "${1}"
		exit 0
	fi

	read -rst "${1:-1}" -N 999
	exit 0
}

# <---- String Utility Functions ---->

# trim_string trims the leading and tailing white spaces in a string
# Usage: $ trim_string "    Hello,  World    "
# Hello,  World
# $ name="   John Black  "
# $ trim_string "$name"
# John Black
string-trim() {
	: "${1#"${1%%[![:space:]]*}"}"
	: "${_%"${_##*[![:space:]]}"}"
	printf '%s\n' "$_"
}

#trim_all trims all white-space from string and truncate spaces
string-trim-all() {
	set -f
	set -- $*
	printf '%s\n' "$*"
	set +f
}

# regex matching can be used to replace sed for a large number of use-cases.
# CAVEAT: This is one of the few platform dependent bash features. bash will use whatever regex engine is installed on the user's system. Stick to POSIX regex features if aiming for compatibility.
# CAVEAT: This example only prints the first matching group. When using multiple capture groups some modification is needed.
regex() {
	# Usage: regex "string" "regex"
	[[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

is-hex-color() {
	if [[ "$1" =~ ^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$ ]]; then
		printf '%s\n' "${BASH_REMATCH[1]}"
	else
		printf '%s\n' "error: $1 is an invalid color."
		return 1
	fi
}

string-split() {
	# Usage: split "string" "delimiter"
	IFS=$'\n' read -d "" -ra arr <<<"${1//$2/$'\n'}"
	printf '%s\n' "${arr[@]}"
}

string-lower() {
	# Usage: lower "string"
	printf '%s\n' "${1,,}"
}

# u_upper converts input into uppercase
string-upper() {
	# Usage: upper "string"
	echo "${1}" | awk '{print toupper($0)}'
}

string-trim-quotes() {
	# Usage: trim_quotes "string"
	: "${1//\'/}"
	printf '%s\n' "${_//\"/}"
}

string-strip-all() {
	# Usage: strip_all "string" "pattern"
	printf '%s\n' "${1//$2/}"
}

string-strip() {
	# Usage: strip "string" "pattern"
	printf '%s\n' "${1/$2/}"
}

string-strip-left() {
	# Usage: lstrip "string" "pattern"
	printf '%s\n' "${1##$2}"
}

string-strip-right() {
	# Usage: rstrip "string" "pattern"
	printf '%s\n' "${1%%$2}"
}

typeof-var() {
	local type_signature=$(declare -p "$1" 2>/dev/null)
	msg=""
	if [[ "$type_signature" =~ "declare --" ]]; then
		msg="string"
	elif [[ "$type_signature" =~ "declare -a" ]]; then
		msg="array"
	elif [[ "$type_signature" =~ "declare -A" ]]; then
		msg="map"

	elif [[ "$type_signature" =~ "declare -F" ]]; then
		msg="function"
	fi
}

# Kill process listerning on the tcp port $1
# usage:
# u_kill_tcp 80
tcp-kill() {
	if [ -z "${1}" ]; then
		echo "USAGE: util tcp_kill PORT"
		exit 1
	fi

	sudo lsof -t -i tcp:"${1}" -s tcp:listen | sudo xargs kill 2>/dev/null
	echo "Port:${1} Stopped"
}
