# Some stuff

##################################################

NO GUARANTEE!

Feel free to update the script to fit your needs.

##################################################

### Requirements

1. Disk where you want to install should be partitioned beforehand for a UEFI installation

### What it does?

1. It creates logical volumes for "/" and "/home" in a file system.
2. It installs the package [base](https://archlinux.org/packages/core/any/base/).
3. It "arch-chroot" you to the disk where it installed [base](https://archlinux.org/packages/core/any/base/). 

After that, you do whatever you want!

### How to use?

Boot your computer from USB containing Arch ISO and enter:
```sh
curl -L https://github.com/demingongo/linuxstuff/releases/download/<tag>/arch_install_base.sh --output arch_install_base.sh
bash arch_install_base.sh
```
Find available values for \<tag\> here: https://github.com/demingongo/linuxstuff/releases

### Errors

#### is apparently in use by the system will not make a filesystem here

You might have to unmount the file system if it was mounted: 
```sh
# unmount one specific file system
umount /dev/sxyn

# or unmount all of the file systems described in /etc/mtab
umount -a
```
If the file system has logical volumes and volume groups, you have to remove them:
```sh
# display information about volume groups
vgs
# remove logical volumes from a volume group
lvremove volume_group_name
# deactivate the group, it should display that there are 0 logical volumes
vgchange -a n volume_group_name
# remove volume group
vgremove volume_group_name
```
