export BASHCONFIG_PATH="/home/hariprasad/.bashconfig"

#### ANTIGEN Variables ####

# export ANTIGEN_DEFAULT_REPO_URL=https://github.com/custom/oh-my-zsh
export ADOTDIR="/home/hariprasad/.bashconfig/antigen"
export ANTIGEN_LOG="/home/hariprasad/.bashconfig/antigen.log"
export SUBMODULE_PATH=${BASHCONFIG_PATH}/submodules

source $SUBMODULE_PATH/antigen/antigen.zsh

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

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

####  Theme ####
antigen bundle https://github.com/sindresorhus/pure.git pure
fpath+=("/home/hariprasad/.bashconfig/antigen/bundles/sindresorhus/pure") && export fpath
autoload -U promptinit && promptinit && prompt pure
################

# antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

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

    _os_config "${_myos}"

    source "${BASHCONFIG_PATH}/config/defaults.sh"
    # source "${BASHCONFIG_PATH}/config/docker/docker.sh"
    # source "${BASHCONFIG_PATH}/config/python/python.sh"
    # source "${BASHCONFIG_PATH}/config/golang/golang.sh"
    # source "${BASHCONFIG_PATH}/config/autocomplete.sh"

    # Welcome Message
    _welcome-message

}

_init
