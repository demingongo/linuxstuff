#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

## Select esp partition
DFLT_ESP_PART="/dev/sda1"
echo
echo -n "Enter EFI partition (default: $DFLT_ESP_PART) #: "
read ESP_PART
ESP_PART="${ESP_PART:-$DFLT_ESP_PART}"

## Confirm
echo
fdisk -l | grep -E -w "^Device.*Start"
fdisk -l | grep -E -w "^$ESP_PART"
echo
echo -n "Ok? [y/N] "
read c_answer
if [[ "$c_answer" != "y" ]]; then
    exit
fi

## Install grub and stuff
mkdir -p /efi
mount "${ESP_PART}" /efi
echo
echo -n 'Add GRUB_PLATFORMS="efi-64" to "/etc/portage/make.conf" ? [Y/n] '
read c_answer
if [[ "$c_answer" != "n" ]]; then
    sed -i '/^GRUB_PLATFORMS=/d' /etc/portage/make.conf
    echo 'GRUB_PLATFORMS="efi-64"' | tee -a /etc/portage/make.conf
fi
emerge --ask --update --newuse sys-boot/os-prober sys-boot/grub
DFLT_BOOTLOADER_ID='gentooman'
echo
echo -n "Enter bootloader id (default: $DFLT_BOOTLOADER_ID) #: "
read BOOTLOADER_ID
BOOTLOADER_ID="${BOOTLOADER_ID:-$DFLT_BOOTLOADER_ID}"
echo
echo -n "Enter the name of volume group where is root (leave it empty if you don't use lvm) #: "
read VOLUME_GROUP
echo
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id="$BOOTLOADER_ID"
sed -i '/^GRUB_DISABLE_OS_PROBER=/d' /etc/default/grub
echo "GRUB_DISABLE_OS_PROBER=false" | tee -a /etc/default/grub

if [ ! -z "$VOLUME_GROUP" ]; then
    sed -i '/^GRUB_CMDLINE_LINUX=/d' /etc/default/grub
    echo "GRUB_CMDLINE_LINUX=\"rd.lvm.vg=${VOLUME_GROUP}\"" | tee -a /etc/default/grub
fi


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
