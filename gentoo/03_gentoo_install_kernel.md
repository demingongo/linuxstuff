# gentoo_install_kernel

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

Should be "arch-chroot"ed in the disk and have installed the [Gentoo base system](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base).

### What it does?

Install kernel

1. `emerge --ask sys-kernel/linux-firmware`
2. 
    - `emerge --ask sys-kernel/installkernel-gentoo` 
    - `emerge --ask sys-kernel/gentoo-kernel`
3. `eselect kernel list, eselect kernel set <number>`
4.  
    - `emerge --ask sys-apps/pciutils sys-kernel/dracut sys-fs/lvm2`
    - `rc-update add lvm boot`
5. 
    - `dracut --kver=<version>-gentoo-dist -a lvm --force`
    - `ls /boot/initramfs*`

### After that

```sh
exit
```
```sh
genfstab -U -p /mnt/gentoo >> /mnt/gentoo/etc/fstab
arch-chroot /mnt/gentoo
```
