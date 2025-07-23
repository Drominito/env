#!/bin/bash

file="$1"
mimetype=$(file --mime-type -Lb "$file")

case "$mimetype" in
  image/*)
    chafa "$file"
    ;;
  *)
    echo "No preview for $file"
    ;;
esac

