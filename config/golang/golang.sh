#!/usr/bin/env bash

if [ ! $(command -v go) ]; then
    util log-warning "${SCRIPT_NAME}" "'command: go not found'. go configurations are not loaded"
    return
fi

# Downaload via go get
alias gget="go get -u -v -t -f"
