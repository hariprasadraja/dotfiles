#!/usr/bin/env bash
# Author: Hariprasad
# Reference:
# https://github.com/dylanaraps/pure-bash-bible

# <---- Arrays Utility Functions ---->

u_reverse_array() {
    # Usage: reverse_array "array"
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

u_remove_array_dups() {
    # Usage: remove_array_dups "array"
    declare -A tmp_array
    
    for i in "$@"; do
        [[ "$i" ]] && IFS=" " tmp_array["${i:- }"]=1
    done
    
    printf '%s\n' "${!tmp_array[@]}"
}

u_random_array_element() {
    # Usage: random_array_element "array"
    local arr=("$@")
    printf '%s\n' "${arr[RANDOM % $#]}"
}

u_cycle() {
    printf '%s ' "${arr[${i:=0}]}"
    ((i=i>=${#arr[@]}-1?0:++i))
}

u_cycle() {
    printf '%s ' "${arr[${i:=0}]}"
    ((i=i>=${#arr[@]}-1?0:++i))
}
