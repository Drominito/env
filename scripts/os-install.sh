#!/bin/bash

localectl set-keymap de
timedatectl set-ntp true


/mnt $1
#password


pacman -Syyy
pacman -S reflector

reflector -C Germany -a 6 --sort rate --save /etc/mirrorlist
pacman -Syyy

fdisk $2
