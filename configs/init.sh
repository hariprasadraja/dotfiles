#!/usr/bin/env bash

#=================================================================================
#title           :defaults.sh
#description     :This script contains default aliases and configurations independent of operating system.
#                 These configurations may overwrite the os specific configurations declared inside configs/os/ directory.
#                 please make sure, the default configuration is not overwrittern.
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#usage		 	 :source /path/to/script/defaults/sh
#bash_version    :bash 4.3.48
#==================================================================================


# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# preview directory's content with colorls when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'colorls --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


# Color ls
# auto ls files when gets into a directory.
auto-ls-colorls() {
  colorls -A --gs
}
AUTO_LS_COMMANDS=(colorls '[[ -d $PWD/.git ]] && git status-short-all')


# Add alias if 'code' cmd exist.
if [ -x "$(command -v code)" ]; then
  alias code='code -n --max-memory 4096'
  alias diff='code -n -d'
fi

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ~="cd ~"

alias bc='bc -l'
alias sha1='openssl sha1'
alias h='history'

now() {
  echo -e "TODAY: $(date +"%d-%m-%Y")"
  echo -e "$(date +"(24-hrs: %T  | 12-hrs: %r)")"
  echo -e "$(date -u +"(24-hrs: %T | 12-hrs: %r)")"
}

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

# always create links interactively
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
alias mv='mv -vi'
alias cp='cp -vi'
alias mkdir='mkdir -pv'

_historyfile_config() {
  # From: https://www.soberkoder.com/better-zsh-history/

  # setopt -o sharehistory
  # setopt -o incappendhistory
  export HISTFILE=${HOME}/.zsh_history
  export HISTFILESIZE=100000 # This is for Zsh
  export SAVEHIST=1000

  setopt INC_APPEND_HISTORY
  export HISTTIMEFORMAT="[%F %T] "

  setopt EXTENDED_HISTORY
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_FIND_NO_DUPS
}
_historyfile_config && unset -f _historyfile_config

_git_config() {
  if [ ! $(command -v git) ]; then
    util log-warning "${SCRIPT_NAME}" "'command: git not found'. git configurations are not loaded"
    return
  fi

  # synchronize the global git configuration changes to your local machine
  rsync -q -u -r -h ${DOTFILES_PATH}/configs/git ${DOTFILES_PATH}/machine/

  git config --global include.path ${DOTFILES_MACHINE_PATH}/git/gitconfig
  git config --global core.excludesfile ${DOTFILES_MACHINE_PATH}/git/gitignore
  git config --global commit.template ${DOTFILES_MACHINE_PATH}/git/gitmessage
  git config --global delta.side-by-side true # delta diff file viewer

  # for security reasons, setting this git directory accessible only on user level
  chmod 0700 /home/harajara/dotfiles/machine/git
  git config --global credential.helper 'cache --timeout 28800 --socket ${DOTFILES_MACHINE_PATH}/git/socket'
}

_git_config && unset -f _git_config

# _hstr_config() {

#     if [ ! $(command -v hstr) ]; then
#         util log-warning "${SCRIPT_NAME}" "'command: hstr not found'. hstr configurations are not loaded"
#         return
#     fi

#     HISTFILESIZE=10000
#     HISTSIZE=${HISTFILESIZE}
#     export HSTR_CONFIG=hicolor,case-sensitive,no-confirm,raw-history-view,warning

#     #if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
#     if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

#     # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
#     if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
# }
# _hstr_config && unset -f _hstr_config

# ---- Bashmarks (Directory Bookmark Manager) Setup ----
# _bashmarks_init() {

#     # Default directory bookmarks
#     export DIR_config="${DOTFILES_PATH}"
#     export DIR_bashconfig="${DOTFILES_MACHINE_PATH}"
#     export DIR_home="$HOME"

#     # SDIRS stores the bookmarks of directory, bashmarks will create SDIRS, if it does not exist
#     export SDIRS="${DOTFILES_MACHINE_PATH}/bashmarks.sh"

#     source "${DOTFILES_PATH}/submodules/bashmarks/bashmarks.sh"
# }
# _bashmarks_init && unset -f _bashmarks_init

_sshrc_config() {
  #
  # _sshrc_config provides configuration for sshrc tool in bin/ directory
  # It creates a .sshrc file and stores it in DOTFILES_MACHINE_PATH location.
  # when you try ssh(alias of sshrc) or sshrc to connect to remote machine,
  # .sshrc file will run in that remote machine to initaite bashconfig
  #

  if [ -f "${DOTFILES_MACHINE_PATH}/.sshrc" ]; then
    return
  fi

  touch "${DOTFILES_MACHINE_PATH}/.sshrc"
    cat <<EOF >>${DOTFILES_MACHINE_PATH}/.sshrc
#!/usr/bin/env bash

echo "Setting up BashConfig for this Remote machine...."
# removing all aliases
unalias -a

. "$DOTFILES_PATH/bashrc"
EOF

  chmod +x ${DOTFILES_MACHINE_PATH}/.sshrc
}

# _sshrc_config && unset -f _sshrc_config

source "${DOTFILES_PATH}/configs/docker/docker.sh"

# Add following color scheme variables for MANPAGES
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0;34m'
export LESS_TERMCAP_se=$'\e[1;35m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0;34m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Set custom desk directory to the machine path
export DESK_DIR="${DOTFILES_MACHINE_PATH}"

# creating machine/init.sh
if [ ! -f "${DOTFILES_PATH}/machine/init.sh" ]; then
    cat >${DOTFILES_PATH}/machine/init.sh <<_EOF
#
#  Write you Machine Dependent - Non Persistent Scripts Here
#
# Most of the needed functionalies are added in the dotfiles but still you may # need some custom scripts that are dependent on the current OS or your current # machine to run. You can write those scripts in

   # ${DOTFILES_PATH}/machine/init.sh

# It runs post initialization and configuration after initializing the dotfiles

# ${DOTFILES_PATH}/machine directory is git ignored by default. I will remain in you local machine. please take backup periodicaly to prevent any loss

_EOF

fi
