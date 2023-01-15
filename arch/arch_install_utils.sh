#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

# Timezone setup
echo
echo -n "Enter timezone (optional if you don't want to set it up) (e.g.: Atlantic/Cape_Verde) #: "
read TZ
if [[ ! -z "$TZ" ]]; then
    sudo timedatectl set-timezone "$TZ"
    sudo systemctl enable systemd-timesyncd
fi

# Hostname setup
echo
echo -n "Enter hostname (optional if you don't want to set it up) #: "
read HOSTNAME_USER
if [[ ! -z "$HOSTNAME_USER" ]]; then
    sudo hostnamectl set-hostname "$HOSTNAME_USER"
    echo
    echo "127.0.0.1 localhost" | tee -a /etc/hosts
    echo "::1       localhost" | tee -a /etc/hosts
    echo "127.0.1.1 $HOSTNAME_USER" | tee -a /etc/hosts
    echo
    echo
    sudo hostnamectl
fi

# Install firewall
echo -e "\033[0;32msudo pacman -S ufw\033[0m"
sudo pacman -S ufw
echo
sudo systemctl enable ufw.service
echo
sudo ufw enable
echo

# Install some fonts
echo -e "\033[0;32msudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-opensans\033[0m"
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation ttf-opensans
echo

# Install browser
echo -e "\033[0;32msudo pacman -S firefox\033[0m"
sudo pacman -S firefox
echo

# Install neofetch
echo -e "\033[0;32msudo pacman -S neofetch\033[0m"
sudo pacman -S neofetch

