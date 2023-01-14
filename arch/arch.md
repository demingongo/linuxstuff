# arch

Info:

- One script is not dependent of another.
- Each script has requirements (see `.md` files).

According to the requirements the order of execution should be:

1. `arch_install_base.sh`
1. `arch_install_linux.sh`
1. `arch_install_grub.sh`
1. `arch_install_utils.sh` (at least after `arch_install_linux.sh`)