#!/usr/bin/env bash

if [ ! $(command -v go) ]; then
    util log-warning "${SCRIPT_NAME}" "'command: go not found'. go configurations are not loaded"
    return
fi

# Downaload via go get
alias goget="go get -u -v -t -f"

__pet-select() {
    BUFFER=$(pet search --query "$READLINE_LINE")
    READLINE_LINE=$BUFFER
    READLINE_POINT=${#BUFFER}
}

# Pet Command Configuration  https://github.com/knqyf263/pet
if [ $(command -v pet) ]; then
    bind -x '"\C-x\C-r": __pet-select'
    alias pet="pet --config ${BASHCONFIG_PATH}/config/golang/pet/config.toml"
else
    util log-warning "${SCRIPT_NAME}" "'command: pet not found'. pet configurations are not loaded"
fi
