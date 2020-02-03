#!/usr/bin/env bash

# This file contains aliases and configurations for python
if [ ! $(command -v python) ]; then
    util log-warning "BASHCONFIG" "It seems like you haven't installed python.
    some of aliases and configuration wont' work properly"
    return 0
fi

alias hcurl="python ${BASHCONFIG_PATH}/submodules/httpstat/httpstat.py "
