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

# Install homebrew

if [ ! `command -v brew` ]; then
  echo "Homebrew is required to run 'hariprasadraja/dotfiles'. Please install it."
  return 0
fi

dependencies=(
  'coreutils'
  'nodejs'
  'git'
  'most'
  'bat'
  'the_silver_searcher'
  'tag-ag'
  'ruby'
  'go'
  'python3'
  'desk'
  'micro'
  'zinit'
  'fzf'
  'fd'
  'wget'
  'lsd'
  'delta'
  'direnv'
  'docker'
  'docker-completion'
  'docker-compose'
  'gojq'
)

# delete this file to install dependencies once again
dependencies_log="/tmp/dependencies.log"
if [ ! -f "$dependencies_log" ]; then
  brew tap aykamko/tag-ag
  brew install $dependencies | tee $dependencies_log
fi

# home brew command not found handler
HB_CNF_HANDLER="$(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER";
fi

export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# Setup aliases
source ${DOTFILES_PATH}/configs/os/alias.sh

function _init_os() {
  case $(uname) in
  Darwin)
    source "${DOTFILES_PATH}/configs/os/darwin.sh"
    ;;
  Linux)
    source "${DOTFILES_PATH}/configs/os/linux.sh"
    ;;
  *)
    util log warn "unknown Operating system %s,
      failed to load Operating System specific configurations" $(uname)
    ;;
  esac
}

_init_os && unset _init_os

function _tag() {
  command tag "$@"
  source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null
}

if [ $(command -v tag) ]; then
  export TAG_SEARCH_PROG=ag # replace with rg for ripgrep
  export TAG_CMD_FMT_STRING='micro {{.Filename}} +{{.LineNumber}}:{{.ColumnNumber}}'
  alias ag=_tag # replace with rg for ripgrep
fi

export EDITOR='micro'
if [ ! -f "/tmp/micro_plugins" ]; then
  micro -plugin install filemanager \
  comment fzf snippets wc misspell \
  monokai-dark joinLines autofmt quickfix \
  jump &> /tmp/micro_plugins

  ln -fs $DOTFILES_PATH/configs/micro/bindings.json $HOME/.config/micro/bindings.json
  ln -fs $DOTFILES_PATH/configs/micro/settings.json $HOME/.config/micro/settings.json
fi

# alias and path for `desk` command
alias task=desk && export DESK_DIR="${DOTFILES_MACHINE_PATH}"


alias cat='bat'
export PAGER='bat --style="header,changes" --decorations="always"'



# Color ls
# auto ls files when gets into a directory.
auto-ls-colorls() {
  lsd --extensionsort --group-directories-first
}

AUTO_LS_COMMANDS=(colorls '[[ -d $PWD/.git ]] && git status-short-all')
alias ls=lsd --extensionsort --group-directories-first

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

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

# always create links interactively
alias ln='ln -i'

# change file properties
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# change to root user
alias root='sudo -i'

alias path='echo -e "$(echo $PATH | tr ":" "\n" | nl)" | fzf'

# Disk aliases
alias df="df -Tha --total"
alias du="du -ach"

if [ $(command -v $(which scp)) ]; then
  # Secure Copy from <source> to <destination>
  # scp -Cpvr <file/directory in local machine> <remote_machine>:<remote_machine_directory>
  alias scp="scp -CTpvr"
fi

# directory and file handling
alias mv='mv -vi'
alias cp="cp -rf"
alias rm='careful_rm -rf'
alias mkdir='mkdir -pv'

# Refer: https://github.com/rothgar/mastering-zsh/blob/master/docs/config/history.md
_historyfile_config() {
  # From: https://www.soberkoder.com/better-zsh-history/

  # setopt -o sharehistory
  # setopt -o incappendhistory
  export HISTFILE=${HOME}/.zsh_history

  # history file size
  export HISTFILESIZE=100000
  # history size in memory
  export HISTSIZE=2000
  export SAVEHIST=$HISTSIZE

  setopt INC_APPEND_HISTORY
  # Don't record an entry that was just recorded again.
  setopt HIST_IGNORE_DUPS
  setopt SHARE_HISTORY
  setopt HIST_IGNORE_SPACE
  # Don't execute immediately upon history expansion.
  setopt HIST_VERIFY
  # Expire duplicate entries first when trimming history.
  setopt HIST_EXPIRE_DUPS_FIRST
}

_historyfile_config && unset -f _historyfile_config

function _history_corrupt_fix() {
  # solution to fix corupt ~/.zsh_history file
  # source: https://shapeshed.com/zsh-corrupt-history-file/
  if [ -f "~/.zhistory" ]; then
    mv ~/.zhistory ~/.zhistory_bad
    strings ~/.zhistory_bad >~/.zhistory
    fc -R ~/.zhistory
    rm ~/.zhistory_bad
  fi
}

git config --global include.path ${DOTFILES_PATH}/configs/git/gitconfig

# Add following color scheme variables for MANPAGES
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0;34m'
export LESS_TERMCAP_se=$'\e[1;35m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0;34m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

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



