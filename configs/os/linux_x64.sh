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
