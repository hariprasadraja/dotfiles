#!/usr/bin/env bash

print_upto() {
    VAR=$1
    for ((i=0;i<=VAR;i++)); do
        printf '%s\n' "$i"
    done
}

print_array(){
    arr=$1
    for element in "${arr[@]}"; do
        printf '%s\n' "$element"
    done
}

print_file() {
    while read -r line; do
        printf '%s\n' "$line"
    done < "file"
}
