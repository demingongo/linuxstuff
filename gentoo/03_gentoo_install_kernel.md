# gentoo_install_kernel

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

Should be "arch-chroot"ed in the disk and have installed the [Gentoo base system](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base).

### What it does?

1. Installs firmware
2. Installs a distribution kernel
3. Rebuilds the initramfs for lvm support
4. Gives instructions

### After that

```sh
exit
```
```sh
genfstab -U -p /mnt/gentoo >> /mnt/gentoo/etc/fstab
arch-chroot /mnt/gentoo
```
