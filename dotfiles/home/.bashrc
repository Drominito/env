# ~/.bashrc

[ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && exec river

if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
   # tty only 
   PS1='[\u@\h \W]\$' 

   # do it later as an function 
   stty susp ^K
else
   eval "$(starship init bash)"
fi

# startup

if [ -z "$WAYLAND_DISPLAY" ]; then
	export WAYLAND_DISPLAY="wayland-1"
fi

## load api-key's
# . ~/.k/ai


# it have to be t-* because, ripgrep cannot distinguish the raw text
# in pstree of 'tmux-auto.sh' as script and 'tmux' itself
# so that's my lazy, but fast solution for it.
bash -c "$HOME/repo/env/scripts/bash/t-mux-auto.sh"

#ntfy sub mama 'fyi $topic: $t - $m' & # moved to systemd



# other stuff
# source "/home/dromi/.config/broot/launcher/bash/br" # alternative to vifm

export EDITOR="vim"

export XDG_CONFIG_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="/home/dromi/.config/"

export GPM_MOUSE="/dev/gpmctl"
export YDOTOOL_SOCKET="/run/user/1001/ydotoold_socket"

export PATH="$PATH:\
/usr/{bin/{.,{site,vendor,core}_perl},local/{bin,sbin},lib/{jvm/default/bin,rustup/bin}}:\
/var/lib/{flatpak/exports/bin,snapd/snap/bin}:\
$HOME/{games/mc/PolyMc/build,.local/share/gem/ruby/3.4.0,.cargo/bin,.spicetify,.xbin}"

export PATH="$PATH:$HOME/bin/tilde"
   

HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# while IFS= read -r line || [ -n "$line" ]; do
#     # Kommentare und leere Zeilen ignorieren
#     line="${line%%#*}"           # Inline-Kommentar entfernen
#     line="${line#"${line%%[![:space:]]*}"}"
#     line="${line%"${line##*[![:space:]]}"}"
#     [ -z "$line" ] && continue
# 
#     # Prüfe auf Modus-Marker
#     case "$line" in
#         :args) mode="args"; continue ;;
#         :noargs) mode="noargs"; continue ;;
#     esac
# 
#     # Name und Befehl trennen
#     name="${line%%=*}"
#     cmd="${line#*=}"
#     name="${name#"${name%%[![:space:]]*}"}"
#     name="${name%"${name##*[![:space:]]}"}"
#     cmd="${cmd#"${cmd%%[![:space:]]*}"}"
#     cmd="${cmd%"${cmd##*[![:space:]]}"}"
#     [ -z "$name" ] && continue
# 
#     echo "name is '$name' | cmd is '$cmd'"
#     eval "alias $name='$cmd'"
# 
# done < "$HOME/.alias-blueprint.txt"
# 

# It's just to complicated to make alias'es from .alias-blueprint.txt —
# And at the same time be compatbile as an executable.
# So i decided temporarly just use it as an bin-file

export PATH="$PATH:$HOME/.cmd"


# Solution: make the aliases here.
# But some later, i've spend time to much on this 😵
# I have also to manage, that i will be comaptible with ~/.gen-cmd
# But have to decide if using bash aliases at all, when i could just use these bin's

# NEW: I just put everything in normal bash files, now i'll have just to convert it to binary only.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
    . ~/.bash_fn
fi







#timer() {
#termdown
#fyi
#}

# /home/dromi/go/bin/:
#export PATH="$HOME/repos/tdf/target/release:$PATH"
# obsidian - alias vs. symbolic link?
#alias osi="~/mm/pesno/obsidian/Second-Brain/"

#HISTCONTROL=ignoredups:ignorespace

# Notes
# Notes
# Notes
# Notes
# .bash_events
# .bash_startup/autostart

# Wird vor jedem Prompt ausgeführt:
# Die info soll in dem tmux pane eingefügt werden.
# Jeder meiner Name zum Pane 'X' soll dann davor 'p: ...' hinterlegt werden.

# PROMPT_COMMAND='update_prompt_state'
# 
# update_prompt_state() {
#   if [ -n "$(jobs -r)" ]; then
#     export PS1="p: \$ "
#   else
#     export PS1="\$ "
#   fi
# }
# 

# bind -x '"\r": handle_enter'
# 
# handle_enter() {
#   if [ -n "$(jobs -r)" ]; then
#     READLINE_LINE="p: ${READLINE_LINE}"
#     READLINE_POINT=${#READLINE_LINE}
#   fi
# }
# 

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/dromi/.local/share/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

eval "$(zoxide init bash)"
eval "$(register-python-argcomplete pipx)"

# Created by `pipx` on 2025-10-28 18:47:32
export PATH="$PATH:/home/dromi/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"





export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

alias ani39="source ~/.ani39/bin/activate"


# ---


#export XDG_RUNTIME_DIR="$HOME/.local/run"
#if [ ! -d "$XDG_RUNTIME_DIR" ]; then
#    mkdir -p "$XDG_RUNTIME_DIR"
#    chmod 700 "$XDG_RUNTIME_DIR"
#fi
#XDG_RUNTIME_DIR=/home/dromi/.local/run



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

