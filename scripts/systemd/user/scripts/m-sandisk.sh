#!/bin/bash
# Later moved to something like "runtime-setup/init".
# It will every time started when river will be executed.
# Now i just add this script in the init file directly

# only useful when i will stick the disk later
# and update e.g swww with riverctl automatically.

#tmp_file=/tmp/checksandisk.txt
#touch $tmp_file
#echo "" > $tmp_file
# while read path event file; do
#     if [[ "$file" =~ ^sd[a-z][0-9]*$ ]]; then
#         echo "Blockgerät erkannt: $file"
#         echo "$file" > $tmp_file
#         break
#     else
#         echo "Übersprungen: $file"
#     fi
# done < <(inotifywait -m -e create --format '%w %e %f' /dev)

# didn't knew that it could be so simple :D
LABEL="sandiskS"
PART="$(readlink -f /dev/disk/by-label/$LABEL)"

if [[ -z "PART" ]]; then
    notify-send "$LABEL currently not found - waiting for it..."
    touch $tmp_file
    echo "" > $tmp_file
     while read path event file; do
         sleep 5
         if [[ "$file" =~ ^sd[a-z][0-9]*$ ]]; then
             notify-send "Blockgerät erkannt: $file"
             echo "$file" > $tmp_file
             break
         else
             notify-send "Übersprungen: $file"
         fi
     done < <(inotifywait -m -e create --format '%w %e %f' /dev)

fi 

if [[ -b "$PART" ]]; then
    udisksctl mount -b $PART --no-user-interaction
    notify-send "mounted: '$PART'.."
    ln -sf /run/media/$USER/$LABEL/ $HOME/media/sandisk
else
    notify-send "something went wrong - return value is $?"
    notify-send "detected device: '$PART'.."

fi
