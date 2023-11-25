#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

# Init
DFLT_HOSTNAME="gentooman"

## Set hostname
echo
echo -n "Enter hostname (default: $DFLT_HOSTNAME) #: "
read HOSTNAME
HOSTNAME="${HOSTNAME:-$DFLT_HOSTNAME}"
echo "$HOSTNAME" > /etc/hostname
echo

# Useful adminstration scripts
echo
emerge --noreplace app-portage/gentoolkit
echo

## Configure network
echo
echo "Select your network management #: "
echo
echo "1) networkmanager + iwd"
echo "2) dhcpcd + wpa_supplicant"
echo -n "(default: 1) # "
read NETWORK_MANAGEMENT
echo
if [ "${NETWORK_MANAGEMENT}" = "2" ]; then
    emerge --ask net-misc/dhcpcd
    echo
    rc-update add dhcpcd default
    echo
    emerge --ask net-wireless/iw net-wireless/wpa_supplicant
else
    # Add "networkmanager" in global USE of /etc/portage/make.conf
    euse -E networkmanager
    # Update
    emerge --changed-use --deep @world
    # Add local flags or networkmanager
    echo """
net-misc/networkmanager iwd
""" >> /etc/portage/package.use/02network-flags
    # Install packages
    emerge --ask --newuse net-misc/networkmanager net-wireless/iwd net-wireless/iw
    echo
    # Configure
    echo """
[device]
wifi.backend=iwd
wifi.iwd.autoconnect=yes
""" > /etc/NetworkManager/conf.d/iwd.conf
    echo
    rc-update add iwd default
    echo
    rc-update add NetworkManager default
fi

## Set the root password + new user
echo
echo "ROOT SETUP:"
passwd
echo
echo -n "NEW USER! Enter username : "
read NEW_USERNAME
useradd -m -G users,audio,wheel "$NEW_USERNAME"
passwd "$NEW_USERNAME"
echo
### Do not exit if this one fails
set +e
# necessary permission for networkmanager and other tools
gpasswd -a "$NEW_USERNAME" plugdev
### Reset exit if one fails
set -e
echo

## System logger
echo
emerge --ask app-admin/sysklogd
echo
rc-update add sysklogd default
echo

## Cron daemon
echo
emerge --ask sys-process/cronie
echo
rc-update add cronie default
echo

## File indexing
echo
emerge --ask sys-apps/mlocate
echo

## Remote shell access
echo
rc-update add sshd default
echo

## Shell completion
echo
emerge --ask app-shells/bash-completion
echo

## Time synchronization
echo
emerge --ask net-misc/chrony
echo
rc-update add chronyd default
echo

## Filesystem tools
echo
emerge --ask sys-fs/dosfstools sys-fs/xfsprogs sys-fs/ntfs3g
echo
emerge sys-block/io-scheduler-udev-rules
echo

# elogind
echo
emerge --ask sys-auth/elogind
echo
rc-update add elogind boot
echo

# dbus
echo
emerge --ask sys-apps/dbus
echo
rc-update add dbus default
echo

# udisks
echo
emerge --ask sys-fs/udisks
echo

# rebuild some dependencies if needed
echo
emerge --changed-use --deep @world
echo

## What now ?
echo
echo -e "\033[0;32mGREAT ...\033[0m"
echo -e "\033[0;33mI HOPE YOU DIDN'T FORGET TO CONFIGURE :\033[0m"
echo
echo "   1. /etc/conf.d/keymaps"
echo
echo "   2. /etc/conf.d/hwclock"
echo