#!/bin/env bash

set -e

if [ $# -ne 2 ]; then
    echo "FATAL - exactly 2 parameters required: number_of_drives & ramdisk_size !"
    exit 1
fi

number_of_drives=$1
ramdisk_size=$2

umount /mnt/ramdisk* || true
rmmod brd || true

modprobe brd rd_nr=$number_of_drives rd_size=$((ramdisk_size * 1048576))

for i in $(seq 1 $number_of_drives); do
    j=$((i-1))
    mkfs.btrfs /dev/ram$j
#    mkfs.xfs /dev/ram$j
    mkdir -p /mnt/ramdisk$j
    mount /dev/ram$j /mnt/ramdisk$j
#    mount -o sync /dev/ram$j /mnt/ramdisk$j
done

chmod 777 -R /mnt/ramdisk*
chown ubuntu:ubuntu -R /mnt/ramdisk*
