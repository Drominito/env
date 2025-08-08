#!/usr/bin/bash

# erstes Argument ist für den Modus.
# - 0 für das setzen die strings das dort die namen der layouts enthalten
# - 1 für das inkrementieren der variable *i* um auf das nächste Layout zu wechseln

# ich könntete auch direkt $@ machen, aber dafür müsstete ich die **anzahl** kennen.
# In meinem fall reicht es aber auch so aus - arr=(neo_qwertz neo de)

path_i="$HOME/.cache/tmp/layout_index"
layout_stack_target="$HOME/.cache/tmp/layout_stack" # holding the riverctl-. comands 
layout_stack_origin="./layout_stack" # holding the riverctl-. comands 

layout_names=( "neo_qwertz" "neo" "de")
layout_nicknames="$HOME/.cache/tmp/layout_nicknames"

if [[ -e $path_i && -e $layout_stack_target && -e $layout_nicknames ]]; then
    i=$(cat "$path_i")
else
    touch $path_i
    touch $layout_stack_target
    touch $layout_nicknames

    cat "$layout_stack_origin" > "$layout_stack_target"
    echo "${layout_names[@]}" > $layout_nicknames

    #notify-send "log: creating path_i and layout_stack_target files…"
    i=0
fi

mapfile -t arr < "$layout_stack_target"

if (( i == 2 )); then
    i=0
    echo "$i" > "$path_i"
    #$()
else
    ((i++))
fi
# execute the riverctl keyboard-layout commands
#notify-send "log: executing command: ${arr[i]}"
#notify-send "log: Current layout: ${layout_names[i]}($i)"
export WAYLAND_DISPLAY=wayland-1
${arr[i]} 2> ~/.cache/tmp/riverctl.log 

# file-update i
echo "$i" > $path_i
