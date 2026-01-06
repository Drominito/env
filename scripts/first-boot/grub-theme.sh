#!/bin/bash

pushd /boot/grub/themes
git clone https://github.com/krypciak/crossgrub
sudo bash ./install.sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
popd
