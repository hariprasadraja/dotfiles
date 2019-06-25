#!/usr/bin/env bash

# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ]; then
    alias code='code -n --max-memory 4096'
    alias diff='code -n -d'
fi

# Rewrite the Builtin cd command to list directory after switching into it
cd() {
    builtin cd "$@" && ls -ctFsh --color=auto
}

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ~="cd ~"

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

## shortcut for iptables and pass it via sudo
if [ $(command -v $(which iptables)) ]; then
    alias ipt='sudo $(which iptables)' # display all rules #
    alias iptlist='sudo $(which iptables) -L -n -v --line-numbers'
    alias iptlistin='sudo $(which iptables) -L INPUT -n -v --line-numbers'
    alias iptlistout='sudo $(which iptables) -L OUTPUT -n -v --line-numbers'
    alias iptlistfw='sudo $(which iptables) -L FORWARD -n -v --line-numbers'
fi

# show all opened ports
alias ports='netstat -tulanp'

alias ln='ln -i'

# change file properties
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# change to root user
alias root='sudo -i'

# pass default options to free #
if [ $(command -v $(which free)) ]; then
    alias free='free -m -l -t'
fi

# ps command aliases
if [ $(command -v $(which ps)) ]; then
    alias ps="ps auxf --sort=-pcpu,+pmem"

    ## get top process eating memory
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'

    ## get top process eating cpu ##
    alias pscpu='ps auxf | sort -nr -k 3'
    alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
fi

# Pretty Print path
alias path='util log-header "PATH(s)" && echo -e "$(echo $PATH | tr ":" "\n" | nl)"'

# Disk aliases
alias df="df -Tha --total"
alias du="du -ach"

# print the environment variables in sorted order
envs() {
    if [ -n "${@}" ]; then
        env ${@} | sort
        return
    fi

    env -v | sort
}

if [ $(command -v $(which scp)) ]; then
    # Secure Copy from <source> to <destination>
    # scp -Cpvr <file/directory in local machine> <remote_machine>:<remote_machine_directory>
    alias scp="scp -CTpvr"
fi

# directory and file handling
alias rm='rm -rfvI'
alias mv='mv -vi'
alias cp='cp -vi'
alias mkdir='mkdir -pv'

if [ $(command -v $(which ccat)) ]; then
    alias cat='$(which ccat)'
else
    util log-warning "${SCRIPT_NAME}" "'command: ccat not found'. sorry, unable to colorize the cat output"
fi

# Use NeoVim if it is installed Neither do vim
vimrc='${BASHCONFIG_PATH}/config/vimrc'
if [ $(command -v $(which nvim)) ]; then
    alias vim="$(which nvim) -u ${vimrc}"
else
    alias vim="$(which nvim) -u ${vimrc}"
fi

# Use hstr tool if exist
if [ $(command -v $(which hstr)) ]; then
    alias hh=hstr # hh to be alias for hstr
else
    alias hh=history
fi
