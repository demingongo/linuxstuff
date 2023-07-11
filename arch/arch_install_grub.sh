#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Authorize sudo
sudo echo

## Select esp partition
DFLT_ESP_PART="/dev/sda1"
echo
echo -n "Enter EFI partition (default: $DFLT_ESP_PART) #: "
read ESP_PART
ESP_PART="${ESP_PART:-$DFLT_ESP_PART}"

## Confirm
echo
sudo fdisk -l | grep -E -w "^Device.*Start"
sudo fdisk -l | grep -E -w "^$ESP_PART"
echo
echo -n "Ok? [y/N] "
read c_answer
if [[ "$c_answer" != "y" ]]; then
    exit
fi

## Install grub and stuff
sudo pacman -S grub efibootmgr dosfstools os-prober mtools
sudo mkdir -p /efi
sudo mount ${ESP_PART} /efi
DFLT_BOOTLOADER_ID='arch_linux'
echo
echo -n "Enter bootloader id (default: $DFLT_BOOTLOADER_ID) #: "
read BOOTLOADER_ID
BOOTLOADER_ID="${BOOTLOADER_ID:-$DFLT_BOOTLOADER_ID}"
sudo grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id="$BOOTLOADER_ID"
sudo mkdir -p /boot/grub/locale
sudo cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
sudo sed -i '/^GRUB_DISABLE_OS_PROBER=/d' /etc/default/grub
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub


## Now you finish it on your own
echo
echo -e "\033[0;32mGREAT ...\033[0m"
echo -e "\033[0;33mBUT YOU STILL HAVE SOMETHING TO DO! ===> FOLLOW THE INSTRUCTIONS :\033[0m"
echo
echo "   1. Mount the partitions from which the other systems boot."
echo "      This is optional. The exact mount point does not matter."
echo "      (e.g.: mkdir /mnt/fedora && mount /mnt/sxyz /mnt/fedora)"
echo
echo "   2. Run grub-mkconfig :"
echo "      grub-mkconfig -o /boot/grub/grub.cfg"
echo
echo "   3. Unmount what you mounted from instruction 1."
echo
