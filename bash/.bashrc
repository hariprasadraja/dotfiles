#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

# Environment Variables
export PROMPT_STYLE=extensive


HISTCONTROL=ignorespace:ignoredups

# y	year in 2-digit format
# Y	year in 4-digit format
# m	month in 2-digit format
# d	day in 2-digit format
# T	time in 24-hour format
# %r	date in 12 hour AM/PM format
# %D	date in mm/dd/yy format
HISTTIMEFORMAT="%d-%m-%Y (%T/%r) "
HISTSIZE=1000
HISTFILESIZE=20000

# Source jm-shell custom prompt if it exists.
if [ -f "$HOME/.bash-config/jm-shell/ps1" ];then

    # shellcheck disable=1090
    source "$HOME/.bash-config/jm-shell/ps1"
fi

# Welcome Message
if [ -x "$(command -v sl)" ];then
    sl -a | lolcat
    clear
    # brew install cowsay
    if [ -x "$(command -v cowthink)" ];then
        if [ -x "$(command -v fortune)" ];then
           expressions=(
                    "apt"
                    "beavis.zen"
                    "bong"
                    "bud-frogs"
                    "bunny"
                    "calvin"
                    "cheese"
                    "cock"
                    "cower"
                    "daemon"
                    "default"
                    "dragon"
                    "dragon-and-cow"
                    "duck"
                    "elephant"
                    "elephant-in-snake"
                    "eyes"
                    "flaming-sheep"
                    "ghostbusters"
                    "gnu"
                    "head-in"
                    "hellokitty"
                    "kiss"
                    "kitty"
                    "koala"
                    "kosh"
                    "luke-koala"
                    "mech-and-cow"
                    "meow"
                    "milk"
                    "moofasa"
                    "moose"
                    "mutilated"
                    "pony"
                    "pony-smaller"
                    "ren"
                    "sheep"
                    "skeleton"
                    "snowman"
                    "sodomized-sheep"
                    "stegosaurus"
                    "stimpy"
                    "suse"
                    "three-eyes"
                    "turkey"
                    "turtle"
                    "tux"
                    "unipony"
                    "unipony-smaller"
                    "vader"
                    "vader-koala"
                    "www"
                    )
             RANDOM=$$$(date +%s)
             selectedexpression=${expressions[$RANDOM % ${#expressions[@]}]}
             fortune -s | cowthink -f $selectedexpression | lolcat
        fi
    fi
fi


### Get os name via uname ###
_myos="$(uname)"
    echo "******    Operting System:    $_myos	*******"
case $_myos in
   Darwin)
if [ -f "$HOME/.bash-config/bash/bash_mac_x64" ];then
    # shellcheck disable=1090
    source "$HOME/.bash-config/bash/bash_mac_x64"
fi
   ;;
   Linux)
if [ -f "$HOME/.bash-config/bash/bash_mac_x64" ];then
    source "$HOME/.bash-config/bash/bash_linux_x64"
fi
   ;;
   *) ;;
esac


# ---- GIT ----
git config --global color.ui true
git config --global include.path ~/.bash-config/git/.gitalias
git config --global help.autocorrect 1
git config --global core.excludesFile ~/.bash-config/git/.gitignore
git config --global core.attributesFile ~/.bash-config/git/.gitattributes
git config --global commit.template ~/.bash-config/git/.gitmessage

## Directory Bookmark Manager ##
if [ ! -f "$HOME/.sdirs" ]; then
    echo "file does not exist"
    touch ~/.sdirs

    # Export default bookmarks
    echo export DIR_config="$HOME/.bash-config" >> "$HOME/.sdirs"
fi
source "$HOME/.bash-config/bashmark/bashmarks.sh"

## HSTR configuration  ##
if [ `command -v hstr` ]; then
    # body
    alias hh=hstr                    # hh to be alias for hstr
    export HSTR_CONFIG=hicolor,case-sensitive,no-confirm,raw-history-view,warning
    HISTFILESIZE=10000
    HISTSIZE=${HISTFILESIZE}
    # ensure synchronization between Bash memory and history file
    export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
    #if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
    if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
    # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
    if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
fi

