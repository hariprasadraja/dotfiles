#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2086

#
# ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── I ──────────
#   :::::: B A S H   C O N F I G U R A T I O N   F O R   D E V E L O P E R S   P R O D U C T I V I T Y : :  :   :    :     :        :          :
# ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#

#
# ─── REMOVE PREVIOUS LOG DETAILS IN TERMINAL ───────────────────────────────────────────
#

clear

# ────────────────────────────────────────────────────────────────────────────────


#
# ─── CAPTURE ALL STANDARD ERRORS & MOVE INTO THE LOG FILE ─────────────────────────────────────
#

stderr_log="$HOME/.bash-config/stderr.log"
exec 3>&1 4>&2 1>$stderr_log 2>&1

# ────────────────────────────────────────────────────────────────────────────────

#
# ─── REPORT IF ANY ERROR ────────────────────────────────────────────────────────
#


handle_error() {
    local error_code="${?}"
    test $error_code == 0 && return;


    #
    # ─── REDIRECT STANDARD ERRORS AGAIN TO THE CONSOLE ──────────────────────────────
    #

    exec 1>&3 2>&4

    # ────────────────────────────────────────────────────────────────────────────────


    local i=0
    local regex=''
    local mem=''
    local error_file=''
    local error_lineno=''
    local error_message='unknown'
    local lineno=''


    u_header "(!)ERROR REPORT"
    if test -f "$stderr_log"
    then
    stderr=$( tail -n 1 "$stderr_log" )
    fi
    if test -n "$stderr"
    then

    # Exploding stderr on :
    mem="$IFS"
    local shrunk_stderr=$( echo "$stderr" | sed 's/\: /\:/g' )
    IFS=':'
    local stderr_parts=( $shrunk_stderr )
    IFS="$mem"
    if ((${#stderr_parts[@]} > 1)); then

        # Storing information on the error
        error_file="${stderr_parts[0]}"
        error_lineno="${stderr_parts[1]}"
        error_message=""

        for (( i = 3; i <= ${#stderr_parts[@]}; i++ ))
            do
                error_message="$error_message "${stderr_parts[$i-1]}": "
        done

        # Removing last ':' (colon character)
        error_message="${error_message%:*}"

        # Trim
        error_message="$( echo "$error_message" | sed -e 's/^[ \t]*//' | sed -e 's/[ \t]*$//' )"
    else
        error_message=$stderr
    fi
    fi


    #
    # ─── RETRIVE STACK TRACE ────────────────────────────────────────────────────────
    #

    _backtrace=$( backtrace 2 )


    #
    # ─── MANAGING THE OUTPUT ────────────────────────────────────────────────────────
    #
    local lineno=""
    regex='^([a-z]{1,}) ([0-9]{1,})$'

    if [[ $error_lineno =~ $regex ]]

        # The error line was found on the log
        # (e.g. type 'ff' without quotes wherever)
        # --------------------------------------------------------------
        then
            local row="${BASH_REMATCH[1]}"
            lineno="${BASH_REMATCH[2]}"

            echo -e "FILE:\t\t${error_file}"
            echo -e "${row^^}:\t\t${lineno}\n"

            echo -e "ERROR CODE:\t${error_code}"
            echo -e "ERROR MESSAGE:\n$error_message"


        else
            regex="^${error_file}\$|^${error_file}\s+|\s+${error_file}\s+|\s+${error_file}\$"
            if [[ "$_backtrace" =~ $regex ]]

                # The file was found on the log but not the error line
                # (could not reproduce this case so far)
                # ------------------------------------------------------
                then
                    echo -e "FILE:\t\t$error_file"
                    echo -e "ROW:\t\tunknown\n"

                    echo -e "ERROR CODE:\t${error_code}"
                    echo -e "ERROR MESSAGE:\n${stderr}"

                # Neither the error line nor the error file was found on the log
                # (e.g. type 'cp ffd fdf' without quotes wherever)
                # ------------------------------------------------------
                else
                    #
                    # The error file is the first on backtrace list:

                    # Exploding backtrace on newlines
                    mem=$IFS
                    IFS='
                    '
                    #
                    # Substring: I keep only the carriage return
                    # (others needed only for tabbing purpose)
                    IFS=${IFS:0:1}
                    local lines=( $_backtrace )

                    IFS=$mem

                    error_file=""

                    if test -n "${lines[1]}"
                        then
                            array=( ${lines[1]} )

                            for (( i=2; i<${#array[@]}; i++ ))
                                do
                                    error_file="$error_file ${array[$i]}"
                            done

                            # Trim
                            error_file="$( echo "$error_file" | sed -e 's/^[ \t]*//' | sed -e 's/[ \t]*$//' )"
                    fi

                    echo -e "FILE:\t\t$error_file"
                    echo -e "ROW:\t\tunknown\n"

                    echo -e "ERROR CODE:\t${error_code}"
                    if test -n "${stderr}"
                        then
                            echo -e "ERROR MESSAGE:\n${stderr}"
                        else
                            echo -e "ERROR MESSAGE:\n${error_message}"
                    fi
            fi
    fi

    #
    # ─── PRINTING THE STACK TRACE & ERROR LOG ───────────────────────────────────────────────────
    #

    echo -e "\n$_backtrace\n"
    echo -e "ERROR LOG:\n$(cat ${stderr_log})"
    echo -e "\n\tExiting!"
}

function backtrace() {
    local _start_from_=0

    local params=( "$@" )
    if (( "${#params[@]}" >= "1" ))
        then
            _start_from_="$1"
    fi

    local i=0
    local first=false
    while caller $i > /dev/null
    do
        if test -n "$_start_from_" && (( "$i" + 1   >= "$_start_from_" ))
            then
                if test "$first" == false
                    then
                        echo "STACKTRACE:"
                        first=true
                fi
                caller $i
        fi
        let "i=i+1"
    done
}

trap handle_error ERR;

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

# Source jm-shell custom prompt if it exists.
if [ -f "$HOME/.bash-config/jm-shell/ps1" ];then
    # shellcheck disable=1090
    source "$HOME/.bash-config/jm-shell/ps1"
fi

# set bash utils
source "$HOME/.bash-config/utils/utils.sh"

### Get os name via uname ###
_myos="$(uname)"
case $_myos in
    Darwin)
        if [ -f "$HOME/.bash-config/bash/bash_mac_x64" ];then
            # shellcheck disable=1090
            source "$HOME/.bash-config/bash/bash_mac_x64"
        fi
    ;;
    Linux)
        if [ -f "$HOME/.bash-config/bash/bash_linux_x64" ];then
            source "$HOME/.bash-config/bash/bash_linux_x64"
        fi
    ;;
    *) ;;
esac

# ---- GIT Configuration----
git config --global color.ui true
git config --global include.path ~/.bash-config/git/.gitalias
git config --global help.autocorrect 1
git config --global core.excludesFile ~/.bash-config/git/.gitignore
git config --global core.attributesFile ~/.bash-config/git/.gitattributes
git config --global commit.template ~/.bash-config/git/.gitmessage

# ---- Directory Bookmark Manager ----
export SDIRS="$HOME/.bash-config/bashmark/.sdirs"
if [ ! -f "$SDIRS" ]; then
    echo "file does not exist"
    touch $SDIRS
fi
source "$HOME/.bash-config/bashmark/bashmarks.sh"

# ----- HSTR configuration -----
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

# ---- Intialized OS configurations ----
_myos="$(uname)"
case $_myos in
    Darwin)
        if [ -f "$HOME/.bash-config/bash/bash_mac_x64" ];then
            # shellcheck disable=1090
            source "$HOME/.bash-config/bash/bash_mac_x64"
        fi
    ;;
    Linux)
        if [ -f "$HOME/.bash-config/bash/bash_linux_x64" ];then
            source "$HOME/.bash-config/bash/bash_linux_x64"
        fi
    ;;
    *) ;;
esac

function print_login_details {
# local login="last -2 $USER | cut -c 1- |head -1"
# local lastlogin="last -2 $USER | cut -c 1-50|tail -1"
local hour msg os_spec bash_version
hour=$(date +%H) # Hour of the day
msg="GOOD EVENING!"
if [ $hour -lt 12 ]; then
	msg="GOOD MORNING!"
elif [ $hour -lt 16 ]; then
    msg="GOOD AFTERNOON!"
fi

# Welcome message & system details
u_header "${msg} $(u_upper ${USER})"
echo -e "Time ($(date +%Z)): $(date)\n\t(UTC): $(date -u)"
os_spec="uname -r -p -m"
echo -e "Kernal: ${_myos} v$(${os_spec})"
bash_version=$(bash --version | head -n1 | cut -d" " -f2-5)
echo -e "${bash_version}"

# Bug: unable to get bash installed location in linux , works well in mac os.
# local MYSH=$(readlink $(which bash))
# if [[ "${MYSH}" = *bash* ]]; then
# echo -e "${bash_version},\n $MYSH"
# else
# echo -e "${bash_version},$(u_error "bash path not found")"
# fi

u_header "INSTALLED"
go version | head -n1
python --version
grep --version | head -n1
gzip --version | head -n1
m4 --version | head -n1
make --version | head -n1
patch --version | head -n1
hstr --version | head -n1
docker --version | head -n1

echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c &> err.log
if [ -x dummy ]
then
echo "g++ $(g++ -dumpversion)"
rm -f dummy.c dummy
fi
rm -f err.log
# source "$HOME/.bash-config/bash/version-check.sh"
}
error
print_login_details
