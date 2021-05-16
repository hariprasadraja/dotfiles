#!/usr/bin/env bash

if [ ! $(command -v apt-fast) ]; then
  util log info "installing $(%s) for fast package downloads" "apt-fast"
  sudo add-apt-repository ppa:apt-fast/stable
  sudo apt-get update
  sudo apt-get -y install apt-fast
fi

if [ ! $(command -v nodejs) ]; then
  util log info "installing $(%s) for fast package downloads" "nodejs"
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs
else
  util log info "node already installed"
  node --version
  npm --version
fi

if [ ! $(command -v ruby) ]; then
  sudo apt-fast install ruby-full
fi

# Finaly Create the system links
ln -s ~/dotfiles/zshrc.zsh ~/.zshrc
