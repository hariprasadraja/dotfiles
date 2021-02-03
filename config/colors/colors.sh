#!/usr/bin/env bash

#========================================================================
#  FILE         : .bashcolors.sh
#  DESCRIPTION  : Bash Colors For Shell Scripts
#  FORK         : https://gist.github.com/vratiu/9780109
#  SOURCE       : https://gist.github.com/hariprasadraja/c36a13d1af8817de3f4ec23a52044617
#  REFER        : https://misc.flogisoft.com/bash/tip_colors_and_formatting
#==========================================================================

if tput setaf 1 &>/dev/null; then
    RESET="$(tput sgr0)$(tput rmul)$(tput rmso)" # reset colors
    BOLD=$(tput bold)                            # trun on bold color mode
    DIM=$(tput dim)                              # – turn on half-bright mode
    REVERSE=$(tput rev)                          #– Turn on reverse mode
    UL=$(tput smul)                              #   begin underline mode
    STD=$(tput smso)                             # Enter standout mode (bold on rxvt)

    # Regular Colors
    BLACK=$(tput setaf 0)
    WHITE=$(tput setaf 15)
    BLUE=$(tput setaf 33)
    CYAN=$(tput setaf 37)
    VIOLET=$(tput setaf 61)
    GREEN=$(tput setaf 64)
    RED=$(tput setaf 124)
    PURPLE=$(tput setaf 126)
    YELLOW=$(tput setaf 136)
    ORANGE=$(tput setaf 166)

    # BOLD Colors
    BBLACK="${BOLD}${BLACK}"
    BWHITE="${BOLD}${WHITE}"
    BBLUE="${BOLD}${BLUE}"
    BCYAN="${BOLD}${CYAN}"
    BVIOLET="${BOLD}${VIOLET}"
    BGREEN="${BOLD}${GREEN}"
    BRED="${BOLD}${RED}"
    BPURPLE="${BOLD}${PURPLE}"
    BYellow="${BOLD}${YELLOW}"
    BORANGE="${BOLD}${ORANGE}"

    # Underline Colors
    UBLACK="${UL}${BLACK}"
    UWHITE="${UL}${WHITE}"
    UBLUE="${UL}${BLUE}"
    UCYAN="${UL}${CYAN}"
    UVIOLET="${UL}${VIOLET}"
    UGREEN="${UL}${GREEN}"
    URED="${UL}${RED}"
    UPURPLE="${UL}${PURPLE}"
    UYellow="${UL}${YELLOW}"
    UORANGE="${UL}${ORANGE}"

else

    RESET="\[\033[0m\]" # Text Reset
    BOLD=""             # trun on bold color mode
    DIM=""              # – turn on half-bright mode
    REVERSE=""          #– Turn on reverse mode
    UL=""               #   begin underline mode
    STD=""              # Enter standout mode (bold on rxvt)

    # Regular Colors
    BLACK="\[\033[0;30m\]"
    WHITE="\[\033[0;37m\]"
    BLUE="\[\033[0;34m\]"
    CYAN="\[\033[0;36m\]"
    VIOLET=""
    GREEN="\[\033[0;32m\]"
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    PURPLE="\[\033[0;35m\]"

    # Bold
    BBLACK="\[\033[1;30m\]"  # Black
    BRED="\[\033[1;31m\]"    # Red
    BGREEN="\[\033[1;32m\]"  # Green
    BYELLOW="\[\033[1;33m\]" # Yellow
    BBLUE="\[\033[1;34m\]"   # Blue
    BPURPLE="\[\033[1;35m\]" # Purple
    BCYAN="\[\033[1;36m\]"   # Cyan
    BWHITE="\[\033[1;37m\]"  # White

    # Underline
    UBLACK="\[\033[4;30m\]"  # Black
    URED="\[\033[4;31m\]"    # Red
    UGREEN="\[\033[4;32m\]"  # Green
    UYellow="\[\033[4;33m\]" # Yellow
    UBLUE="\[\033[4;34m\]"   # Blue
    UPURPLE="\[\033[4;35m\]" # Purple
    UCYAN="\[\033[4;36m\]"   # Cyan
    UWHITE="\[\033[4;37m\]"  # White

    # # Background
    # On_Black="\[\033[40m\]"  # Black
    # On_Red="\[\033[41m\]"    # Red
    # On_Green="\[\033[42m\]"  # Green
    # On_Yellow="\[\033[43m\]" # Yellow
    # On_Blue="\[\033[44m\]"   # Blue
    # On_Purple="\[\033[45m\]" # Purple
    # On_Cyan="\[\033[46m\]"   # Cyan
    # On_White="\[\033[47m\]"  # White
fi
