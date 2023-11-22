# gentoo_install_utils

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

- Be connected as "root" in a gentoo environment.

### What it does?

1. Installs Advanced Configuration and Power management Interface
    - `emerge --ask sys-power/acpid sys-power/acpi`
    - `rc-update add acpid default`
2. Installs bluetooth support (bluez)
    - `emerge --ask --noreplace net-wireless/bluez`
    - `rc-update add bluetooth default`
3. Installs git
    - `emerge --ask dev-vcs/git`
4. Installs golang
    - `emerge --ask dev-lang/go`
5. Sets up firewall (ufw)
    - `emerge --ask ufw`
    - `rc-update add ufw default`
    - `rc-service ufw start`
    - `ufw default deny`
    - `ufw allow ssh`
    - `ufw allow from 192.168.0.0/24`
    - `ufw enable`
    - `ufw reload`
6. Installs others
    - `emerge --ask app-misc/neofetch`
