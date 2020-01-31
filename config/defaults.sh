#!/usr/bin/env bash

#=================================================================================
#title           :defaults.sh
#description     :This script contains default aliases and configurations independent of operating system.
#                 These configurations may overwrite the os specific configurations declared inside config/os/ directory.
#                 please make sure, the default configuration is not overwrittern.
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#usage		 	 :source /path/to/script/defaults/sh
#bash_version    :bash 4.3.48
#==================================================================================

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
alias rm='rm -rfv'
alias mv='mv -vi'
alias cp='cp -vi'
alias mkdir='mkdir -pv'

if [ $(command -v $(which ccat)) ]; then
    alias cat='$(which ccat)'
elif [ $(command -v $(which bat)) ]; then
    alias cat='$(which bat) --theme=ansi-light'
fi

# Use NeoVim if it is installed Neither do vim
vimrc='${BASHCONFIG_PATH}/config/vimrc'
if [ $(command -v $(which nvim)) ]; then
    alias vim="$(which nvim) -u ${vimrc}"
else
    alias vim="vim -u ${vimrc}"
fi

_historyfile_config() {

    # %Y	year in 4-digit format
    # %m	month in 2-digit format,
    # %d	day in 2-digit format
    # %r date in 12 hour AM/PM format,
    HISTTIMEFORMAT="%d-%m-%Y %r >>> "
    HISTCONTROL=ignorespace:ignoredups
}
_historyfile_config && unset -f _historyfile_config

# _prompt_config() {
#     #
#     # _prompt_config initializes the bashprompt from /config/prompt/bash_prompt.sh
#     #

#     source "${BASHCONFIG_PATH}/config/prompt/bash_prompt.sh"
# }
# _prompt_config && unset -f _prompt_config

_git_config() {
    if [ ! $(command -v git) ]; then
        util log-warning "${SCRIPT_NAME}" "'command: git not found'. git configurations are not loaded"
        return
    fi

    git config --global include.path ${BASHCONFIG_PATH}/config/git/gitconfig
    # git config --global core.excludesfile ${BASHCONFIG_PATH}/config/git/gitignore
    git config --global commit.template ${BASHCONFIG_PATH}/config/git/gitmessage
    git config --global credential.helper 'store --file ${BASHCONFIG_DOTFILES}/gitcredentials'
}
_git_config && unset -f _git_config

_hstr_config() {

    if [ ! $(command -v hstr) ]; then
        util log-warning "${SCRIPT_NAME}" "'command: hstr not found'. hstr configurations are not loaded"
        return
    fi

    HISTFILESIZE=10000
    HISTSIZE=${HISTFILESIZE}
    export HSTR_CONFIG=hicolor,case-sensitive,no-confirm,raw-history-view,warning

    #if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
    if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

    # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
    if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
}
_hstr_config && unset -f _hstr_config

# ---- Bashmarks (Directory Bookmark Manager) Setup ----
_bashmarks_init() {

    # Default directory bookmarks
    export DIR_config="${BASHCONFIG_PATH}"
    export DIR_bashconfig="${BASHCONFIG_DOTFILES}"
    export DIR_home="$HOME"

    # SDIRS stores the bookmarks of directory, bashmarks will create SDIRS, if it does not exist
    export SDIRS="${BASHCONFIG_DOTFILES}/bashmarks.sh"

    source "${BASHCONFIG_PATH}/submodules/bashmarks/bashmarks.sh"
}
# _bashmarks_init && unset -f _bashmarks_init

_sshrc_config() {
    #
    # _sshrc_config provides configuration for sshrc tool in bin/ directory
    # It creates a .sshrc file and stores it in BASHCONFIG_DOTFILES location.
    # when you try ssh(alias of sshrc) or sshrc to connect to remote machine,
    # .sshrc file will run in that remote machine to initaite bashconfig
    #

    if [ -f "${BASHCONFIG_DOTFILES}/.sshrc" ]; then
        return
    fi

    touch "${BASHCONFIG_DOTFILES}/.sshrc"
    cat <<EOF >>${BASHCONFIG_DOTFILES}/.sshrc
#!/usr/bin/env bash

echo "Setting up BashConfig for this Remote machine...."
# removing all aliases
unalias -a

. "$BASHCONFIG_PATH/bashrc"
EOF

    chmod +x ${BASHCONFIG_DOTFILES}/.sshrc
}

# _sshrc_config && unset -f _sshrc_config

function lcurl() {
    curl "$@" -H 'X-Lens-Debug-Vars: add_query, burst_cache'
}
