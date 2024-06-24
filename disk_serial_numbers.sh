#!/bin/env bash

set -e

sudo apt install smartmontools btrfs-progs jq

user=$USER
for row in $(sudo lshw -class disk -json | jq -r '.[] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }
    disk=$(_jq '.logicalname')
    serial=$(_jq '.serial')
    mounted=$(_jq '.configuration.state')
    if [[ "$mounted" == "mounted" ]]; then
      echo "WARN: Skipping disk with serial number '$serial' because it is mounted .."
    else
      if sudo sfdisk -d $disk 2>&1 | grep "does not contain a recognized partition table" &>/dev/null; then
        echo "  disk: $disk | serial: $serial"
        mkdir -p /mnt/chia/$serial
        chmod 777 -R /mnt/chia/$serial
        chown ubuntu:ubuntu -R /mnt/chia/$serial
        read -ra values <<< "$(sudo blkid -p $disk)"
        for value in "${values[@]}"; do
            echo $value
            if [[ $value == TYPE* ]]; then
                type=$(echo $value | cut -d'=' -f2)
                fs_type=$(echo $type | tr -d '"')
                echo "fs_type: $fs_type"
                if [[ "$fs_type" != "btrfs" ]]; then
                    echo "ERR: disk '$disk' with serial number '$serial' has FS type '$fs_type'!"
                    exit 1
                fi
            fi
        done
        sudo btrfs filesystem label $disk $serial
        echo -e "LABEL=$serial\t/mnt/chia/$serial\t\tbtrfs\tdefaults,compress=none,nofail\t0\t0" | sudo tee -a /etc/fstab
        sudo mkdir -p /mnt/chia/$serial
        sudo chown $user:$user -R /mnt/chia/$serial
        sudo chmod 777 -R /mnt/chia/$serial
        sudo mount /mnt/chia/$serial
      else
        echo "WARN: Skipping disk '$disk | $serial' because it has partitions on it .."
      fi
    fi
done
sudo chown $user:$user -R /mnt/chia/
sudo chmod 777 -R /mnt/chia/
