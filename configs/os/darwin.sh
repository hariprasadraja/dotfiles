#!/usr/bin/env bash
# Install fonts
# Hold it, it takes more time to setup
fonts=('FiraCode.zip' 'DaddyTimeMono.zip' 'SourceCodePro.zip' 'CascadiaCode.zip')
font_dir=~/Library/Fonts
[ ! -d $font_dir ] && mkdir -p $font_dir
for font in $fonts; do
  if [ ! -f "$font_dir/$font" ]; then
   URL_LIST+=("https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font")
  fi
done

if [ ${#URL_LIST[@]} > 0 ]; then
  cwd=$PWD && cd $font_dir
  echo $URL_LIST | xargs -n 1 -P 4 wget
  echo $fonts | xargs -n 1 -P 4 unzip -f
  cd $cwd
  sudo atsutil databases -remove && atsutil server -shutdown && atsutil server -ping
fi

# iterm2 shell integration https://iterm2.com/documentation-shell-integration.html
if [ ! -f "${HOME}/.iterm2_shell_integration.zsh" ]; then
  echo "> Installing iterm2 shell integration"
  curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | zsh
else
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

