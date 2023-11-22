#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

## Init
DFLT_XKBLAYOUT="be"

echo
echo -n "Enter keyboard layout for X (XkbLayout) (default: $DFLT_XKBLAYOUT) #: "
read XKBLAYOUT
XKBLAYOUT="${XKBLAYOUT:-$DFLT_XKBLAYOUT}"
echo

## xorg server
echo
emerge --ask x11-base/xorg-server --verbose
echo
mkdir -p /etc/X11/xorg.conf.d
echo
echo """Section \"InputClass\"
    Identifier \"keyboard-all\"
    Driver \"evdev\"
    Option \"XkbLayout\" \"${XKBLAYOUT}\"
    MatchIsKeyboard \"on\"
EndSection
""" >> /etc/X11/xorg.conf.d/10-keyboard.conf
echo
emerge x11-apps/setxkbmap
echo

## display manager (with sddm)
echo
emerge --ask gui-libs/display-manager-init
echo
emerge --ask x11-misc/sddm
echo
mkdir -p /etc/sddm/scripts
echo "setxkbmap be" >> /etc/sddm/scripts/Xsetup
chmod a+x /etc/sddm/scripts/Xsetup
mkdir -p /etc/sddm.conf.d
echo """[X11]
DisplayCommand=/etc/sddm/scripts/Xsetup
""" >> /etc/sddm.conf.d/override.conf
echo
sed -i '/^DISPLAYMANAGER=/d' /etc/conf.d/display-manager
echo 'DISPLAYMANAGER="sddm"' | tee -a /etc/conf.d/display-manager
echo
rc-update add display-manager default
echo

## fonts
echo
emerge --ask media-fonts/noto media-fonts/noto-emoji
echo

## sound
echo
emerge --ask media-sound/pulseaudio
echo
emerge --ask media-sound/pavucontrol
echo
emerge --ask media-sound/playerctl
echo
emerge --ask media-sound/cava
echo

## X tools
echo
emerge --ask x11-apps/xset x11-misc/numlockx x11-apps/xinput x11-misc/xdotool media-gfx/scrot
echo
emerge --ask x11-terms/xterm
echo

## Bonus: Awesome wm + some tools
echo
echo -e "\033[0;32mXORG WAS SET UP!\033[0m"
echo
echo -n "Do you want to install awesome wm? [y/N] "
read c_answer
if [[ "$c_answer" != "y" ]]; then
    exit
fi

echo
emerge --ask x11-wm/awesome media-gfx/feh x11-misc/i3lock x11-terms/kitty
echo
emerge --ask --noreplace net-wireless/blueman
echo
emerge --ask lxde-base/lxappearance
echo
emerge --ask media-gfx/gimp media-gfx/imagemagick
echo

if ! command -v go &> /dev/null
then
    # echo "go not found"
    echo
else
    go install github.com/charmbracelet/glow@latest
    go install github.com/charmbracelet/gum@latest
    break
fi