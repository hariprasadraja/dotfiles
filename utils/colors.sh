#!/usr/bin/env bash

u_hex_to_rgb() {
    # Usage: hex_to_rgb "#FFFFFF"
    #        hex_to_rgb "000000"
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

u_rgb_to_hex() {
    # Usage: rgb_to_hex "r" "g" "b"
    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}


bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#
# Headers and  Logging
#

u_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}
u_arrow() { printf "➜ $@\n"
}
u_success() { printf "${green}✔ %s${reset}\n" "$@"
}
u_error() { printf "${red}✖ %s${reset}\n" "$@"
}
u_warning() { printf "${tan}➜ %s${reset}\n" "$@"
}
u_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
u_bold() { printf "${bold}%s${reset}\n" "$@"
}
u_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}
