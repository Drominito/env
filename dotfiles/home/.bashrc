# ~/.bashrc

# Umgebungsvariablen
export PATH="$HOME/bin:$PATH"
export EDITOR=vim # oder vim, wenn du es bevorzugst

# Terminal-Optionen
PS1='[\u@\h \W]\$ '

# Um den Verlauf zu konfigurieren (optional)
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

mkc() {
  mkdir -p "$1" && cd "$1"
}

cl() {
    cd "$1" && ls
}

reverse_lines() {
  awk '{ lines[NR] = $0 } END { for (i = NR; i > 0; i--) print lines[i] }'
}

it() {
    count=$1
    shift
    for i in $(seq 1 "$count"); do
        "$@"
    done
}

alias dagit="dagit_Linux_arm64"
alias l="ls -al"
alias git-vis="git log --all --topo-order --graph --show-signature"
alias yayy="sudo pacman -Syu && sleep 5 && yay -Syu"
alias nano='vim'


export PATH="$HOME/dromi/var/:$PATH"
export PATH="$HOME/games/mc/PolyMC/build:$PATH"
export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"


export GPM_MOUSE=/dev/gpmctl
export GPM_MOUSE="/dev/gpmctl"


export PATH=$PATH:/home/dromi/.spicetify

#alias tvim="tmux new -d && tmux send-keys -t 0 'vim' C-m && tmux attach"
alias tmux-a="tmux attach"
alias tmux-s="tmux list-session"
alias tvim="tmux new 'vim' \; attach"
alias treee="tree | less"

# obsidian - alias vs. symbolic link?
#alias osi="~/mm/pesno/obsidian/Second-Brain/"


export PATH=/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/flow:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/var/lib/snapd/snap/bin

export PATH=/home/dromi/go/bin/:/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/flow:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/var/lib/snapd/snap/bin:/home/dromi/.spicetify


#sudo gpm -m /dev/input/mice -t imps2
export XDG_CONFIG_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.local/share/"
export PATH=$PATH:/$HOME/.local/bin:
export YDOTOOL_SOCKET=/run/user/1001/ydotoold_socket

#echo 3 > /sys/class/graphics/fbcon/rotate_all
alias python3.11="/opt/python-3.11/bin/python3.11"
export PATH="$HOME/repos/tdf/target/release:$PATH"
PATH=/home/dromi/repos/spotify-qt/build:/home/dromi/repos/tdf/target/release:/home/dromi/go/bin/:/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/:/home/dromi/.cargo/bin/flow:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/home/dromi/games/mc/PolyMC/build:/home/dromi/dromi/var/:/home/dromi/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/var/lib/snapd/snap/bin:/home/dromi/.spicetify://home/dromi/.local/bin:
alias ssh="TERM=xterm-256color \ssh"
export XDG_CONFIG_HOME=/home/dromi/.config/
