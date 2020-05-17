#!/usr/bin/env bash

if [ ! $(command -v go) ]; then
    util log-warning "${SCRIPT_NAME}" "'command: go not found'. go configurations are not loaded"
    return
fi

# Downaload via go get
alias gget="go get -u -v -t -f"

if [ -z $(pgrep bashhub-server) ]; then
    nohup bashhub-server --addr ":9001" --db "${DOTFILES_PATH}/historydb/history.db" &
fi
