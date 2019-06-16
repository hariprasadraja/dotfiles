#!/usr/bin/env bash
# ---- Personal Configured Alias ----
# inspiered from https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# enable color support of ls and also add handy aliases
dircolors="$(brew --prefix coreutils)/libexec/gnubin/dircolors"
dir_color="${BASHCONFIG_PATH}/resources/dircolors/ansi-universal"
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

# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ]; then
	alias code='code -n --max-memory 4096'
	alias diff='code -n -d'
fi

# Rewrite the Builtin cd command to list directory after switching into it
cd() {
	builtin cd "$@" && ls
}

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ~="cd ~"

alias mkdir='mkdir -pv'
alias bc='bc -l'
alias sha1='openssl sha1'
alias h='history'
alias j='jobs -l'

# print current local time in both 24 hrs and 12 hrs format
alias now='date +"%d-%m-%Y (24-hrs: %T  | 12-hrs: %r)"'

# same as now, but prints the utc time
alias nowutc='date -u +"%d-%m-%Y (24-hrs: %T | 12-hrs: %r)"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

# show opened ports
alias ports='netstat -tulanp'

## shortcut for iptables and pass it via sudo
alias ipt='sudo /sbin/iptables' # display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'

alias ln='ln -i' # Parenting changing perms on / #

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# switch as root user
alias root='sudo -i'

# get free memory details
alias meminfo='free -m -l -t'

# get top process which are eating the Memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# get top process eating the CPU
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## python
alias python='python3 || python'

# prints $PATH variable in prettier way
alias path='util log-header "PATH(s)" && echo -e "$(echo $PATH | tr ":" "\n" | nl)"'

# print colorized output for programs
# https://github.com/jingweno/ccat/issues
alias cat="ccat"

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

# ---- Import Aliases for Docker ----
source ${BASHCONFIG_PATH}/config/docker.sh

alias update='brew update && brew upgrade'
alias remove='brew uninstall'
alias install='brew install'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -rfvI'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -pv'
