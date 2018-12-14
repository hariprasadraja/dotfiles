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
trim_string() {
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

#trim_all trims all white-space from string and truncate spaces
trim_all() {
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}

regex() {
    # Usage: regex "string" "regex"
    [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

is_hex_color() {
    if [[ "$1" =~ ^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$ ]]; then
        printf '%s\n' "${BASH_REMATCH[1]}"
    else
        printf '%s\n' "error: $1 is an invalid color."
        return 1
    fi
}

split() {
   # Usage: split "string" "delimiter"
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

lower() {
    # Usage: lower "string"
    printf '%s\n' "${1,,}"
}

upper() {
    # Usage: upper "string"
    printf '%s\n' "${1^^}"
}

trim_quotes() {
    # Usage: trim_quotes "string"
    : "${1//\'}"
    printf '%s\n' "${_//\"}"
}

strip_all() {
    # Usage: strip_all "string" "pattern"
    printf '%s\n' "${1//$2}"
}

strip() {
    # Usage: strip "string" "pattern"
    printf '%s\n' "${1/$2}"
}

lstrip() {
    # Usage: lstrip "string" "pattern"
    printf '%s\n' "${1##$2}"
}

rstrip() {
    # Usage: rstrip "string" "pattern"
    printf '%s\n' "${1%%$2}"
}
