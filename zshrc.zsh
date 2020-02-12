export BASHCONFIG_PATH="$HOME/dotfiles"
export BASHCONFIG_DOTFILES="$BASHCONFIG_PATH/machine"
export SUBMODULE_PATH="${BASHCONFIG_PATH}/submodules"

# specify the location where the bashconfig need to read your machine specific configuration.
# bashconfig stores bashmarks,sshrc and other machine specific configurations in to $BASHCONFIG_DOTFILES directory
if [ ! -d "${BASHCONFIG_DOTFILES}" ]; then
    mkdir -p ${BASHCONFIG_DOTFILES}
fi

#### ANTIGEN Variables ####

# export ANTIGEN_DEFAULT_REPO_URL=https://github.com/custom/oh-my-zsh
export ADOTDIR="$BASHCONFIG_PATH/antigen"
export ANTIGEN_LOG="$BASHCONFIG_PATH/antigen.log"

source "$SUBMODULE_PATH/antigen/antigen.zsh"

# Load Bundles From  oh-my-zsh's library.

# The following is the same as `antigen bundle ant`. But for demonstration
# purposes, we use the extended syntax here.
# antigen bundle https://github.com/robbyrussell/oh-my-zsh.git plugins/ant

antigen use oh-my-zsh
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle wd
antigen bundle common-aliases
antigen bundle colorize
antigen bundle docker
antigen bundle colored-man-pages
antigen bundle web-search
antigen bundle tmux
antigen bundle tmux-cssh
antigen bundle tmuxinator
antigen bundle fzf

antigen bundle gitfast

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle urbainvaes/fzf-marks

# How cool is it to run ls whenever you change directory ? If you’re like me running ls every time on changing directory this is must have plugin. As name implies, it will show list of files and folder on changing directory. Enable this plugin by adding below line in ~/.zshrc.

antigen bundle desyncr/auto-ls

# Using this plugin, we can run fuzzy-search in command history by entering multiple words. This is another must-have plugin. You can find list of all additional options here. To enable this, plugin add below line in ~/.zshrc.
# antigen bundle psprint/zsh-navigation-tools

####  Theme ####
antigen bundle https://github.com/sindresorhus/pure.git pure
fpath+=("${ADOTDIR}/bundles/sindresorhus/pure") && export fpath
autoload -U promptinit && promptinit && prompt pure
# antigen theme robbyrussell
################

# Tell Antigen that you're done.
antigen apply

clear

# Set $TERM environment
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color'
fi

# initiate color codes
source "${BASHCONFIG_PATH}/submodules/colorcodes/.bashcolors"

_init_os() {
    case $(uname) in
    Darwin)
        source "${BASHCONFIG_PATH}/config/os/mac_x64.sh"
        ;;
    Linux)
        source "${BASHCONFIG_PATH}/config/os/linux_x64.sh"
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
    ${BASHCONFIG_PATH}/submodules/neofetch/neofetch
}

_init() {

    # Add tools from 'bin/' to PATH
    # XXX: if condition is writtern to avoid duplicating path while reloading bash
    if [[ "${PATH}" != *"${BASHCONFIG_PATH}/bin"* ]]; then
        export PATH=${BASHCONFIG_PATH}/bin:$PATH
    fi

    #  Initialize Operating System Specific configurations
    _init_os

    # Initialize your personalize global configuration
    source "${BASHCONFIG_PATH}/config/init.sh"

    # Initialize your machine specific configuration
    for files in $BASHCONFIG_DOTFILES/scripts/*.sh; do
        source $files
    done

    # Welcome Message
    _welcome-message

}

_init
