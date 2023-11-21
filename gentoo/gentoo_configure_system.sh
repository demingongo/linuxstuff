#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

## Installing firmware
echo
emerge --ask sys-kernel/linux-firmware
echo

## Distribution kernel
echo
emerge --ask sys-kernel/installkernel-gentoo
emerge --ask sys-kernel/gentoo-kernel
eselect kernel list
echo
ls -l /usr/src/linux
KERNEL_VERSION=`aws -F'-> linux-' '{print $2}' <<< $(ls -l /usr/src/linux)`
echo "$KERNEL_VERSION"
echo

## Rebuild the initramfs for lvm support
echo
emerge --ask sys-apps/pciutils sys-kernel/dracut sys-fs/lvm2
rc-update add lvm boot
echo
dracut --kver=$KERNEL_VERSION -a lvm --force
echo
ls /boot/initramfs*
echo

## What now ?
echo
echo -e "\033[0;32mGREAT ...\033[0m"
echo -e "\033[0;33mIF EVERYTHING HAPPENED CORRECTLY ===> FOLLOW THE INSTRUCTIONS :\033[0m"
echo
echo "   1. Go back to the installation media:"
echo "      exit"
echo
echo "   2. Generate fstab:"
echo "      genfstab -U -p /mnt/gentoo >> /mnt/gentoo/etc/fstab"
echo
echo "   3. Arch-chroot back to the new installation:"
echo "      arch-chroot /mnt/gentoo"
echo