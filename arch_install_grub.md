# Some stuff

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

1. An EFI partition (UEFI x86_64 platform) and an Arch Linux partition that does not have [grub](https://www.gnu.org/software/grub/) installed already.
2. Should be connected as root or "arch-chroot" in the partition where Arch Linux was installed.


### What it does?

1. It installs [grub](https://archlinux.org/packages/core/x86_64/grub/), [efibootmgr](https://archlinux.org/packages/core/x86_64/efibootmgr/), [dosfstools](https://archlinux.org/packages/core/x86_64/dosfstools/), [os-prober](https://archlinux.org/packages/community/x86_64/os-prober/) and [mtools](https://archlinux.org/packages/extra/x86_64/mtools/).
2. It does some basic configuration of grub.
3. IT GIVES YOU INSTRUCTIONS ON WHAT YOU SHOULD DO NEXT. 

After that, reboot or shutdown and boot from the disk where you installed Arch Linux.

### How to use?

Boot your computer from USB containing Arch ISO and enter:
```sh
curl -L https://github.com/demingongo/linuxstuff/releases/download/<tag>/arch_install_grub.sh --output arch_install_grub.sh
bash arch_install_grub.sh
rm arch_install_grub.sh
```
Find available values for \<tag\> here: https://github.com/demingongo/linuxstuff/releases
