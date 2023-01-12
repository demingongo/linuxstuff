#! /usr/bin bash

# Fail if something went wrong
set -euo pipefail

# Init
DFLT_ESP_PART="/dev/sda1"
DFLT_ROOT_PART="/dev/sda2"

# Authorize sudo
sudo echo

# Select boot partition
echo -n "Enter boot (esp) partition (e.g.: $DFLT_ESP_PART) #: "
read ESP_PART
ESP_PART="${ESP_PART:-$DFLT_ESP_PART}"
fdisk -l | grep -E -w "^Device.*Start"
fdisk -l | grep -E -w "^$ESP_PART"

# Select root partition
echo -n "Enter root partition (e.g.: $DFLT_ROOT_PART) #: "
read ROOT_PART
ROOT_PART="${ROOT_PART:-$DFLT_ROOT_PART}"
fdisk -l | grep -E -w "^Device.*Start"
fdisk -l | grep -E -w "^$ROOT_PART"

# Confirm
echo
echo "Confirmation:"
fdisk -l | grep -E -w "^Device.*Start"
fdisk -l | grep -E -w "^$ESP_PART"
fdisk -l | grep -E -w "^$ROOT_PART"
echo -n "Ok? [y/N] #: "
read c_answer
if [[ "$c_answer" != "y" ]]; then
    exit
fi

# Format and label root partition
mkfs -t ext4 "$ROOT_PART"
echo -n "Label ext4 root file system #: "
read root_label
e2label "$ROOT_PART" "$root_label"

# Create physical volume
pvcreate --dataalignment 1m $ROOT_PART

# Create volume group
echo -n "Name of volume group #: "
read VOL_GROUP
vgcreate "$VOL_GROUP" "$ROOT_PART"

# Create logical volumes
DFLT_LV_ROOT="lv_root"
DFLT_LV_HOME="lv_home"
VOL_ALLOC_TYPE="LogicalVolumeSize"
declare -A VOL_ALLOC_TYPES=(
    [LogicalVolumeSize]=L
    [LogicalExtentsNumber]=l
)
VOL_ALLOC_TYPES_NAMES=($(echo ${!VOL_ALLOC_TYPES[*]} | tr ' ' '\n' | sort -r))
echo 'Please select how you want to allocate volume #: '
select l in "${VOL_ALLOC_TYPES_NAMES[@]}"; do
    if [[ -v VOL_ALLOC_TYPES[$l] ]]; then
        VOL_ALLOC_TYPE=$l
        break
    else
        echo 'try again'
    fi
done < /dev/tty
echo -n "Name of logical volume at "/" (default: $DFLT_LV_ROOT) #: "
read LV_ROOT
LV_ROOT="${LV_ROOT:-$DFLT_LV_ROOT}"
echo -n "Size of logical volume $LV_ROOT (e.g.: 25GB) #: "
read LV_ROOT_SIZE
CREATE_LV_ROOT="lvcreate -${VOL_ALLOC_TYPES[$VOL_ALLOC_TYPE]} $LV_ROOT_SIZE $VOL_GROUP -n $LV_ROOT"

echo -n "Name of logical volume at "/home" (default: $DFLT_LV_HOME) #: "
read LV_HOME
LV_HOME="${LV_HOME:-$DFLT_LV_HOME}"
echo -n "Size of logical volume $LV_ROOT (e.g.: 25GB) #: "
read LV_HOME_SIZE
CREATE_LV_HOME="lvcreate -${VOL_ALLOC_TYPES[$VOL_ALLOC_TYPE]} $LV_HOME_SIZE $VOL_GROUP -n $LV_HOME"

echo "$CREATE_LV_ROOT"
echo "$CREATE_LV_HOME"

# eval sudo "$CREATE_LV_ROOT"
# eval sudo "$CREATE_LV_HOME"