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
    if [ -f "/tmp/neofetch" ]; then
        cat /tmp/neofetch
    else
        neofetch &> /tmp/neofetch
    fi
}

export DOTFILES_PATH="$HOME/dotfiles"
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"
_main() {

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
    source "${DOTFILES_PATH}/config/colors/colors.sh"

    # Add tools from 'bin/' to PATH
    # XXX: if condition is writtern to avoid duplicating path while reloading bash
    if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
        export PATH=${DOTFILES_PATH}/bin:$PATH
    fi



    # Fuzzy Search with fzf
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
     --layout=reverse --inline-info
     --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
     --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
     --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
     --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
    export FZF_DEFAULT_COMMAND='fd'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


    ### Added by Zinit's installer
    [ -f ~/.zinit/bin/zinit.zsh ] && source ~/.zinit/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) &&_comps[zinit]=_zinit


    # zinit ice pick"async.zsh" src"pure.zsh"
    # zinit light sindresorhus/pure

    # Teminal Prompt
    zinit ice depth=1; zinit light romkatv/powerlevel10k

    # fzf tab completions
    zinit light Aloxaf/fzf-tab
    zstyle ":completion:*:git-checkout:*" sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light zsh-users/zsh-autosuggestions
    zinit light MichaelAquilina/zsh-you-should-use
    zinit load ael-code/zsh-colored-man-pages


    export FZF_FINDER_EDITOR='micro'
    zinit load leophys/zsh-plugin-fzf-finder

    # TODO: add check to find if it is a non login shell.
    [ -f ${HOME}/.zprofile ] && source ${HOME}/.zprofile

    #  Initialize Operating System Specific configurations
    _init_os

    # Initialize your personalize global configuration
    source "${DOTFILES_PATH}/config/init.sh"
    # Welcome Message
    local file=/tmp/neofetch_sys_details.txt
    if [ ! -f "$file" ]; then
    _welcome-message &>$file
    fi

    cat ${file}
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -s "/home/harajara/.gvm/scripts/gvm" ]] && source "/home/harajara/.gvm/scripts/gvm"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/autojump/autojump.zsh



}

_main

# eval "$(direnv hook zsh)"
# # Hook for desk activation
# [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# # Hook for desk activation
# [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# # Hook for desk activation
# [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# # Hook for desk activation
# [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
# # The following lines were added by compinstall
# zstyle :compinstall filename '/home/hariprasad/.zshrc'

# autoload -Uz compinit
# compinit
# # End of lines added by compinstall


# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

eval $(thefuck --alias)
