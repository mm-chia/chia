#!/bin/env bash

owner_public_key=aedf4c3dbd789a35084b7e64416b113ad7c8842acb3cdd80a2f66bde35ac3e0ec6e32d82e40a48bfed8910f34fe2aed5
#pool_public_key=94c78fb24c3500300c0cc6ff3e8ff313821587c080bc94663768abb9b8d8ea85903b9c7a8b9030adf279e8e27f32875c
pool_contract_address=xch19rced59sy2f53k0heg0zvhftx76vnfpvx8zenvkla86c2ak2jwaseneuw7

./cuda_plot_k32_v3 -n -1 -C 30 -t /mnt/ramdisk0/ -d /mnt/chia/9LHLR7DG/ -f $owner_public_key -c $pool_contract_address
#./cuda_plot_k32_v3 -n -1 -C 30 -t /mnt/ramdisk0/ -d /mnt/chia/2JJ78LAB/ -d /mnt/chia/2VGZEN6A/ -p $pool_contract_address -f $owner_public_key
#./cuda_plot_k32_v3 -r 2 -n -1 -C 30 -t /mnt/ramdisk0/ -d /mnt/chia/2JJ78LAB/ -d /mnt/chia/2VGZEN6A/ -p $pool_contract_address -f $owner_public_key
