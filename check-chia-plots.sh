#!/bin/env bash

set -e

plot_folder=$1
check_depth=30
delay=5

log_folder=/home/ubuntu/logs/
log_file_name=check-$(date +'%Y-%m-%d_%H-%M-%S').log
mkdir -p $log_folder
exec &> >(tee -a "$log_folder/$log_file_name")

cd /home/ubuntu/chia-src/chia-blockchain/
. ./activate

for plot_file in $plot_folder/*.plot; do
    if [ -f $plot_file ]; then
        echo "INFO: checking plot file '$plot_file'"
        time chia plots check -n $check_depth -g $plot_file > /tmp/plot_check.txt 2>&1
        if cat /tmp/plot_check.txt | grep "invalid plots"; then
            echo "  -- invalid ---"
#            rm -f $plot_file
        else
            echo "  -- OK ---"
        fi
    else
        echo "WARN: '$plot_file' is not a valid file .."
    fi
    echo -e "\n"
    sleep $delay
done
