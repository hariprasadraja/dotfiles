#!/usr/bin/env bash

# Autocompleteion for 'dklogs' command
_dklogs-autocomplete() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ ${COMP_CWORD} -eq 1 ]; then
        _script_commands=$(docker container ls -a --format="{{.Names}}")
        COMPREPLY=($(compgen -W "${_script_commands}" -- ${cur}))
    fi

    return 0
}
complete -F _dklogs-autocomplete dklogs
complete -F _dklogs-autocomplete dke

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
