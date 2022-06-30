#!/usr/bin/env bash

# Install fonts
# Hold it, it takes more time for setup
if [ ! -f "/usr/local/share/fonts.lock" ]; then
  for file in $DOTFILES_PATH/etc/fonts/*/*; do
    file_name=$(basename $file)
    if [ ! -f "~/usr/local/share/$file_name" ]; then
      cp $file ~/usr/local/share/fonts
      echo $file >>/usr/local/share/fonts.lock
    fi

    # clear and re generate cache
    fc-cache -f -v
  done
fi


## Optional shortcut for iptables and pass it via sudo
if [ $(command -v $(which iptables)) ]; then
  install iptables
  alias ipt='sudo $(which iptables)' # display all rules #
  alias iptlist='sudo $(which iptables) -L -n -v --line-numbers'
  alias iptlistin='sudo $(which iptables) -L INPUT -n -v --line-numbers'
  alias iptlistout='sudo $(which iptables) -L OUTPUT -n -v --line-numbers'
  alias iptlistfw='sudo $(which iptables) -L FORWARD -n -v --line-numbers'
fi

if [ ! $(command -v ruby) ]; then
  install ruby-full
fi

if [ ! $(command -v ag) ]; then
  brew install silversearcher-ag
fi

