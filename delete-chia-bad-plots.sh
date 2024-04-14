#!/bin/env bash

set -e

log_folder=/home/ubuntu/logs/
log_file_name=$(date +'%Y-%m-%d_%H-%M-%S').log
mkdir -p $log_folder
exec &> >(tee -a "$log_folder/$log_file_name")

chia_log_file=/home/ubuntu/.chia/mainnet/log/debug.log
bad_files=$(cat $chia_log_file | grep --text "File: /" | cut -d' ' -f9 | grep chia | grep plot)

for bad_file in ${bad_files[@]}; do
    if [ -f $bad_file ]; then
        echo "WARN: Deleting bad file '$bad_file'!"
        rm -f "$bad_file"
    else
        echo "INFO: Skipping bad file '$bad_file' as it does not exist .."
    fi
done
