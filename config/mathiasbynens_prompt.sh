#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.
# for color codes Refer: https://gist.github.com/hariprasadraja/c36a13d1af8817de3f4ec23a52044617

# variablesfor your PS1 prompt status
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
Jobs="\j"

prompt_git() {
	if [ -d .git ]; then
		. ${BASHCONFIG_PATH}/submodules/gitprompt/gitprompt.sh
	else
		return 0
	fi
}

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${BLUE}"
else
	userStyle="${ORANGE}"
fi

# Highlight the user icon when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userIcon="${BLUE}🕵"
else
	userIcon="${ORANGE}🗲"
fi

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${RED}"
else
	hostStyle="${YELLOW}"
fi

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"   # working directory base name
PS1+="\[${BOLD}\]\n"      # newline
PS1+="\[${userStyle}\]\u" # username
PS1+="\[${BLACK}\] at "
PS1+="\[${hostStyle}\]\h" # host
PS1+="\[${BLACK}\] in "
PS1+="\[${GREEN}\]${PathShort}"
PS1+="\$(prompt_git)" # Git repository details
PS1+="\n"
PS1+="\[${BOLD}\]\[${userIcon}\]  \[${RESET}\]" # `$` (and reset color)+*
export PS1

PS2="\[${BOLD}\]\[${userStyle}\]/  \[${RESET}\]"
export PS2
