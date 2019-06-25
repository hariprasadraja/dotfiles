#!/usr/bin/env bash

#=================================================================================
#title           :linux_x64.sh
#description     :This script contains aliases and configuration for linux machines
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#bash_version    :bash 4.3.48
# inspiered 	 :https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
#=============================================================================

# enable color support for those aliases
dir_color="${BASHCONFIG_PATH}/submodules/dircolors/dircolors.ansi-universal"
dircolors="$(which dircolors)"
if [ -x ${dircolors} ]; then
	test -r ${dir_color} && eval "$(${dircolors} -b ${dir_color})"
	alias ls='ls -ctFsh --color=auto'                  #List all files sorted by last modified.
	alias la='ls -atFsh --color=auto'                  #list all files and folders with memory.
	alias ll='ls -altFsh --color=auto'                 #List all files and folders in long listing format
	alias l.='ls -d .* --color=auto'                   #List only dot files and dot directories
	alias ld="ls --color=auto | grep --color=auto '/'" # List only directories

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto' #Interpret  PATTERN  as  a  list  of  fixed strings, separated by newlines
	alias egrep='egrep --color=auto' #Interpret PATTERN as an extended regular  expression

fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# reboot / halt / poweroff
alias restart='shutdown -r +5 "Server will restart in 5 minutes. Please save your work."'
alias poweroff='sudo /sbin/poweroff'
alias shutdown='shutdown -h +5 "Server will shutdown in 5 minutes. Please save your work."'

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## git kraken open##
alias gk='gitkraken -p'

# untar FileName to unpack any .tar file.
# add -z for zip file
alias untar='tar -xvf '

# generate a random, 20-character password for a new online account
alias getpass="openssl rand -base64 20"

# Downloaded a file and need to test the checksum
alias sha='shasum -a 256 '

# Need to test how fast the Internet Is?
alias speed='speedtest-cli --server 2406 --simple --secure'

# External Ip address or Public Ip address
alias ipe='curl ipinfo.io/ip || (curl http://ipecho.net/plain; echo)'

#local ip address
alias ipl="ipconfig getifaddr en0"

# list all ips  this machine
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# print files which are in trash
alias lstrash="gvfs-ls -h trash:///"

alias update='apt update && apt upgrade'
alias install='apt install'
alias remove='apt remove'
