#!/usr/bin/env bash

# Install fonts
# Hold it, it takes more time to setup
if [ ! -f "/usr/local/share/fonts.lock" ]; then
  for file in $DOTFILES_PATH/etc/fonts/*/*; do
    file_name=$(basename $file)
    if [ ! -f "~/Library/Fonts/$file_name" ]; then
      cp $file ~/Library/Fonts/
      echo $file >>/usr/local/share/fonts.lock
    fi
  done
fi

# iterm2 shell integration https://iterm2.com/documentation-shell-integration.html
if [ ! -f "${HOME}/.iterm2_shell_integration.zsh" ]; then
  echo "> Installing iterm2 shell integration"
  curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | zsh
else
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi
