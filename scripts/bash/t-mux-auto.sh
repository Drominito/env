#!/bin/bash
# this script is executed in a subshell from .bashrc.
# otherwise the exit-cmd would exit also the tmux session.

DEBUG=0
DEBUG() {
    [[ "$DEBUG" -eq 1 ]] && printf "%s\n" "$*"
}


# ups, I dont have to care how many they are
# now only usefol for the loop
kitty_amnt="$(pgrep kitty | wc -w)"
start_tmux=0


if [[ -z $(tmux ls) ]]; then
	DEBUG "tmux not found - creating new tmux-session.."
	tmux new -s m
	exit
fi

if [[ $TMUX ]]; then
	DEBUG "you're already in."
	exit
fi



for i in $(seq 1 $kitty_amnt); do
	DEBUG "-- --"
	kitty_arr="$(pgrep kitty | awk -v i="$i" 'NR==i')"
	tmux_in_kitty="$(pstree $kitty_arr | rg -w tmux)"
	DEBUG "tmux_in_kitty[$i]=\n$tmux_in_kitty"
	
	if [[ "$tmux_in_kitty" == *"tmux"* ]]; then
	
		DEBUG "tmux *is* in $kitty_arr(kitty - don't start tmux)"

		# lol I had to add this too, bc the
		# else-block turned the first val back to on.
		start_tmux=0
		break
	else
		DEBUG "no tmux in $kitty_arr(kitty)"
		start_tmux=1
	fi
done

if [[ "$start_tmux" -eq 0 ]]; then
	DEBUG
	DEBUG "some kitty terminal already own tmux."
	DEBUG "so you dont allow to anymore!"
else
	DEBUG "attaching! :D"	
	tmux attach
fi
