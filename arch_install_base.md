# Some stuff

### Requirements

1. Disk should be partitioned beforehand for a UEFI installation

### What it does?

1. It creates logical volumes for "/" and "/home".
2. It installs the package [base](https://archlinux.org/packages/core/any/base/).
3. It "arch-chroot" you to the installation. 

### Disk should be partitioned beforehand

### Errors

#### is apparently in use by the system will not make a filesystem here

You might have to unmount the device if it was mounted: 
```sh
umount /dev/sxyn
```

Or maybe the device has logical volumes and group volumes. You have to remove them first:
```sh
# remove logical volumes from a volume group
lvremove volume_group_name
# deactivate the group, it should display that there are 0 logical volumes
vgchange -a n volume_group_name
# remove volume group
vgremove volume_group_name
```
