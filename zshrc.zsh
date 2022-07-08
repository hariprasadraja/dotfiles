#!/usr/bin/env sh

# Path where the dotfiles directory resides
export DOTFILES_PATH=$(dirname "$0")

# Path where your machine specific directroy resides
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"

# update python path for the utils command
export PYTHONPATH="$PYTHONPATH:$DOTFILES_PATH/etc/utils"

setopt COMPLETE_ALIASES

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
    cat /tmp/neofetch
  else
    neofetch | >/tmp/neofetch
    cat /tmp/neofetch
  fi

  # developer quotes on your terminal
  zinit light oldratlee/hacker-quotes
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/master/doc/install.sh)"
  fi

  # debug mode
  # typeset -g ZPLG_MOD_DEBUG=1

  source ~/.zinit/bin/zinit.zsh
  autoload -Uz _zinit && (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit ice as"program" src"bin/autojump.sh"
  zinit light wting/autojump

  zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
  zinit light trapd00r/LS_COLORS

  # colorls - depends on ruby
  zinit ice depth=1 has'gem' atpull'%atclone' atclone'
  gem build colorls.gemspec -o colorls \
  && sudo gem install colorls' src'lib/tab_complete.sh'
  zinit light athityakumar/colorls

  source $(dirname $(gem which colorls))/tab_complete.sh

  export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --height 100% --reverse --inline-info
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

  # It is adviced to load compinit before fzf-tab
  autoload -U compinit && compinit

  zinit light Aloxaf/fzf-tab

  zinit ice lucid wait'0'
  # zinit light hariprasadraja/zsh-fzf-history-search
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light MichaelAquilina/zsh-you-should-use
  zinit light zdharma-continuum/fast-syntax-highlighting

  # Teminal Prompt
  zinit ice depth=1
  zinit light romkatv/powerlevel10k
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh &> /dev/null
  source $DOTFILES_PATH/configs/prompt/p10k.zsh &>/dev/null

  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  source $DOTFILES_PATH/configs/prompt/p10k-instant-prompt.zsh &>/dev/null

  # if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  # fi

  zinit ice as"program" depth=1 pick"desk"
  zinit light jamesob/desk

  zinit ice as"program" pick"revolver"
  zinit light molovo/revolver

  # Git
  zinit light unixorn/git-extra-commands
  zinit ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
  zinit light tj/git-extras

  zinit ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
    atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
  zinit light k4rthik/git-cal

  zinit ice as"program" src"git-sync.sh"
  zinit light hariprasadraja/zsh-git-sync

  zinit ice as"program"
  zinit load gpakosz/.tmux

  zinit light trystan2k/zsh-tab-title

  # rm command with careful deletion
  zinit load MikeDacre/careful_rm

  # emoji cli on command line
  zinit light "b4b4r07/emoji-cli"

  # gpg encrypt and decrypt
  zinit light Czocher/gpg-crypt

  # need to fix the autocomplete for this...
  zinit ice atclone'sudo make install' atpull'%atclone'
  zinit load arzzen/git-quick-stats

  # git open remote url in browser
  zinit ice as"program"
  zinit load paulirish/git-open

  # ssh completion
  zinit light zpm-zsh/ssh

  # know your internet speed from your terminal
  zinit ice as"program" mv"speedtest.py -> speedtest"
  zinit load sivel/speedtest-cli

  zinit light reegnz/jq-zsh-plugin # jq-repl

  zinit ice from"gh-r" as"program"
  zinit light client9/misspell

  # zunit - unit testing for zsh
  zinit ice wait"2" lucid as"program" pick"zunit" \
    atclone"./build.zsh" atpull"%atclone"
  zinit load molovo/zunit

  # This plugins adds start, restart, stop, up and down commands when it detects a docker-compose or Vagrant file in the current directory (e.g. your application). Just run up and get coding! This saves you typing docker-compose or vagrant every time or aliasing them. Also gives you one set of commands that work for both environments.
  zinit light Cloudstek/zsh-plugin-appup

  # autols
  zinit ice wait'0' lucid
  zinit load desyncr/auto-ls

  # disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# preview directory's content with colorls when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always --icon=always $realpath'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
}


function _main() {
  [ ! -d "${DOTFILES_MACHINE_PATH}" ] && mkdir -p ${DOTFILES_MACHINE_PATH}
  [ -f "${DOTFILES_MACHINE_PATH}/init.sh" ] && source ${DOTFILES_MACHINE_PATH}/init.sh

  # Initialize your personalize global configuratio
  source "${DOTFILES_PATH}/configs/init.sh"

  # Set $TERM environment
  if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color'
  elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color'
  fi

  # initiate color codes
  source "${DOTFILES_PATH}/configs/colors/colors.sh" &>/dev/null
  source "${DOTFILES_PATH}/configs/fzf.sh" &>/dev/null

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