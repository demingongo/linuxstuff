#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

## Init
DFLT_TIMEZONE="Europe/Brussels"
DFLT_VIDEO_CARDS=""

echo
echo -n "Enter VIDEO_CARDS (default: $DFLT_VIDEO_CARDS) #: "
read VIDEO_CARDS
VIDEO_CARDS="${VIDEO_CARDS:-$DFLT_VIDEO_CARDS}"
echo
echo -n "Enter timezone (default: $DFLT_TIMEZONE) #: "
read TIMEZONE
TIMEZONE="${TIMEZONE:-$DFLT_TIMEZONE}"

## Installing / Updating the Gentoo ebuild repository
emerge-webrsync
emerge --sync

## Updates the @world set
cat ./assets/make.conf | tee -a /etc/portage/make.conf
cp ./assets/package.use/* /etc/portage/package.use/
if [[ ! -z "$VIDEO_CARDS" ]]; then
    echo "VIDEO_CARDS=\"$VIDEO_CARDS\"" | tee -a /etc/portage/make.conf
fi
emerge --ask --verbose --update --deep --newuse @world

## CPU_FLAGS_*
emerge --ask app-portage/cpuid2cpuflags
cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags

# Timezone setup
echo "$TIMEZONE" > /etc/timezone
emerge --config sys-libs/timezone-data

## Configure locales
echo
sed -i -E -e '/^(#en_US.UTF-8)/s/^#//' /etc/locale.gen
locale-gen
eselect locale list
echo
echo -n "Select locale #: "
read LOCALE
if [[ ! -z "$LOCALE" ]]; then
    eselect locale set "$LOCALE"
fi

env-update && source /etc/profile