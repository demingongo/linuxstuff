#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

# Install firewall
sudo pacman -S ufw
sudo systemctl enable ufw.service
sudo ufw enable

# Install some fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-opensans

# Install browser
sudo pacman -S firefox

# Install neofetch
sudo pacman -S neofetch

