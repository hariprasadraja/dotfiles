#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

set -e -x

_myos="$(uname)"

if [ $_myos -ne Linux ]; then
	printf "you are not in a Linux system \n exiting..."
	exit 1
fi

{
	sudo -i
	update
	apt-get install cowsay
	apt-get install fortune
	apt-get install figlet
	apt-get install ruby
	apt-get install lolcat
	apt-get install git
	apt-get install hstr
	apt-get install jq
	apt-get install emojify
} &>.setuplog.txt
