#!/usr/bin/env bash

echo -e "
    This Task will securely copy your ${DOTFILES_PATH} to an remote machines file system.
"

read -p "which remote machine do you like to connect? " remote
echo -e "Remote Machine: ${remote}"

read -p "where you need to save .bashconfig in remote machine? " remote_path
echo -e "Remote Machine Location: ${remote_path}"

scp -Cpvr ${DOTFILES_PATH} ${remote}:${remote_path}
