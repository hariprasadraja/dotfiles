#!/usr/bin/env bash
# ---- Personal Configured Alias ----
# inspiered from https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# enable color support of ls and also add handy aliases
dircolors="${CONFIG_PATH}/resources/dircolors/ansi-universal"
if [ -x gdircolors ]; then
	test -r "${dircolors}" && eval "$(gdircolors ${dircolors})"
	alias ls='gls -ctFsh --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto' #Interpret  PATTERN  as  a  list  of  fixed strings, separated by newlines
	alias egrep='egrep --color=auto' #Interpret PATTERN as an extended regular  expression
fi

alias la='ls -atFsh'  #list all files and folders (both hidden) with memory.
alias ll='ls -altFsh' #List all files and folders in long listing format

# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ]; then
	alias code='code -n --max-memory 4096'
	alias diff='code -n -d'
fi

# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
	alias update='brew update && brew upgrade'
	alias uninstall='brew uninstall'
fi

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

alias now='date +"%d-%m-%Y (24-hrs: %T  | 12-hrs: %r)"'
alias nowutc='date -u +"%d-%m-%Y (24-hrs: %T | 12-hrs: %r)"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

alias ps.aux='ps aux --sort=-pcpu,+pmem'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# show opened ports
alias ports='netstat -tulanp'

## shortcut for iptables and pass it via sudo
alias ipt='sudo /sbin/iptables' # display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'

# do not delete / or prompt if deleting more than 3 files at a time #
# alias rm='rm -I --preserve-root' # confirmation #
alias mv='mv -i'
alias cp='cp -i'

alias ln='ln -i' # Parenting changing perms on / #

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias root='sudo -i'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
# alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

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

# Import Aliases for Docker
source "${CONFIG_PATH}/bash/docker_alias.sh"
