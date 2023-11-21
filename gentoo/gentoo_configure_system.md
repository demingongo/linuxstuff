# gentoo_configure_system

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

Should be "arch-chroot"ed in the disk and have installed the [kernel](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Kernel).

### What it does?

Configuring system

1. echo <hostname> > /etc/hostname, echo "127.0.0.1    <hostname> localhost" >> /etc/hosts
2. emerge --ask net-misc/dhcpcd, rc-update add dhcpcd default, emerge --ask net-wireless/iw net-wireless/wpa_supplicant
3. passwd
4. echo "127.0.0.1    <hostname> localhost" >> /etc/hosts
5. echo "keymap=\"be-latin1\"" >> /etc/conf.d/keymaps
6. echo "clock=\"<local | UTC>\"" >> /etc/conf.d/hwclock
7. emerge --ask app-admin/sysklogd, rc-update add sysklogd default
8. emerge --ask sys-process/cronie, rc-update add cronie default
9. emerge --ask sys-apps/mlocate
10. rc-update add sshd default
11. emerge --ask app-shells/bash-completion
12. emerge --ask net-misc/chrony, rc-update add chronyd default
13. emerge --ask sys-fs/dosfstool sys-fs/xfsprog sys-fs/ntfs3g
14. emerge --ask sys-block/io-scheduler-udev-rules
