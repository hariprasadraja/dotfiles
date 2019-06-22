#!/usr/bin/env bash

#=================================================================================
#title           :mac_x64.sh
#description     :This script contains aliases and configuration for mac operating systems
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#bash_version    :bash 4.3.48
# inspiered 	 :https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
#=============================================================================

coreutils="$(brew --prefix coreutils)/libexec/gnubin"
if [[ -d ${coreutils} && ${coreutils} != "" ]]; then
	export PATH=${coreutils}:$PATH
else
	util log-error "BashConfig" "coreutils not found, Aborting...
			package coreutils contains various commands that works exactly like in
			linux machines for mac os. BashConfig requiers these commands for smooth execution.
			It will overwrite some default macos commands with gnu commands
			please download and install 'coreutils'
		"
	echo "false"
fi

# enable color support of ls and also add handy aliases
dircolors="$(brew --prefix coreutils)/libexec/gnubin/dircolors"
dir_color="${BASHCONFIG_PATH}/submodules/dircolors/dircolors.ansi-universal"
if [ -x "${dircolors}" ]; then
	test -r "${dir_color}" && eval "$(${dircolors} ${dir_color})"
	alias ls='ls -ctFsh --color=auto'                     #List all files sorted by last modified.
	alias la='ls -atFsh --color=auto'                     #list all files and folders (both hidden) with memory.
	alias ll='ls -altFsh --color=auto'                    #List all files and folders in long listing format
	alias l.='ls -d .* --color=auto'                      #List only dot files and dot directories
	alias ld="ls -a --color=auto | grep --color=auto '/'" # List only directories

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto' #Interpret  PATTERN  as  a  list  of  fixed strings, separated by newlines
	alias egrep='egrep --color=auto' #Interpret PATTERN as an extended regular  expression
fi

unset dircolors dir_color

# show opened ports
alias ports='netstat -tulanp'

alias ln='ln -i' # Parenting changing perms on / #

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# switch as root user
alias root='sudo -i'

alias df="df -Tha --total"
alias du="du -ach"
alias free="free -mt"
alias ps="ps auxf --sort=-pcpu,+pmem"

# Downaload via go get
alias goget="go get -u -v -t -f"

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

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# print the environment variables in sorted order
envs() {
	if [ -n "${@}" ]; then
		env ${@} | sort
		return
	fi

	env | sort
}

alias update='brew update && brew upgrade'
alias remove='brew uninstall'
alias install='brew install'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -rfvI'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -pv'
