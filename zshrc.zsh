# Path where the dotfiles directory resides
export DOTFILES_PATH="$HOME/dotfiles"

# Path where your machine specific directroy resides
export DOTFILES_MACHINE_PATH="$DOTFILES_PATH/machine"

# update python path for the utils command
export PYTHONPATH="$PYTHONPATH:$DOTFILES_PATH/etc/utils"

setopt COMPLETE_ALIASES

function _init_os() {
  case $(uname) in
  Darwin)
    source "${DOTFILES_PATH}/configs/os/mac_x64.sh" &>/dev/null
    ;;
  Linux)
    source "${DOTFILES_PATH}/configs/os/linux_x64.sh" &>/dev/null
    ;;
  *)
    util log warn "unknown Operating system %s,
      failed to load Operating System specific configurations" $(uname)
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

function _tag() {
  command tag "$@"
  source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null
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

  zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
  zinit light sharkdp/fd

  # install fzf
  zinit ice from"gh-r" as"program"
  zinit light junegunn/fzf

  # delta diff tool for git
  zinit ice from"gh-r" as"program"
  zinit light dandavison/delta

  # colorls - depends on ruby
  zinit ice depth=1 has'gem' atpull'%atclone' atclone'
  gem build colorls.gemspec -o colorls \
  && sudo gem install colorls' src'lib/tab_complete.sh'
  zinit light athityakumar/colorls

  source $(dirname $(gem which colorls))/tab_complete.sh


  # Press the Control + Shift + Left key combination to cycle backward through the directory stack.
  # Press the Control + Shift + Right key combination to cycle forward through the directory stack.
  # BUG: not working
  # zinit ice src"dircycle.zsh"
  # zinit light michaelxmcbride/zsh-dircycle

  export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --height 100% --reverse --inline-info
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

  # command line snippet manager
  zinit ice has'go' as"program" atclone'go build' atpull'%atclone;'
  zinit light hariprasadraja/pet
  zinit creinstall hariprasadraja/pet &>/dev/null

  # It is adviced to load compinit before fzf-tab
  autoload -U compinit && compinit

  if [ `command -v kubectl` ]; then
    source <(kubectl completion zsh)
  fi

  zinit light Aloxaf/fzf-tab

  zinit ice lucid wait'0'
  # zinit light hariprasadraja/zsh-fzf-history-search
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light MichaelAquilina/zsh-you-should-use
  zinit light zdharma-continuum/fast-syntax-highlighting

  zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
  zinit light direnv/direnv

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

  if [ ! -f "${DOTFILES_PATH}/bin/micro" ]; then
    echo "> Installing `micro` editor"
    # Install micro editor - https://micro-editor.github.io/index.html
    curl https://getmic.ro | bash && cp ./micro ${DOTFILES_PATH}/bin && export EDITOR='${DOTFILES_PATH}/bin/micro'
  fi

  # zinit ice from"gh-r" as"program" pick"bat-*/bat" mv"bat-*/autocomplete/bat.zsh -> _bat"
  # zinit light sharkdp/bat
  alias cat='bat'
  export PAGER='bat --style="header,changes" --decorations="always"'

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

  # ag command wrapper
  zinit ice from"gh-r" as"program" pick'tag' atclone'make build' atpull'%atclone'
  zinit load aykamko/tag

  if [ $(command -v tag) ]; then
    export TAG_SEARCH_PROG=ag # replace with rg for ripgrep
    export TAG_CMD_FMT_STRING='micro {{.Filename}} +{{.LineNumber}}:{{.ColumnNumber}}'
    alias ag=_tag # replace with rg for ripgrep
  fi

  # ssh completion
  zinit light zpm-zsh/ssh

  # terminal browser for low internet connection
  zinit ice from"gh-r" as"program" mv'browsh* -> browsh' pick'browsh'
  zinit light browsh-org/browsh

  # ssh deployement helper tool
  zinit ice pick"shipit"
  zinit light sapegin/shipit

  # know your internet speed from your terminal
  zinit ice as"program" mv"speedtest.py -> speedtest"
  zinit load sivel/speedtest-cli

  zinit ice from"gh-r" as"program" mv"docker* -> docker-compose"
  zinit light docker/compose

  # jarun/nnn, a file browser
  # zinit ice pick"misc/quitcd/quitcd.bash_zsh" atclone'sudo make O_NERD=1' atpull'%atclone' mv"plugins -> ${HOME}/.config/nnn/"
  # zinit light jarun/nnn
  # zinit ice as"completion" pick"_nnn"
  # zinit snippet https://github.com/jarun/nnn/tree/master/misc/auto-completion/zsh/_nnn
  # alias ls="nnn -de" # n is the quitcd function for nnn

  # vim latest - yet to decide
  # zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
  #     atpull"%atclone" make pick"src/vim"
  # zinit light vim/vim

  # jq - json parser in terminal
  zinit ice from"gh-r" as"program" mv"jq* -> jq"
  zinit light stedolan/jq
  zinit light reegnz/jq-zsh-plugin # jq-repl

  zinit ice from"gh-r" as"program"
  zinit light client9/misspell

  # zunit - unit testing for zsh
  zinit ice wait"2" lucid as"program" pick"zunit" \
    atclone"./build.zsh" atpull"%atclone"
  zinit load molovo/zunit

  # command not found message
  zinit light Tarrasch/zsh-command-not-found

  # This plugins adds start, restart, stop, up and down commands when it detects a docker-compose or Vagrant file in the current directory (e.g. your application). Just run up and get coding! This saves you typing docker-compose or vagrant every time or aliasing them. Also gives you one set of commands that work for both environments.
  zinit light Cloudstek/zsh-plugin-appup

  # autols
  zinit ice wait'0' lucid
  zinit load desyncr/auto-ls

  # replace history file with atuin history database
  export ATUIN_NOBIND="true"
  bindkey '^r' _atuin_search_widget

}


function _main() {
  if [ ! -d "${DOTFILES_MACHINE_PATH}" ]; then
    mkdir -p ${DOTFILES_MACHINE_PATH}
  fi

  if [ -f "${DOTFILES_MACHINE_PATH}/init.sh" ]; then
    source ${DOTFILES_MACHINE_PATH}/init.sh
  fi

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

  #  Initialize Operating System Specific configurations
  _init_os && unset -f _init_os


  _zinit_setup && unset -f _zinit_setup

  # Initialize your personalize global configuration
  source "${DOTFILES_PATH}/configs/init.sh"

  _welcome-message && unset -f _welcome-message

  # Hook for desk activation
  [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

}

# unset functions after it's usages.
_main && unset -f _main

# NOTE: need to find why moving this line inisde the zinit setup is not working
# it showes _atuin_search_widget unknown
# eval "$(atuin init zsh)"

# eval $(thefuck --alias)



test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

