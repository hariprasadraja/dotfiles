#!/usr/bin/env sh

source $DOTFILES_PATH/config/colors/colors.sh
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}

echo "$BGREEN $1 \t\t $YELLOW MIME:$ORANGE $mime $RESET \n"

function less_print() {
# directory type
if [ -d "$1" ]; then
  lsd -1 --color=always --icon=always $realpath
  return
fi

# file type
if [ -f "$file" ]; then
  bat --color=always --style=numbers $realpath
  return
fi

if [ "$kind" = "zip" ]; then
  unzip -l $1 | bat --color=always --style=numbers
  return
fi

if [ "$kind" = "x-empty" ]; then
  echo "-- Empty File --"
  return
fi

if [ "$category" = image ]; then
  chafa "$1"
  exiftool "$1"
  return
fi

if [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] || \
[ "$kind" = vnd.ms-excel ]; then
  in2csv "$1" | xsv table | bat -ltsv --color=always
  return
  elif [ "$category" = text ]; then
  bat --color=always --style=numbers "$1"
  return
else
  lesspipe.sh "$1" | bat --color=always --style=numbers
  return
fi

# unknown file type

echo "Can't preview. Unknown File Format"

}

less_print $1