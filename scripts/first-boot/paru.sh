#!/bin/bash

p="$HOME/repo/"
mkdir -p $p
pushd $p

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
popd
