# Some stuff

##################################################

NO GUARANTEE!

Feel free to update the script to fit your needs.

##################################################

### Requirements

1. SHould be "arch-chroot"ed in the disk where [base](https://archlinux.org/packages/core/any/base/) was installed.

### What it does?

1. It installs kernels and headers: linux, linux-lts, linux-headers, linux-lts-headers.
2. It installs and configures some packages.
3. Setup root password and add a new user. 

After that, you do whatever you want!

### How to use?

"arch-chroot"ed with only [base](https://archlinux.org/packages/core/any/base/) installed, download the script and execute it:
```sh
curl -L https://github.com/demingongo/linuxstuff/releases/download/<tag>/arch_install_linux.sh --output arch_install_linux.sh
bash arch_install_linux.sh
```
Find available values for \<tag\> here: https://github.com/demingongo/linuxstuff/releases
