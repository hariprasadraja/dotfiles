#!/usr/bin/env sh


# Install all needed dependencies for the dotfiles


if [ ! `command -v brew` ]; then
  echo "Homebrew is required to run 'hariprasadraja/dotfiles'. Please install it."
  return 0
fi

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

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
  "zsync"
  "zinit"
  "golangci-lint"
  "fd"
)

brew tap aykamko/tag-ag
brew uninstall delta
brew install --overwrite $dependencies