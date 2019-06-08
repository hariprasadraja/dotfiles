#!/usr/bin/env bash

source "${BASHCONFIG_PATH}/utils/arrays.sh"
source "${BASHCONFIG_PATH}/utils/colors.sh"
source "${BASHCONFIG_PATH}/utils/file.sh"
source "${BASHCONFIG_PATH}/utils/loops.sh"
source "${BASHCONFIG_PATH}/utils/terminal.sh"
source "${BASHCONFIG_PATH}/utils/strings.sh"

# Kill process listerning on the tcp port $1
# usage:
# u_kill_tcp 80
tcp-kill() {
	if [ -z "${1}" ]; then
		echo "USAGE: util tcp_kill PORT"
		exit 1
	fi

	sudo lsof -t -i tcp:"${1}" -s tcp:listen | sudo xargs kill 2>/dev/null
	echo "Port:${1} Stopped"
}
