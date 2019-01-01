#!/usr/bin/env bash

source "$HOME/.bash-config/utils/arrays.sh"
source "$HOME/.bash-config/utils/colors.sh"
source "$HOME/.bash-config/utils/file.sh"
source "$HOME/.bash-config/utils/loops.sh"
source "$HOME/.bash-config/utils/terminal.sh"
source "$HOME/.bash-config/utils/strings.sh"


# Kill all process listerning on the port $1
# usage:
# u_kill_all 80
u_kill_all() {
    echo "killing port: '${1}' "
    sudo lsof -t -i tcp:"${1}" -s tcp:listen | sudo xargs kill
}
