# gentoo

Info:

- Each script has requirements (see `.md` files).
- No script to install cpu drivers, gpu drivers and gui. You should do that on your own.

According to the requirements, the order of execution should be:

1. `gentoo_create_lv.sh`
1. `gentoo_install_base.sh`
1. `gentoo_install_kernel.sh`
1. `gentoo_configure_system.sh`
1. `gentoo_install_grub.sh`