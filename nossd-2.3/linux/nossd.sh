#!/usr/bin/env bash

cd "$(dirname "$(realpath "${BASH_SOURCE[0]:-$0}")")"

function get_drives {
    local paths=( $(find /mnt/chia/ -maxdepth 1 -mindepth 1 -type d) )
    local DISKS=""
    for path in ${paths[@]}; do
        DISKS="$DISKS -d $path"
    done
    echo $DISKS
}

DRIVES=$(get_drives)
./client $DRIVES -a xch1zd5x74f6n9lssjqdtk80qldxypgqrdgshf5v4xv432y7a0h9up8sm703lv --no-temp --no-plotting
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15 -g,100M 25F0

#./client -d /mnt/chia/5QJ6DDTB -d /mnt/chia/5QJ1MVXB -d /mnt/chia/D5H9VX0F -d /mnt/chia/5QHS9XXB -d /mnt/chia/5QJ782RB -d /mnt/chia/2AGZ6LVY -d /mnt/chia/2AH0ZTUY -d /mnt/chia/5QHYR66B -d /mnt/chia/2AH1W2GY -d /mnt/chia/2AH21XZY -d /mnt/chia/5QH53VEB -d /mnt/chia/5QJ47XVB --no-temp --no-plotting -x,100M A2000
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15 -g,100M A2000
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15 -g,100M 229
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15
#./client -d /mnt/chia/2JJ6019C -d /mnt/chia/Y6G5234C -d /mnt/chia/9MH0EHWJ -d /mnt/chia/ZR900ZWA --no-temp --no-mining --no-stop -c 15 -g,100M 229
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15 -g,100M 229
#./client -d /mnt/ramdisk0 --no-temp --no-mining --no-stop -c 15
