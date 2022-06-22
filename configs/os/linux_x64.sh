#!/usr/bin/env bash

#=================================================================================
#title           :linux_x64.sh
#description     :This script contains aliases and configuration for linux machines
#author		 	 :hariprasad <hariprasadcsmails@gmail.com>
#version         :1.0
#bash_version    :bash 4.3.48
# inspiered 	 :https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
#=============================================================================

# grep pattern for fixed strings spereated by new line
alias fgrep='fgrep --color=auto'

# grep pattern as an extended regular expression
alias egrep='egrep --color=auto'


alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# reboot / halt / poweroff
alias restart='shutdown -r +5 "Server will restart in 5 minutes. Please save your work."'
alias poweroff='sudo /sbin/poweroff'
alias shutdown='shutdown -h +5 "Server will shutdown in 5 minutes. Please save your work."'

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## git kraken open##
alias gk='gitkraken -p'

# untar FileName to unpack any .tar file.
# add -z for zip file
alias untar='tar -xvf '

# generate a random, 20-character password for a new online account
alias getpass="openssl rand -base64 20"

# Downloaded a file and need to test the checksum
alias sha='shasum -a 256 '

# External Ip address or Public Ip address
alias ipe='curl ipinfo.io/ip || (curl http://ipecho.net/plain; echo)'

#local ip address
alias ipl="hostname -I | awk '{print $1}'"

# list all ips  this machine
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# print files which are in trash
alias lstrash="gvfs-ls -h trash:///"

alias update='apt-fast update && apt-fast upgrade'
alias install='apt-fast install'
alias remove='apt-fast remove'

# Install fonts
for file in $DOTFILES_PATH/etc/fonts/*/*; do
  file_name=$(basename $file)
  if [ ! -f "~/usr/local/share/$file_name" ]; then
    cp $file ~/usr/local/share/fonts
  fi

  # clear and re generate cache
  fc-cache -f -v
done
