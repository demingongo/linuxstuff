#! /usr/bin bash

## Advanced Configuration and Power management Interface
echo
emerge --ask sys-power/acpid sys-power/acpi
echo
rc-update add acpid default
echo

## bluetooth support
echo
emerge --ask --noreplace net-wireless/bluez
echo
rc-update add bluetooth default
echo

## dev
echo
emerge --ask dev-vcs/git
echo
emerge --ask dev-lang/go
echo

## firewall
echo
emerge --ask ufw
echo
rc-update add ufw default
echo
rc-service ufw start
echo
ufw default deny
echo
ufw allow ssh
echo
ufw allow from 192.168.0.0/24
echo
ufw enable
echo
ufw reload
echo

# others
echo
emerge --ask sys-process/htop app-misc/neofetch
echo
