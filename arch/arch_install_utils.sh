#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

# Install firewall
echo -e "\033[0;32sudo pacman -S ufw\033[0m"
sudo pacman -S ufw
echo
sudo systemctl enable ufw.service
echo
sudo ufw enable
echo

# Install some fonts
echo -e "\033[0;32sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-opensans\033[0m"
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-opensans
echo

# Install browser
echo -e "\033[0;32sudo pacman -S firefox\033[0m"
sudo pacman -S firefox
echo

# Install neofetch
echo -e "\033[0;32sudo pacman -S neofetch\033[0m"
sudo pacman -S neofetch

