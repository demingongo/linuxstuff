#! /usr/bin bash

## Fail if something went wrong
set -euo pipefail

## Init
# DFLT_ESP_PART="/dev/sda1"
DFLT_ROOT_PART="/dev/sda2"

## Select root partition
echo
echo -n "Enter root partition (default: $DFLT_ROOT_PART) #: "
read ROOT_PART
ROOT_PART="${ROOT_PART:-$DFLT_ROOT_PART}"

## Confirm
echo
fdisk -l | grep -E -w "^Device.*Start"
fdisk -l | grep -E -w "^$ROOT_PART"
echo
echo -n "Ok? [y/N] "
read c_answer
if [[ "$c_answer" != "y" ]]; then
    exit
fi

## Format and label root partition
echo
mkfs -t ext4 "$ROOT_PART"
echo -n "$ROOT_PART label #: "
read root_label
e2label "$ROOT_PART" "$root_label"
echo

## Create physical volume
echo
pvcreate --dataalignment 1m $ROOT_PART
echo

## Create volume group
echo
echo -n "Name of volume group #: "
read VOL_GROUP
vgcreate "$VOL_GROUP" "$ROOT_PART"
echo

# Create logical volumes
echo
declare -A VOL_ALLOC_TYPES=(
    [LogicalVolumeSize]=L
    [LogicalExtentsNumber]=l
)
DFLT_LV_ROOT="lv_root"
DFLT_LV_HOME="lv_home"
echo -n "Name of logical volume at "/" (default: $DFLT_LV_ROOT) #: "
read LV_ROOT
LV_ROOT="${LV_ROOT:-$DFLT_LV_ROOT}"
VOL_ALLOC_TYPE="LogicalVolumeSize"
VOL_ALLOC_TYPES_NAMES=($(echo ${!VOL_ALLOC_TYPES[*]} | tr ' ' '\n' | sort -r))
echo "Allocate volume to $LV_ROOT #: "
select l in "${VOL_ALLOC_TYPES_NAMES[@]}"; do
    if [[ -v VOL_ALLOC_TYPES[$l] ]]; then
        VOL_ALLOC_TYPE=$l
        break
    else
        echo 'try again'
    fi
done < /dev/tty
sizeEg='20%VG'
if [[ "$VOL_ALLOC_TYPE" != "LogicalExtentsNumber" ]]; then sizeEg='30GB'; fi
echo -n "Size of logical volume $LV_ROOT (e.g.: $sizeEg) #: "
read LV_ROOT_SIZE
CREATE_LV_ROOT="lvcreate -${VOL_ALLOC_TYPES[$VOL_ALLOC_TYPE]} $LV_ROOT_SIZE $VOL_GROUP -n $LV_ROOT"
echo
echo
echo -n "Name of logical volume at "/home" (default: $DFLT_LV_HOME) #: "
read LV_HOME
LV_HOME="${LV_HOME:-$DFLT_LV_HOME}"
VOL_ALLOC_TYPE="LogicalVolumeSize"
VOL_ALLOC_TYPES_NAMES=($(echo ${!VOL_ALLOC_TYPES[*]} | tr ' ' '\n' | sort -r))
echo "Allocate volume to $LV_HOME #: "
select l in "${VOL_ALLOC_TYPES_NAMES[@]}"; do
    if [[ -v VOL_ALLOC_TYPES[$l] ]]; then
        VOL_ALLOC_TYPE=$l
        break
    else
        echo 'try again'
    fi
done < /dev/tty
sizeEg='100%FREE'
if [[ "$VOL_ALLOC_TYPE" != "LogicalExtentsNumber" ]]; then sizeEg='100GB'; fi
echo -n "Size of logical volume $LV_HOME (e.g.: $sizeEg) #: "
read LV_HOME_SIZE
CREATE_LV_HOME="lvcreate -${VOL_ALLOC_TYPES[$VOL_ALLOC_TYPE]} $LV_HOME_SIZE $VOL_GROUP -n $LV_HOME"
echo
echo
echo "$CREATE_LV_ROOT"
eval "$CREATE_LV_ROOT"
echo "$CREATE_LV_HOME"
eval "$CREATE_LV_HOME"
echo

## Scan volume groups, 
## Format logical volumes and mount them
echo
modprobe dm_mod
vgscan
vgchange -ay
mkfs.ext4 "/dev/$VOL_GROUP/$LV_ROOT"
mkdir -p /mnt/gentoo
mount "/dev/$VOL_GROUP/$LV_ROOT" /mnt/gentoo
mkfs.ext4 "/dev/$VOL_GROUP/$LV_HOME"
mkdir /mnt/gentoo/home
mount "/dev/$VOL_GROUP/$LV_HOME" /mnt/gentoo/home
echo
mount -l
echo
