#!/usr/bin/env bash
# ---- Personal Configured Alias ----
# inspiered from https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# enable color support of ls and also add handy aliases
dircolor="${CONFIG_PATH}/resources/dircolors/ansi-universal"
if [ -x /usr/local/opt/coreutils/libexec/gnubin/dircolors ]; then
	test -r "${dircolors}" && eval "$(/usr/local/opt/coreutils/libexec/gnubin/dircolors ${dircolor})"
	alias ls='gls -ctFsh --color=auto' #List all files sorted by last modified.
	alias la='ls -atFsh --color=auto'  #list all files and folders (both hidden) with memory.
	alias ll='ls -altFsh --color=auto' #List all files and folders in long listing format

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto' #Interpret  PATTERN  as  a  list  of  fixed strings, separated by newlines
	alias egrep='egrep --color=auto' #Interpret PATTERN as an extended regular  expression
fi

# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ]; then
	alias code='code -n --max-memory 4096'
	alias diff='code -n -d'
fi

alias update='brew update && brew upgrade'
alias uninstall='brew uninstall'

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
alias path='echo -e ${PATH//:/\\n}'

alias now='date +"%d-%m-%Y (24-hrs: %T  | 12-hrs: %r)"'
alias nowutc='date -u +"%d-%m-%Y (24-hrs: %T | 12-hrs: %r)"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

alias ps='ps aux --sort=-pcpu,+pmem'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

alias root='sudo -i'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## python
alias python='python3'

# Exec Path
alias path='util log-header "PATH(s)" && echo -e "$(echo $PATH | tr ":" "\n" | nl)"'

# print colorized output for programs
alias cat="ccat"

# ---- Import Aliases for Docker ----
source ${CONFIG_PATH}/config/docker.sh

# Import Aliases for Docker
source "${CONFIG_PATH}/bash/docker_alias.sh"

# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
	alias update='brew update && brew upgrade'
	alias remove='brew uninstall'
	alias install='brew install'

	# do not delete / or prompt if deleting more than 3 files at a time #
	alias rm='sudo rm='rm -rfvI''
	alias mv='sudo mv -i'
	alias cp='sudo cp -i'
fi
