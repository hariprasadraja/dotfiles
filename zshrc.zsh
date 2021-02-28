# Path where the dotfiles directory resides
export DOTFILES_PATH="$HOME/dotfiles"

# Path where your machine specific directroy resides
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"

function _init_os() {
  case $(uname) in
    Darwin)
      source "${DOTFILES_PATH}/configs/os/mac_x64.sh" &> /dev/null
    ;;
    Linux)
      source "${DOTFILES_PATH}/configs/os/linux_x64.sh" &> /dev/null
    ;;
    *)
      util log-info "BashConfig" "unknown Operating system $(uname),
      failed to load Operating System specific configurations"
    ;;
  esac
}

# ---- Login welcome message ----
function _welcome-message() {
  # prints the welcome message
  
  local hour msg os_spec bash_version
  hour=$(date +%H) # Hour of the day
  msg="GOOD EVENING!"
  if [ $hour -lt 12 ]; then
    msg="GOOD MORNING!"
    elif [ $hour -lt 16 ]; then
    msg="GOOD AFTERNOON!"
  fi
  
  
  # Welcome message
  util log-header "${msg} $(util string-upper ${USER})"
  
  # print System specifications
  if [ -f "/tmp/neofetch" ]; then
    cat /tmp/neofetch
  else
    neofetch &> /tmp/neofetch
    cat /tmp/neofetch
  fi
}

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# # Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


function _zinit_setup() {
  
  # download and install zinit
  if [ ! -d ~/.zinit/bin ]; then
    echo "zinit not found. cloning the repo"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  fi
  
  # debug mode
  # typeset -g ZPLG_MOD_DEBUG=1
  
  source ~/.zinit/bin/zinit.zsh
  autoload -Uz _zinit && _comps[zinit]=_zinit
  
  zinit ice as"program" atclone"python3 install.py" \
  atpull"%atclone" src"bin/autojump.sh"
  zinit light wting/autojump
  
  zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
  zinit light trapd00r/LS_COLORS
  
  # install fzf
  zinit ice from"gh-r" as"program"
  zinit light junegunn/fzf
  
  # delta diff tool for git
  zinit ice from"gh-r" as"program"
  zinit light dandavison/delta
  
  # colorls
  zinit ice from"gh-r" as"program"
  zinit light athityakumar/colorls
  
  export FZF_DEFAULT_COMMAND='fd --follow --exclude .git'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --layout=reverse --height 100% --inline-info
  --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
  
  # It is adviced to load compinit before fzf-tab
  autoload -U compinit && compinit
  
  zinit light Aloxaf/fzf-tab
  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  # set descriptions format to enable group support
  zstyle ':completion:*:descriptions' format '[%d]'
  # set list-colors to enable filename colorizing
  zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
  # preview directory's content with colorls when completing cd
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'colorls --color=always $realpath'
  # switch group using `,` and `.`
  zstyle ':fzf-tab:*' switch-group ',' '.'
  
  
  zinit ice lucid wait'0'; zinit light hariprasadraja/zsh-fzf-history-search
  export FZF_FINDER_EDITOR='micro'; zinit load leophys/zsh-plugin-fzf-finder
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light MichaelAquilina/zsh-you-should-use
  zinit light zdharma/fast-syntax-highlighting
  zinit light zdharma/history-search-multi-word
  
  zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"; zinit light direnv/direnv
  
  # Teminal Prompt
  zinit ice depth=1; zinit light romkatv/powerlevel10k
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh &> /dev/null
  
  zinit ice as"program" depth=1 pick"desk";
  zinit light jamesob/desk
}



function _main() {
  
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
  source "${DOTFILES_PATH}/configs/colors/colors.sh" &> /dev/null
  
  # Add tools from 'bin/' to PATH
  # XXX: if condition is writtern to avoid duplicating path while reloading bash
  if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
    export PATH=${DOTFILES_PATH}/bin:$PATH
  fi
  
  
  _zinit_setup
  
  #  Initialize Operating System Specific configurations
  _init_os
  
  # Initialize your personalize global configuration
  source "${DOTFILES_PATH}/configs/init.sh"
  # Welcome Message
  _welcome-message
  
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  
  
  # Hook for desk activation
  [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
  
  
  if [ -f "${DOTFILES_MACHINE_PATH}/init.sh" ]; then
    source ${DOTFILES_MACHINE_PATH}/init.sh
  fi
  
  _zsh_history_fix
}

fucntion _zsh_history_fix() {
  # solution to fix corupt ~/.zsh_history file
  # source: https://shapeshed.com/zsh-corrupt-history-file/
  
  mv ~/.zsh_history ~/.zsh_history_bad
  strings ~/.zsh_history_bad > ~/.zsh_history
  fc -R ~/.zsh_history
  rm ~/.zsh_history_bad
}


# unset functions after it's usages.
_main && unset -f _main
unset -f _welcome-message
unset -f _init_os
unset -f _zsh_history_fix
unset -f _zinit_setup
