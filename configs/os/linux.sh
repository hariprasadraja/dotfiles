#!/usr/bin/env bash

# Install fonts
fonts=('FiraCode.zip' 'DaddyTimeMono.zip' 'SourceCodePro.zip' 'CascadiaCode.zip')
font_dir=~/.local/share/fonts
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
  fc-cache -f -v
fi
