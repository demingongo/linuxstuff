# gentoo_install_base

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

Should be "arch-chroot"ed in the disk where

1. [the stage tarball was downloaded](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Stage#Downloading_the_stage_tarball).
2. [the gentoo mirrors where selected](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Optional:_Selecting_mirrors).
3. [Gentoo ebuild repository was configured](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Gentoo_ebuild_repository).
4. [DNS info was copied](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Copy_DNS_info).

### What it does?

1. emerge-webrsync, emerge --sync
2. emerge --ask --verbose --update --deep --newuse @world
3. emerge --ask app-portage/cpuid2cpuflags, cpuid2cpuflags, echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
4. ACCEPT_LICENSE="-* @FREE @BINARY-REDISTRIBUTABLE" >> /etc/portage/make.conf
5. echo "Europe/Brussels" > /etc/timezone, emerge --config sys-libs/timezone-data
6. echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen, locale-gen, eselect locale list, eselect local set <number>
7. env-update && source /etc/profile
