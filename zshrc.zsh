#!/usr/bin/env sh

# debug mode
# typeset -g ZPLG_MOD_DEBUG=1

setopt COMPLETE_ALIASES


# Path where the dotfiles directory resides
export DOTFILES_PATH=$(dirname "$0")

# Path where your machine specific directroy resides
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"

# update python path for the utils command
export PYTHONPATH="$PYTHONPATH:$DOTFILES_PATH/etc/utils"


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
  util log header "${msg} ${USER}"
  
  # print System specifications
  if [ -f "/tmp/neofetch" ]; then
    bat -pp /tmp/neofetch
  else
    neofetch &> /tmp/neofetch
    bat -pp /tmp/neofetch
  fi
  
  # developer quotes on your terminal
  zinit light oldratlee/hacker-quotes
}

function _zinit_setup() {
  
  source $(brew --prefix)/opt/zinit/zinit.zsh
  # source ~/.zinit/bin/zinit.zsh
  autoload -Uz _zinit && (( ${+_comps} )) && _comps[zinit]=_zinit
  
  zinit ice as"program" src"bin/autojump.sh"
  zinit light wting/autojump
  
  zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
  zinit light trapd00r/LS_COLORS
  
  export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --height 100% --reverse --inline-info
  --preview-window right:100
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'
  
  # It is adviced to load compinit before fzf-tab
  autoload -U compinit && compinit
  
  zinit light Aloxaf/fzf-tab
  
  zinit ice lucid wait'0'
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light MichaelAquilina/zsh-you-should-use
  zinit light zdharma-continuum/fast-syntax-highlighting
  
  # Teminal Prompt
  zinit ice depth=1
  zinit light romkatv/powerlevel10k
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh &> /dev/null
  source $DOTFILES_PATH/config/prompt/p10k.zsh &>/dev/null
  
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  source $DOTFILES_PATH/config/prompt/p10k-instant-prompt.zsh &>/dev/null
  
  # if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  # fi
  
  zinit ice as"program" depth=1 pick"desk"
  zinit light jamesob/desk
  
  zinit ice as"program" pick"revolver"
  zinit light molovo/revolver
  
  zinit ice as"program" src"git-sync.sh"
  zinit light hariprasadraja/zsh-git-sync
  
  zinit ice as"program"
  zinit light gpakosz/.tmux
  
  zinit light trystan2k/zsh-tab-title
  
  # rm command with careful deletion
  zinit light MikeDacre/careful_rm
  
  # emoji cli on command line
  zinit light "b4b4r07/emoji-cli"
  
  # gpg encrypt and decrypt
  zinit light Czocher/gpg-crypt
  
  # need to fix the autocomplete for this...
  zinit ice atclone'sudo make install' atpull'%atclone'
  zinit light arzzen/git-quick-stats
  
  # git open remote url in browser
  zinit ice as"program"
  zinit light paulirish/git-open
  
  # ssh completion
  zinit light zpm-zsh/ssh
  
  zinit light reegnz/jq-zsh-plugin # jq-repl
  
  zinit ice from"gh-r" as"program"
  zinit light client9/misspell
  
  # zunit - unit testing for zsh
  zinit ice wait"2" lucid as"program" pick"zunit" \
  atclone"./build.zsh" atpull"%atclone"
  zinit light molovo/zunit
  
  # autols
  zinit ice wait'0' lucid
  zinit light desyncr/auto-ls
  
  
  
  
  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  
  # set descriptions format to enable group support
  zstyle ':completion:*:descriptions' format '[%d]'
  
  # encourage LS_COLORS to set file naming colors
  zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
  
  
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  
  # use input as query string when completing zlua
  zstyle ':fzf-tab:complete:_zlua:*' query-string input
  
  # It specifies the key to accept and run a suggestion in one keystroke.
  zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
  zstyle ':fzf-tab:*' accept-line enter
  
  # switch group using `,` and `.`
  zstyle ':fzf-tab:*' switch-group ',' '.'
  
  zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
  
  
  zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
  export LESSOPEN='|$DOTFILES_PATH/config/fzf/lessfilter.sh %s'
  
  # systemctl autocompletion
  zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
  
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
  zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:10:wrap
  
  # environment variables
  zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'
  
  # homebrew
  zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
  
  
  zstyle ':fzf-tab:complete:*:options' fzf-preview
  zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
}


function _main() {
  
  # Set $TERM environment
  if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color'
    elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color'
  fi
  
  # initiate color codes
  source "${DOTFILES_PATH}/config/colors/colors.sh" &>/dev/null
  
  
  # Initialize your personalize global configuratio
  source "${DOTFILES_PATH}/config/init.sh"
  
  
  [ ! -d "${DOTFILES_MACHINE_PATH}" ] && mkdir -p ${DOTFILES_MACHINE_PATH}
  [ -f "${DOTFILES_MACHINE_PATH}/init.sh" ] && source ${DOTFILES_MACHINE_PATH}/init.sh
  
  
  # Add tools from 'bin/' to PATH
  # XXX: if condition is writtern to avoid duplicating path while reloading bash
  if [[ "${PATH}" != *"${DOTFILES_PATH}/bin"* ]]; then
    export PATH=${DOTFILES_PATH}/bin:$PATH
  fi
  
  # Initialize zsh plugins and configuration
  _zinit_setup && unset -f _zinit_setup
  
  _welcome-message && unset -f _welcome-message
  
  # Hook for desk activation
  [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
  
}

# unset functions after it's usages.
_main && unset -f _main
