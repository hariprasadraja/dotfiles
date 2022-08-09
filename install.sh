#!/usr/bin/env zsh


# Install all needed dependencies for the dotfiles


if [ ! `command -v brew` ]; then
  echo "Homebrew is required to run 'hariprasadraja/dotfiles' .... installing `homebrew`"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  return 0
fi

# if type brew &>/dev/null;then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
# fi



# brew uninstall delta  - before running this.
dependencies=(
  'coreutils'
  'nodejs'
  'git'
  'most'
  'bat'
  'the_silver_searcher'
  'tag-ag'
  'ruby'
  'go'
  'python3'
  'desk'
  'micro'
  'zinit'
  'fzf'
  'fd'
  'wget'
  'lsd'
  'git-delta'
  'direnv'
  'docker'
  'docker-completion'
  'docker-compose'
  'gojq'
  'ctags'
  'git-extras'
  'git-cal'
  'speedtest-cli'
  'make'
  'zsh'
  'zsync'
  'zinit'
  'golangci-lint'
  'fd'
  'lesspipe'
  'csvkit'
  'chafa'
  'exiftool'
  'xsv'
  'tldr'
)

brew tap aykamko/tag-ag
brew uninstall delta
brew install --overwrite $dependencies
brew upgrade
zinit self-update

actual_zshrc=$(cat ~/.zshrc)
if [[ "$actual_zshrc" = *dotfiles/zshrc.zsh* ]]; then
  echo "dofitles arleady sourced from ~/.zshrc"
  return 0
fi




zshrc_source='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [ -f ~/dotfiles/zshrc.zsh ]; then
    source ~/dotfiles/zshrc.zsh
fi'

echo "\n Adding dotfiles/zshrc to your ~/.zshrc \n $zshrc_source"
echo $zshrc_source >> ~/.zshrc

