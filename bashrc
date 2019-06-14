#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

clear

_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
export BASHCONFIG_PATH=${BASHCONFIG_PATH:-$_dir}

_historyfile_config() {

	# %Y	year in 4-digit format
	# %m	month in 2-digit format,
	# %d	day in 2-digit format
	# %r date in 12 hour AM/PM format,
	HISTTIMEFORMAT="%d-%m-%Y %r >>> "
	HISTCONTROL=ignorespace:ignoredups
}

_prompt_config() {
	# Bash Prompt - You can use any one
	export PROMPT_STYLE=extensive
	source "${BASHCONFIG_PATH}/prompt/jm-shell/ps1" || source "${BASHCONFIG_PATH}/prompt/mathiasbynens/.bash_prompt"
}

_git_config() {
	git config --global include.path ${BASHCONFIG_PATH}/git/gitconfig
	git config --global core.excludesfile ${BASHCONFIG_PATH}/git/gitignore
	git config --global commit.template ${BASHCONFIG_PATH}/git/gitmessage
	git config --global credential.helper 'store --file ${BASHCONFIG_PATH}/git/credentials'
}

_hstr_config() {
	alias hh=hstr # hh to be alias for hstr
	export HSTR_CONFIG=hicolor,case-sensitive,no-confirm,raw-history-view,warning
	HISTFILESIZE=10000
	HISTSIZE=${HISTFILESIZE}

	# ensure synchronization between Bash memory and history file
	# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

	#if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
	if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

	# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
	if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
}

_os_config() {
	if [ "${1}" = "Darwin" ]; then
		source "${BASHCONFIG_PATH}/config/mac_x64.sh"
		return
	fi

	source "${BASHCONFIG_PATH}/config/linux_x64.sh"
}

# ---- Bashmarks (Directory Bookmark Manager) Setup ----
_bashmarks_init() {

	# Default directory bookmarks
	export DIR_config="${BASHCONFIG_PATH}"
	export DIR_home="$HOME"
	export DIR_notebook="$HOME/Documents/Notebook"
	export DIR_documents="$HOME/Documents"
	export DIR_downloads="$HOME/Downloads"
	export DIR_gobin="$GOPATH/bin"
	export DIR_gosrc="$GOPATH/src"

	# save newly created bashmarks in '${SDIRS}'
	if [ "$SDIRS" = "" ]; then
		case ${_myos} in
		Darwin)
			export SDIRS="${BASHCONFIG_PATH}/dotfiles/.bashmarks_mac.sh"
			;;
		Linux)
			export SDIRS="${BASHCONFIG_PATH}/dotfiles/.bashmarks_linux.sh"
			;;
		*)
			util log-info "BashConfig" "creating file ${SDIRS} for storing bookmarks"
			touch $SDIRS
			;;
		esac
	fi

	source "${BASHCONFIG_PATH}/submodules/bashmarks/bashmarks.sh"
}

# ---- Login welcome message ----
_welcome-message() {
	# prints the welcome message

	# args
	# $1 - starting time of the script
	# $2 - operating system name eg: '$(uname)'

	local hour msg os_spec bash_version
	hour=$(date +%H) # Hour of the day
	msg="GOOD EVENING!"
	if [ $hour -lt 12 ]; then
		msg="GOOD MORNING!"
	elif [ $hour -lt 16 ]; then
		msg="GOOD AFTERNOON!"
	fi

	os_spec="uname -r -p -m"
	bash_version=$(bash --version | head -n1 | cut -d" " -f2-5)

	# Welcome message & system details
	util log-header "${msg} $(util string-upper ${USER})"
	echo -e "Today, \t$(date +"%x %X %p %:::z")\n\t$(date -u +"%x %X %p %:::z")"
	echo -e "Kernal, ${2} v$(${os_spec})"
	echo -e "${bash_version}"
	echo "Hurray! Bash Config Loads in  $(echo "$(date +%s.%N) - ${1}" | bc -l) seconds"
}

_coreutils_tool_exist() {
	# package coreutils contains various commands that works exactly like in
	#linux machines for mac os. If it is installed then use those commands.
	#This will overwrite some default macos commands with gnu commands
	# XXX: Make sure the coreutils has been installed properly

	if [[ ${1} == "Darwin" ]]; then
		coreutils="$(brew --prefix coreutils)/libexec/gnubin"
		if [[ -d ${coreutils} && ${coreutils} != "" ]]; then
			export PATH=${coreutils}:$PATH
		else
			util log-error "BashConfig" "coreutils not found, Aborting...
			package coreutils contains various commands that works exactly like in
			linux machines for mac os. BashConfig requiers these commands for smooth execution.
			It will overwrite some default macos commands with gnu commands
			please download and install 'coreutils'
		"
			echo "false"
		fi
	fi
}

# initialize the bashconfig
_init() {

	# Add tools from 'bin/' to PATH
	# XXX: avoid duplicating path while reloading bash
	if [[ "${PATH}" != *"${BASHCONFIG_PATH}/bin"* ]]; then
		export PATH=${BASHCONFIG_PATH}/bin:$PATH
	fi

	local _myos="$(uname)"

	_exist="$(_coreutils_tool_exist ${_myos})"
	if [ "$_exist" = "false" ]; then
		return 1
	fi

	local _startTime="$(date +%s.%N)"

	# Configurations
	_historyfile_config
	_prompt_config

	if [ $(command -v git) ]; then
		_git_config
	fi

	if [ $(command -v hstr) ]; then
		_hstr_config
	fi

	_os_config "${_myos}"

	# Submodules
	_bashmarks_init

	# Auto completion
	source "${BASHCONFIG_PATH}/config/autocomplete.sh"

	# Welcome Message
	_welcome-message "${_startTime}" "${_myos}"
}
_init
