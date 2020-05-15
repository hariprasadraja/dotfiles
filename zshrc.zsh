
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

_init() {
    # Add tools from 'bin/' to PATH
    # XXX: if condition is writtern to avoid duplicating path while reloading bash
    if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
        export PATH=${DOTFILES_PATH}/bin:$PATH
    fi

    #  Initialize Operating System Specific configurations
    _init_os

    # Initialize your personalize global configuration
    source "${DOTFILES_PATH}/config/init.sh"

    # Fuzzy Search
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # Welcome Message
    local file=${DOTFILES_PATH}/neofetch.txt
    if [ ! -f "$file" ]; then
        _welcome-message &>$file
    fi

    cat ${file}

}

_init

# initial Zinit's hash definition, if configuring before loading Zinit, and then:
declare -A ZINIT
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


# bashub server




source "${DOTFILES_SUBMODULE_PATH}/zsh-histdb/sqlite-history.zsh"
autoload -Uz add-zsh-hook
add-zsh-hook precmd histdb-update-outcome
