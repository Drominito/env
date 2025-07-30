#!/bin/bash

target=$HOME/media/sandisk
tmp_file=/tmp/checksandisk.txt
touch $tmp_file
echo "" > $tmp_file



while read path event file; do
    if [[ "$file" =~ ^sd[a-z][0-9]*$ ]]; then
        echo "Blockgerät erkannt: $file"
        echo "$file" > $tmp_file
        break
    else
        echo "Übersprungen: $file"
    fi
done < <(inotifywait -m -e create --format '%w %e %f' /dev)


part="$(cat $tmp_file)1"
bool_part=$(lsblk -f -J | jq -r --arg "$part" '
  .blockdevices[]
  | recurse(.children[]?)
  | select(.name == $part) and .label == "sandiskS")
')


if [[ -n $bool_part ]]; then
    kitty -- notify-send "user-mount with 'udiskctl' /dev/$part"
    udisksctl mount -b /dev/$part 2>&1 | tee /tmp/udisksctl.log
    ln -sf /run/media/dromi/sandiskS/ $HOME/media/sandisk
    #sudo mount /dev/$part $target
    #chown -R dromi:dromi $target 
else
    notify-send "something went wrong - return value is $?"
    notify-send "part is $part"
fi
