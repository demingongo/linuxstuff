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

1. Installs and updates the Gentoo ebuild repository.
2. Updates the @world set
3. CPU_FLAGS_*
4. Sets up VIDEO_CARDS
5. Sets up timezone
6. Configures locales
