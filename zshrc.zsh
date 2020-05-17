# Global Constants
# feel free to modify this to set your dotfiles path
export DOTFILES_PATH="$HOME/dotfiles"
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"
export DOTFILES_SUBMODULE_PATH="${DOTFILES_PATH}/submodules"

# specify the location where the bashconfig need to read your machine specific configuration.
# bashconfig stores bashmarks,sshrc and other machine specific configurations in to $DOTFILES_MACHINE_PATH directory
if [ ! -d "${DOTFILES_MACHINE_PATH}" ]; then
    mkdir -p ${DOTFILES_MACHINE_PATH}
fi

clear

# Set $TERM environment
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color'
fi

# initiate color codes
source "${DOTFILES_PATH}/submodules/colorcodes/bashcolors"

_init_os() {
    case $(uname) in
    Darwin)
        source "${DOTFILES_PATH}/config/os/mac_x64.sh"
        ;;
    Linux)
        source "${DOTFILES_PATH}/config/os/linux_x64.sh"
        ;;
    *)
        util log-info "BashConfig" "unknown Operating system $(uname),
			failed to load Operating System specific configurations"
        ;;
    esac
}

# ---- Login welcome message ----
_welcome-message() {
    # prints the welcome message

    local hour msg os_spec bash_version
    hour=$(date +%H) # Hour of the day
    msg="GOOD EVENING!"
    if [ $hour -lt 12 ]; then
        msg="GOOD MORNING!"
    elif [ $hour -lt 16 ]; then
        msg="GOOD AFTERNOON!"
    fi

    # Welcome message & system details
    util log-header "${msg} $(util string-upper ${USER})"

    # print System specifications
    ${DOTFILES_PATH}/submodules/neofetch/neofetch
}

declare -A ZINIT
_zinit_setup() {
    # initial Zinit's hash definition, if configuring before loading Zinit, and then:
    ZINIT[BIN_DIR]="${DOTFILES_SUBMODULE_PATH}/zinit"
    ZINIT[HOME_DIR]="${DOTFILES_PATH}/.zinit" # Add this to gitignore
    ZINIT[PLUGINS_DIR]="${ZINIT[HOME_DIR]}/plugins"
    ZINIT[COMPLETIONS_DIR]="${ZINIT[HOME_DIR]}/completions"
    ZINIT[SNIPPETS_DIR]="${ZINIT[HOME_DIR]}/snippets"
    ZINIT[ZCOMPDUMP_PATH]="${ZINIT[HOME_DIR]}/zcompdump"
    ZINIT[COMPINIT_OPTS]=""
    ZINIT[MUTE_WARNINGS]=0
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0

    ### Added by Zinit's installer
    source "${DOTFILES_SUBMODULE_PATH}/zinit/zinit.zsh"
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    zinit ice pick"async.zsh" src"pure.zsh"
    zinit light sindresorhus/pure

    zinit light Aloxaf/fzf-tab
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light zsh-users/zsh-autosuggestions
    zinit light MichaelAquilina/zsh-you-should-use
}

main() {
    # Add tools from 'bin/' to PATH
    # XXX: if condition is writtern to avoid duplicating path while reloading bash
    if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
        export PATH=${DOTFILES_PATH}/bin:$PATH
    fi

    # If the diff-so-fancy in the bin/ directory is older, then update it.
    # this will be helpful, if you pull the code for submodule/diff-so-fancy and
    # want to update the latest version
    # todo: This code block is not tested.
    if [ "${DOTFILES_SUBMODULE_PATH}/diff-so-fancy/diff-so-fancy" -nt "${DOTFILES_PATH}/bin/diff-so-fancy" ]; then
        ln -fs "${DOTFILES_SUBMODULE_PATH}"/diff-so-fancy/diff-so-fancy
    fi

    #  Initialize Operating System Specific configurations
    _init_os && unset -f _init_os

    # Initialize your personalize global configuration
    source "${DOTFILES_PATH}/config/init.sh"

    # Fuzzy Search
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # Zinit Plugin Manager Setup
    _zinit_setup && unset -f _zinit_setup

    # Welcome Message
    local file=${DOTFILES_PATH}/neofetch.txt
    if [ ! -f "$file" ]; then
        _welcome-message &>$file
    fi

    cat ${file}

}
main && unset -f main

# bashub server

source "${DOTFILES_SUBMODULE_PATH}/zsh-histdb/sqlite-history.zsh"
autoload -Uz add-zsh-hook
add-zsh-hook precmd histdb-update-outcome

# if [ ! `command -v bashhub`]; then
#     # body
#     https://github.com/rcaloras/bashhub-client
# fi


### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.zsh ]; then

    # Bashhub server is running in this port
    export BH_URL="http://localhost:9001"
    source ~/.bashhub/bashhub.zsh
fi

