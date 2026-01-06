# ~/.bash_aliases
# fun fact: i typed this right name of it by accident.

# This file is for simple command shortcuts that don’t need ifs/loops or fit well in one line.
# Purpose: usable also in Vim or Makefiles via sourcing.
# Linked from .bashrc for cleanliness and DRYness.

# === ARGS ===
#: -al = -lah(more space becuase of -h) | -ha = does nothing
alias l=' 		  eza --icons -al  $1'
alias l='clear;eza --icons -lah $1'
alias la=' 		  eza --icons -ha  $1 ' # al-lah-ha xD

alias sl='eza --icons $1' # not this time my locomotive!
alias ls='eza --icons $1'
alias lss='clear;eza --icons $1'

alias cd='z'
alias cdd='zi'

alias lavatt='lavat -c yellow -R1 -k red'

alias cdi='cd $(fzf --walker=dir)'

alias dattee='watch -n 1 date +%X'
alias datte='termdown --time'

alias gs='git status'

alias ki='kitten icat'

alias sshc='TERM=xterm-256color ssh'
alias s='source ~/.bashrc'
alias ssr='systemctl soft-reboot'

alias aii='asciinema p'
alias ai='asciinema p $(wl-paste)'

alias t='clear && task'
alias ttermin='clear && task cale && task due'
alias transs='trans en:de'
alias ttrans='trans de:en'


# === NO ARGS / SPECIAL TOOLS ===

alias lskde="kdeconnect-cli -l | awk 'NR==1 {print \$4}'"

alias sim-wl='export WAYLAND_DISPLAY=wayland-1'
alias iwctll='iwctl adapter phy0 set-property Powered on && sleep 1 && sudo dhcpcd'

alias c='clear'
alias e='exit'
alias gg='git-graph'
alias nc='--noconfirm'


# ah yes, these windows vibes...
# oh, and cmd ~= *c*lean *c*ommand xD 
# Usecase: have ls as eza. dont wanted type /bin/ls
alias cmd='command'

alias p='ping archlinux.org'
alias b='cat /sys/class/power_supply/BAT0/capacity'

# 
alias bin-clear='rm ~/.cmd/*'

alias f='head -n 1'
alias ff='file'

alias fgg='fg; fyi done:'

# pull -> change also the ename of the tmux-window to 'pull'
alias pull='sudo pacman --noconfirm -Syu && sleep 3 && paru -Sua --noconfirm && fyi "whole update done."'
alias rmpac='sudo rm /var/lib/pacman/db.lck' # forgot if this is right

alias git-vis='git log --all --topo-order --graph --show-signatur'

alias m='man'
alias mann='man man'


alias trees='tree | less'
alias tmux-a='tmux attach'
alias tmux-s='tmux list-session'
alias tvim='tmux new "vim" \; attach'

alias python3.11='/opt/python-3.11/bin/python3.11'

# list downloaded packages
alias plog="pkghist --no-details | bat"


alias loremm='curl https://loremipsum.de/downloads/original.txt | wl-copy'
alias loremm1='curl https://loremipsum.de/downloads/version1.txt | wl-copy'
alias loremm2='curl https://loremipsum.de/downloads/version2.txt | wl-copy'

alias lorem='curl https://loremipsum.de/downloads/original.txt'
alias lorem1='curl https://loremipsum.de/downloads/version1.txt'
alias lorem2='curl https://loremipsum.de/downloads/version2.txt'

alias rreset="faillock --user $USER --reset"

# -- --
alias taskmc="$HOME/repo/taskmc/taskmc/taskmc.py"
alias vg="vanguard"
alias tmuxreload='tmux source-file ~/.tmux.conf && tmux display-message "Config Reloaded!"'



alias cc="xclip"
alias vv="xclip -o"


alias ts='tailscale'

alias i='instal'
alias ii='i --noconfirm'
alias iinstal='sudo pacman -Sy'

# *p*ackage-owner
alias pown='pacman -Qo'


alias srpkg='paru -Ss'
alias srpkgp='pacman -Ss'



# just same letter as the first instead of 'o' for offline.
# maybe also lsrpkg for 'local'
alias ssrpkg='pacman -Qs' 


alias pl='plocate'
alias ipp="ip a | awk '/inet / && /192/ {print }' | cut -d/ -f1 | cut -c 10-"
alias pp='curl ifconfig.me'



alias wll='tplay "$HOME/mm/img/grim/file.png"'

# Comments / Notes
# alias dagit="dagit_Linux_arm64" # just to know about dagit
# alias tvim='tmux new -d && tmux send-keys -t 0 "vim" C-m && tmux attach'

alias venv='source ~/.venv/bin/activate'
alias ani39='source ~/.ani39/bin/activate'
alias yay='paru'

alias fplay='ffplay -nodisp -autoexit'
alias song_title='mediainfo --Inform="General;%Title%"'
alias wp='wl-copy <'
