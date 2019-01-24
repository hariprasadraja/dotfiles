#!/usr/bin/env bash

term-size() {
	# Usage: get_term_size

	# (:;:) is a micro sleep to ensure the variables are
	# exported immediately.
	shopt -s checkwinsize
	(
		:
		:
	)
	printf '%s\n' "$LINES $COLUMNS"
}

window-size() {
	# Usage: get_window_size
	printf '%b' "${TMUX:+\\ePtmux;\\e}\\e[14t${TMUX:+\\e\\\\}"
	IFS=';t' read -d t -t 0.05 -sra term_size
	printf '%s\n' "${term_size[1]}x${term_size[2]}"
}

window-cursor-pos() {
	# Usage: get_cursor_pos
	IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
	printf '%s\n' "$x $y"
}

sleep() {
	cmd=$(command -v sleep)
	if [ "${cmd}" ]; then
		sleep "${1}"
		exit 0
	fi

	read -rst "${1:-1}" -N 999
	exit 0
}
