#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

echo
echo -e "\033[0;33m!!! PLEASE SELECT OPTION 'mkinitcpio' WHEN ASKED !!!\033[0m"
echo

# Install kernels and headers (please select mkinitcpio option)
pacman -S linux linux-headers linux-lts linux-lts-headers

# Some usefull tools
pacman -S base-devel lvm2 openssh \
networkmanager wpa_supplicant wireless_tools netctl dialog \
git \
vim nano \
htop

# Enable some tools at startup
systemctl enable sshd
systemctl enable NetworkManager

# Change line HOOKS=(...) to add "lvm2" between "block" and "filesystems" in /etc/mkinitcpio.conf
sed -i -e '/^HOOKS=(.*block filesystems.*)/s/block filesystems/block lvm2 filesystems/' /etc/mkinitcpio.conf

# Exec changes
mkinitcpio -p linux
mkinitcpio -p linux-lts

# Uncomment and generate some locales
sed -i -E -e '/^(#en_US.UTF-8|#fr_BE.UTF-8)/s/^#//' /etc/locale.gen
locale-gen

# Users setup
echo
echo "ROOT SETUP:"
passwd
echo
echo -n "NEW USER! Enter username : "
read NEW_USERNAME
useradd -m -g users -G wheel "$NEW_USERNAME"
passwd "$NEW_USERNAME"
cp /etc/sudoers /tmp/sudoers_tmp
sed -i -e '/^# %wheel ALL=(ALL:ALL) ALL/s/^# //' /tmp/sudoers_tmp
visudo -c -f /tmp/sudoers_tmp
EDITOR="cp /tmp/sudoers_tmp" visudo
rm -f /tmp/sudoers_tmp
