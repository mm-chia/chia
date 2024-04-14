#!/usr/bin/env bash

#set -xe

#datenow=$(date +'%Y-%m-%d_%H-%M')
#logfile=/home/ubuntu/log/chia-$datenow.log
#exec > >(tee -ia $logfile)

#launcher_id=0x82f4098dc030d2903d8b45d8db5039cf88f6381095014845fff4180a47230c3a
#payout_address=xch19rced59sy2f53k0heg0zvhftx76vnfpvx8zenvkla86c2ak2jwaseneuw7
#owner_public_key=8501b8594e8263ab1db7bc9517b34f32d85221eb232b50185afe963338eaf2277ecb3c6d48d320c6e43e4733d0c71d75
#owner_public_key=87ab87add2f0eb739b9900f1f070c4af803192c74e39d11e2a9d01d9071190b754aaca53c3101ae50ebcdc9f1fb8c433
owner_public_key=aedf4c3dbd789a35084b7e64416b113ad7c8842acb3cdd80a2f66bde35ac3e0ec6e32d82e40a48bfed8910f34fe2aed5
pool_contract_address=xch19rced59sy2f53k0heg0zvhftx76vnfpvx8zenvkla86c2ak2jwaseneuw7

plot_count=9999
needed_space=20
compression_level=7

if [ $# -eq 0 ]; then
    echo "FATAL: at least one buffer location needd to be provided as argument!"
    echo "example:"
    echo "./plot.sh /mnt/ramdisk/ /media/ubuntu/flashmax /media/ubuntu/fast"
    exit 1
fi

buffer_locations=("$@")

function create_plot() {
    local buffer=$1

    rm -f $buffer/*.tmp

    local free_space_gb=$(df -BG "$buffer" | grep -vE '^Filesystem|cdrom' | awk '{print $4}')
    local free_space=${free_space_gb%?}

    if [ -z $free_space ]; then
        echo "FATAL: cannot get free space on buffer '$buffer'!"
        exit 1
    fi

    if [ $free_space -lt $needed_space ]; then
        echo "WARNING: buffer location '$buffer' is running out of space! $free_space GB are available!"
    else
        echo -e "INFO: Starting plot to location '$buffer'. Started at: $(date)\n"
        time $HOME/bladebit/build-release/bladebit_cuda -f $owner_public_key -c $pool_contract_address -n $plot_count -z 7 cudaplot "$buffer"
#        time $HOME/bladebit/build/bladebit_cuda -f $farmer_public_key -c $launcher_id -n 4 cudaplot "$buffer"
#        time $HOME/bladebit/build/bladebit_cuda -f $farmer_public_key -c $launcher_id -p $payout_address -n 4 cudaplot "$buffer"
        echo -e "INFO: Finished plot at: $(date)\n"
#        sleep 30
        plot_created=true
    fi
}

while true; do
    plot_created=false
    for buffer_location in "${buffer_locations[@]}"; do
        create_plot $buffer_location
        if [[ "$plot_created" == "true" ]]; then break; fi
    done

    if [[ $plot_created == "false" ]]; then
        echo -e "ERROR: All buffers are out of space. Waiting 10 sec to free up ..\n"
        sleep 10
    fi
done
