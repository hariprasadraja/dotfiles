#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

set -e -x

_myos="$(uname)"

if [ $_myos -ne Linux ]; then
       exit 1
fi

if [ ! `command -v cowsay` ]; then
    sudo apt-get install cowsay
fi

if [ ! `command -v fortune` ]; then
    sudo apt-get install fortune
fi

if [ ! `command -v figlet` ]; then
    sudo apt-get install figlet
fi

if [ ! `command -v ruby` ]; then
    sudo apt-get install ruby
    if [ ! `command -v lolcat` ]; then
       sudo gem install lolcat
    fi
fi

if [ `command -v git` ]; then
    sudo apt-get install git
fi

if [ `command -v hstr` ]; then
    sudo apt-get install hstr
fi






