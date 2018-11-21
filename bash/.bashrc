#!/usr/bin/env bash

# Environment Variables
PROMPT_STYLE=extensive


HISTCONTROL=ignorespace:ignoredups

# y	year in 2-digit format
# Y	year in 4-digit format
# m	month in 2-digit format
# d	day in 2-digit format
# T	time in 24-hour format
# %r	date in 12 hour AM/PM format
# %D	date in mm/dd/yy format
HISTTIMEFORMAT="%d-%m-%Y (%T/%r) "
HISTSIZE=1000
HISTFILESIZE=20000

export PROMPT_STYLE

# Source jm-shell custom prompt if it exists.
if [ -f "$HOME/.my_config/jm-shell/ps1" ];then

    # shellcheck disable=1090
    source "$HOME/.my_config/jm-shell/ps1"
fi


# ---- ALIAS ----
# inspiered from https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html


alias ls.all='ls -atshF' #list all files and folders with memory.
alias ls.long='ls -althF' #List all files and folders in long listing format

# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ];then
    alias code='code -n --max-memory 2048'
    alias diff='code -n -d'
    alias edit='code'
fi


# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
alias reboot='sudo reboot'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias apt-get='sudo apt-get'
fi

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias mkdir='mkdir -pv'
alias bc='bc -l'
alias sha1='openssl sha1'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%d-%m-%Y (%T/%r)"'
alias now.utc='date -u +"%d-%m-%Y (%T/%r)"'

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
alias rm='rm -I --preserve-root' # confirmation #
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
alias halt='sudo /sbin/halt'
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


# ---- GIT ----
git config --global color.ui true
git config --global include.path ~/.my_config/git/.gitalias
git config --global help.autocorrect 1
git config --global core.excludesFile ~/.my_config/git/.gitignore
git config --global core.attributesFile ~/.my_config/git/.gitattributes
git config --global commit.template ~/.my_config/git/.gitmessage


