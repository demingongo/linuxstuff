# arch_install_grub

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

1. An EFI partition (UEFI x86_64 platform) and an Gentoo partition that does not have [grub](https://www.gnu.org/software/grub/) installed already.
2. Should be connected as root or "arch-chroot" in the partition where Gentoo was installed.


### What it does?

1. Mount partition to /efi
2. echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf, emerge --ask sys-boot/grub, emerge --ask sys-boot/os-prober,
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub, echo 'GRUB_CMDLINE_LINUX="rd.lvm.vg=<volumeGroup>"' >> /etc/default/grub
3. grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=<gentooman>
4. grub-mkconfig -o /boot/grub/grub.cfg 

### How to use?

Boot your computer from USB containing Arch ISO and enter:
```sh
curl -L https://github.com/demingongo/linuxstuff/releases/download/<tag>/arch_install_grub.sh --output arch_install_grub.sh
bash arch_install_grub.sh
rm arch_install_grub.sh
```
(Find available values for \<tag\> here: https://github.com/demingongo/linuxstuff/releases)

After that, reboot or shutdown and boot from where Arch Linux boots.