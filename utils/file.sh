#!/usr/bin/env bash

u_first_N_lines() {
    # Usage: head "n" "file"
    mapfile -tn "$1" line < "$2"
    printf '%s\n' "${line[@]}"
}

u_last_N_lines() {
    # Usage: tail "n" "file"
    mapfile -tn 0 line < "$2"
    printf '%s\n' "${line[@]: -$1}"
}

u_lines() {
    # Usage: lines "file"
    mapfile -tn 0 lines < "$1"
    printf '%s\n' "${#lines[@]}"
}

u_extract() {
    # Usage: extract file "opening marker" "closing marker"
    while IFS=$'\n' read -r line; do
        [[ "$extract" && "$line" != "$3" ]] && \
        printf '%s\n' "$line"
        
        [[ "$line" == "$2" ]] && extract=1
        [[ "$line" == "$3" ]] && extract=
    done < "$1"
}

u_get_functions() {
    # Usage: get_functions
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '%s\n' "${functions[@]//declare -f }"
}