#!/usr/bin/env bash

# Install fonts
fonts=('FiraCode' 'DaddyTimeMono' 'SourceCodePro' 'CascadiaCode')
font_dir=~/usr/local/share/fonts
for font in $fonts; do
  if [ ! -f "$font_dir/$font.zip" ]; then
    echo "Installing $font_dir/$font.zip"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip
    cwd=$PWD
    mv $font.zip $font_dir && cd $font_dir && unzip $font_dir/$font.zip && cd $cwd
    fc-cache -f -v
  fi
done