# gentoo_install_xorg

##################################################

!!! NO GUARANTEE !!!

Feel free to update the script to fit your needs.

##################################################

### Requirements

- Be connected as "root" in a gentoo environment.

### What it does?

1. Installs xorg
    - `emerge --ask x11-base/xorg-server --verbose`
    - `mkdir -p /etc/X11/xorg.conf.d`
    - ```sh
      echo """Section "InputClass"
          Identifier "keyboard-all"
          Driver "evdev"
          Option "XkbLayout" "<XKBLAYOUT>"
          MatchIsKeyboard "on"
      EndSection
      """ >> /etc/X11/xorg.conf.d/10-keyboard.conf
      ```
2. Installs display manager (sddm)
    - `emerge --ask gui-libs/display-manager-init`
    - `emerge --ask x11-misc/sddm`
    - `mkdir -p /etc/sddm/scripts`
    - `echo "setxkbmap be" >> /etc/sddm/scripts/Xsetup`
    - `chmod a+x /etc/sddm/scripts/Xsetup`
    - `mkdir -p /etc/sddm.conf.d`
    - ```sh
      echo """[X11]
      DisplayCommand=/etc/sddm/scripts/Xsetup
      """ >> /etc/sddm.conf.d/override.conf
      ```
    - `echo 'DISPLAYMANAGER="sddm"' >> /etc/conf.d/display-manager`
    - `rc-update add display-manager default`

3. Installs fonts
    - `emerge --ask media-fonts/noto media-fonts/noto-emoji`
4. Installs sound libs (pulseaudio)
    - `emerge --ask media-sound/pulseaudio`
    - `emerge --ask media-sound/pavucontrol`
    - `emerge --ask media-sound/playerctl`
    - `emerge --ask media-sound/cava`
5. Installs X tools
    - `emerge --ask x11-apps/xset`
    - `emerge --ask x11-misc/numlockx`
    - `emerge --ask x11-apps/xinput`
    - `emerge --ask x11-misc/xdotool`
    - `emerge --ask media-gfx/scrot`
    - `emerge --ask x11-terms/xterm`
6. Bonus: Awesome wm + some tools
