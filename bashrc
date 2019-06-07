#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

clear
_myos="$(uname)"
if [[ $_myos == "Darwin" ]]; then

	# package coreutils contains various commands that works exactly like in
	# linux machines for mac os. If it is installed then use those commands.
	# This will overwrite some default macos commands with gnu commands
	# XXX: Make sure the coreutils has been installed properly

	coreutils="$(brew --prefix coreutils)/libexec/gnubin"
	if [ -d ${coreutils} ]; then
		export PATH=${coreutils}:$PATH
	fi
fi

start=$(date +%s.%N)

if [ "${CONFIG_PATH}" == "" ]; then
	util log-error "BashConfig" "CONFIG_PATH Env variable must be set to installed location of BashConfig"
	return
fi

# Add bin/ tools to PATH
# XXX: avoid duplicating path while reloading bash
if [[ "${PATH}" != *"${CONFIG_PATH}/bin"* ]]; then
	export PATH=${CONFIG_PATH}/bin:$PATH
fi

# %Y	year in 4-digit format
# %m	month in 2-digit format,
# %d	day in 2-digit format
# %r date in 12 hour AM/PM format,
HISTTIMEFORMAT="%d-%m-%Y %r >>> "
HISTCONTROL=ignorespace:ignoredups

# Bash Prompt - You can use any one
export PROMPT_STYLE=extemsive
source "${CONFIG_PATH}/prompt/jm-shell/ps1" || source "${CONFIG_PATH}/prompt/mathiasbynens/.bash_prompt"

# ---- GIT Configuration----
git config --global include.path ${CONFIG_PATH}/git/gitconfig
git config --global core.excludesfile ${CONFIG_PATH}/git/gitignore
git config --global commit.template ${CONFIG_PATH}/git/gitmessage
git config --global credential.helper 'store --file ${CONFIG_PATH}/git/credentials'

# ----- HSTR Configuration -----
if [ $(command -v hstr) ]; then
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
fi

# ---- Intialize OS configurations ----
case ${_myos} in
Darwin)
	source "${CONFIG_PATH}/aliases/mac_x64.sh"
	;;
Linux)
	source "${CONFIG_PATH}/aliases/linux_x64.sh"
	;;
esac

# ---- Directory Bookmark Manager Setup ----
export SDIRS="${CONFIG_PATH}/bashmark/.sdirs"
if [ ! -f "$SDIRS" ]; then
	util log-info "BashConfig" "Creating file ${SDIRS} for storing bookmarks"
	touch $SDIRS
fi
source "${CONFIG_PATH}/bashmark/bashmarks.sh"

# ---- Login welcome message ----
_welcome-message() {
	# local login="last -2 $USER | cut -c 1- |head -1"
	# local lastlogin="last -2 $USER | cut -c 1-50|tail -1"
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
	echo -e "Today, \t$(date +"%x %X %p %:::z")\n\t$(date -u +"%x %X %p %:::z")"
	os_spec="uname -r -p -m"
	echo -e "Kernal, ${_myos} v$(${os_spec})"
	bash_version=$(bash --version | head -n1 | cut -d" " -f2-5)
	echo -e "${bash_version}"
	echo "Hurray! Bash Config Loads in  $(echo "$(date +%s.%N) - $start" | bc -l) seconds"
}

_welcome-message

# ----- Autocompleteion -----
source "${CONFIG_PATH}/aliases/autocomplete.sh"
