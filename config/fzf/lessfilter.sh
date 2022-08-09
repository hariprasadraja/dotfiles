#!/usr/bin/env sh

mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}

echo "\033[1;32m $1 \033[0m \n"

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


if [ "$category" = image ]; then
  chafa "$1"
  exiftool "$1"
  return
fi

if [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] || \
[ "$kind" = vnd.ms-excel ]; then
  in2csv "$1" | xsv table | bat -ltsv --color=always
  elif [ "$category" = text ]; then
  bat --color=always --style=numbers "$1"
else
  lesspipe.sh "$1" | bat --color=always --style=numbers
fi
