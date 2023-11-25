# gentoo_configure_system

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

- Should be "arch-chroot"ed in the disk and have installed the [kernel](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Kernel).
- Should have configured `/etc/conf.d/keymaps`
- Should have configured `/etc/conf.d/hwclock`

### What it does?

1. Sets up hostname
2. Configures networking tools (NetworkManager or dhcpcd)
3. Sets the root password
4. Sets up new user
5. Sets up system logger (sysklogd)
6. Sets up a cron daemon (cronie)
9. Sets up file indexing (mlocate)
10. Sets up remote shell access (sshd)
11. Installs bash completion
12. Sets up time synchronization (chrony)
13. Sets up filesystem tools (vfat, xfs, ntfs)
14. and more ...
