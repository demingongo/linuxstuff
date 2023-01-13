#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

# Install kernels and headers (please select mkinitcpio option)
sudo pacman -S linux linux-headers linux-lts linux-lts-headers

# Some other usefull stuff
sudo pacman -S base-devel lvm2 openssh \
networkmanager wpa_supplicant wireless_tools netctl dialog \
git \
vim nano \

# Enable some stuff at startup
sudo systemctl enable sshd
sudo systemctl enable NetworkManager

# Change line HOOKS=(...) to add "lvm2" between "block" and "filesystems" in /etc/mkinitcpio.conf
sudo sed -i -e '/^HOOKS=(.*block filesystems.*)/s/block filesystems/block lvm2 filesystems/' /etc/mkinitcpio.conf

# Exec changes
sudo mkinitcpio -p linux
sudo mkinitcpio -p linux-lts

# Uncomment and generate some locales
sudo sed -i -e '/^#[en_us_utf8|#fr_utf8]/s/^#//' /etc/locale.gen
sudo locale-gen

# Users setup
echo
echo "Root setup:"
sudo passwd
echo
echo -n "New user! Enter username : "
read NEW_USERNAME
sudo useradd -m -g users -G wheel "$NEW_USERNAME"
sudo passwd "$NEW_USERNAME"
sudo cp /etc/sudoers /tmp/sudoers_tmp
sudo sed -e '/^#%wheel ALL=(ALL)/s/^#//' /tmp/sudoers_tmp
sudo visudo -c -f /tmp/sudoers_tmp
sudo EDITOR="cp /tmp/sudoers_tmp" visudo
