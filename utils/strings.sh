#!/usr/bin/env bash
# Author: Hariprasad
# Reference:
# https://github.com/dylanaraps/pure-bash-bible
#
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
