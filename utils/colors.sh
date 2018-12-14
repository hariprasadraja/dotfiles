#!/usr/bin/env bash

hex_to_rgb() {
    # Usage: hex_to_rgb "#FFFFFF"
    #        hex_to_rgb "000000"
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

rgb_to_hex() {
    # Usage: rgb_to_hex "r" "g" "b"
    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
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
