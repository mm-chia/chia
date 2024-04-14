#!/bin/env bash

#drives=$(get_drives)

TOTAL_C14=0
TOTAL_C15=0
paths=( $(find /mnt/chia/ -maxdepth 1 -mindepth 1 -type d) )
for drive in ${paths[@]}; do
#    echo "Drive: $drive"
#    sleep 5
    drive_size=$(df -h | grep "$drive" | tr -s '[:blank:]' | cut -d' ' -f2)
    C14=0
    C15=0
    plots=( $(find "$drive" -maxdepth 1 -mindepth 1 -type f -name '*.fpt') )
    for plot in ${plots[@]}; do
        size=$(du -sh "$plot" | cut -d'G' -f1)
#        echo "Plot $plot | size: $size"
        if [ "$size" -eq "51" ]; then
            C15=$((C15+1))
        elif  [ "$size" -eq "54" ]; then
            C14=$((C14+1))
        else
            echo "ERROR: unknown plot size '$size' for plot '$plot'. Exiting .."
            exit 1
        fi
    done
    echo "Drive: $drive [$drive_size] | C14: $C14 | C15: $C15"
    TOTAL_C14=$((TOTAL_C14+$C14))
    TOTAL_C15=$((TOTAL_C15+$C15))
    echo "TOTAL_C14: $TOTAL_C14"
    echo "TOTAL_C15: $TOTAL_C15"
done
