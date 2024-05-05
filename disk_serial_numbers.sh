#!/bin/env bash

set -e

sudo apt install smartmontools btrfs-progs

file_name=disk_serial_numbers.txt


disks=$( sudo lshw -class disk | grep 'logical name' | grep '/dev' | grep -v nvme | grep -v ng | cut -d':' -f2 | cut -d ' ' -f2 )

for disk in ${disks[@]}; do
    if [[ -n "$(lsblk -nd -o PTTYPE "$disk" 2>/dev/null)" ]]; then
        echo "WARN: Skipping disk '$disk' because it has partitions on it .."
    else
        #    serial_number=$(udevadm info --query=all --name=$disk | grep ID_SERIAL_SHORT | cut -d'=' -f2)
        serial_number=$(sudo smartctl -i $disk | grep -i 'Serial number' | cut -d':' -f 2 | tr -d ' ')
        echo "  disk: $disk | serial_number: $serial_number"
        mkdir -p /mnt/chia/$serial_number
        chmod 777 -R /mnt/chia/$serial_number
        chown ubuntu:ubuntu -R /mnt/chia/$serial_number
        read -ra values <<< "$(sudo blkid -p $disk)"
        for value in "${values[@]}"; do
            echo $value
            if [[ $value == TYPE* ]]; then
                type=$(echo $value | cut -d'=' -f2)
                fs_type=$(echo $type | tr -d '"')
                echo "fs_type: $fs_type"
                if [[ "$fs_type" != "btrfs" ]]; then
                    echo "ERR: disk '$disk' with serial number '$serial_number' has FS type '$fs_type'!"
                    exit 1
                fi
            fi
        done
        sudo btrfs filesystem label $disk $serial_number || true
    fi
done

for disk in ${disks[@]}; do\
    partitions=$(ls -la ${disk}* | wc -l)
    if [[ -z "$(lsblk -nd -o PTTYPE "$disk" 2>/dev/null)" ]]; then
        serial_number=$(sudo smartctl -i $disk | grep -i 'Serial number' | cut -d':' -f 2 | tr -d ' ')
        echo -e "LABEL=$serial_number\t/mnt/chia/$serial_number\t\tbtrfs\tdefaults,compress=none,nofail\t0\t0" >> /etc/fstab
        mount /mnt/chia/$serial_number || true
        chown ubuntu:ubuntu -R /mnt/chia/$serial_number
        chmod 777 -R /mnt/chia/$serial_number
    fi
done
