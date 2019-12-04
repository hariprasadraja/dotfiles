#!/usr/bin/env bash

# Autocompleteion for 'dklogs' command
_docker_container_list_autocomplete() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ ${COMP_CWORD} -eq 1 ]; then
        _script_commands=$(docker container ls -a --format="{{.Names}}")
        COMPREPLY=($(compgen -W "${_script_commands}" -- ${cur}))
    fi

    return 0
}

_docker_images_list_autocomplete() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ ${COMP_CWORD} -eq 1 ]; then
        _script_commands=$(docker image ls -a --format="{{.Names}}")
        COMPREPLY=($(compgen -W "${_script_commands}" -- ${cur}))
    fi

    return 0
}

complete -F _docker_container_list_autocomplete dklogs
complete -F _docker_container_list_autocomplete dke
complete -F _docker_images_list_autocomplete dki
complete -F _docker_images_list_autocomplete dkinsi

# Autocompletion for 'util' command
_utils-autocomplete() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ ${COMP_CWORD} -eq 1 ]; then
        _script_commands=$(util -m)
        COMPREPLY=($(compgen -W "${_script_commands}" -- ${cur}))
    fi
    return 0
}
complete -F _utils-autocomplete util
