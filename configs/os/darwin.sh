#!/usr/bin/env bash
# Install fonts
# Hold it, it takes more time to setup
fonts=('FiraCode' 'DaddyTimeMono' 'SourceCodePro' 'CascadiaCode')
font_dir=~/Library/Fonts
newfont=false
for font in $fonts; do
  if [ ! -f "$font_dir/$font.zip" ]; then
    echo "Installing $font_dir/$font.zip"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip
    cwd=$PWD
    mv $font.zip $font_dir && cd $font_dir && unzip $font_dir/$font.zip && cd $cwd
    newfonts=true
  fi
done

if [ "$newfonts" = "true" ]; then
  sudo atsutil databases -remove && atsutil server -shutdown && atsutil server -ping
fi

# iterm2 shell integration https://iterm2.com/documentation-shell-integration.html
if [ ! -f "${HOME}/.iterm2_shell_integration.zsh" ]; then
  echo "> Installing iterm2 shell integration"
  curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | zsh
else
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

