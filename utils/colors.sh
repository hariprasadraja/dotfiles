#!/usr/bin/env bash

hex-to-rgb() {
	# Usage: hex_to_rgb "#FFFFFF"
	#        hex_to_rgb "000000"
	: "${1/\#/}"
	((r = 16#${_:0:2}, g = 16#${_:2:2}, b = 16#${_:4:2}))
	printf '%s\n' "$r $g $b"
}

rgb-to-hex() {
	# Usage: rgb_to_hex "r" "g" "b"
	printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#
# Headers and  Logging
#

log-header() {
	printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}

log-arrow() {
	printf "➜ $@\n"
}

log-success() {
	printf "${green}✔ %s${reset}\n" "$@"
}

log-error() {
	printf "${red}✖ %s${reset}\n" "$@"
}

log-warning() {
	printf "${tan}➜ %s${reset}\n" "$@"
}

log-underline() {
	printf "${underline}${bold}%s${reset}\n" "$@"
}

log-bold() {
	printf "${bold}%s${reset}\n" "$@"
}

log-note() {
	printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}
