#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

#=================================================================================
#title           :bashrc
#description     :This script will initiate your custom bash configuration
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#usage		 	 :source /path/to/script/bashrc
#bash_version    :bash 4.3.48
#==================================================================================

clear

SCRIPT_NAME="BASHCONFIG"

# current directory path where this script is stored
export DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# specify the location where the bashconfig need to read your machine specific configuration.
# bashconfig stores bashmarks,sshrc and other machine specific configurations in to $DOTFILES_MACHINE_PATH directory
export DOTFILES_MACHINE_PATH="${DOTFILES_MACHINE_PATH:-$HOME/.config/bashconfig}"
if [ ! -d "${DOTFILES_MACHINE_PATH}" ]; then
	mkdir -p ~/.config/bashconfig
fi

# Set $TERM environment
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'
fi

# initiate color codes
source "${DOTFILES_PATH}/submodules/colorcodes/.bashcolors"

_os_config() {
	case $(uname) in
	Darwin)
		source "${DOTFILES_PATH}/config/os/mac_x64.sh"

		;;
	Linux)
		source "${DOTFILES_PATH}/config/os/linux_x64.sh"
		;;
	*)
		util log-info "BashConfig" "unknown Operating system $(uname),
			failed to load Operating System specific configurations"
		;;
	esac
}

# ---- Login welcome message ----
_welcome-message() {
	# prints the welcome message

	local hour msg os_spec bash_version
	hour=$(date +%H) # Hour of the day
	msg="GOOD EVENING!"
	if [ $hour -lt 12 ]; then
		msg="GOOD MORNING!"
	elif [ $hour -lt 16 ]; then
		msg="GOOD AFTERNOON!"
	fi

	# Welcome message & system details
	util log-header "${msg} $(util string-upper ${USER})"

	# print System specifications
	${DOTFILES_PATH}/submodules/neofetch/neofetch
}

_init() {

	# Add tools from 'bin/' to PATH
	# XXX: if condition is writtern to avoid duplicating path while reloading bash
	if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
		export PATH=${DOTFILES_PATH}/bin:$PATH
	fi

	_os_config "${_myos}"

	source "${DOTFILES_PATH}/config/defaults.sh"
	source "${DOTFILES_PATH}/config/docker/docker.sh"
	source "${DOTFILES_PATH}/config/python/python.sh"
	source "${DOTFILES_PATH}/config/golang/golang.sh"
	source "${DOTFILES_PATH}/config/autocomplete.sh"

	# Welcome Message
	_welcome-message

}

_init

unset SCRIPT_NAME
unset -f _init _welcome-message _bashmarks_init _os_config _prompt_config
unset -f _sshrc_config _hstr_config _git_config _historyfile_config
