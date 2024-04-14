#!/bin/env bash

gigahorse_release=$(python3 gigahorse-release.py)
gigahorse_release=${gigahorse_release:1}
echo "Gigahorse release: $gigahorse_release"

chia_file=chia-blockchain_${gigahorse_release}_amd64.deb
chiacli_file=chia-blockchain-cli_${gigahorse_release}-1_amd64.deb
cudaplot_file=cuda_plot_k32_v3
cudapos_file=ProofOfSpace

echo "Downloading file '$chia_file' .."
wget -q -N -O ${chia_file} https://github.com/madMAx43v3r/chia-gigahorse/releases/download/v${gigahorse_release}/${chia_file}

echo "Downloading file '$chiacli_file' .."
wget -q -N -O ${chiacli_file} https://github.com/madMAx43v3r/chia-gigahorse/releases/download/v${gigahorse_release}/${chiacli_file}

echo "Downloading file '$cudaplot_file' .."
wget -q -N -O ${cudaplot_file} https://github.com/madMAx43v3r/chia-gigahorse/raw/master/cuda-plotter/linux/x86_64/${cudaplot_file}
chmod +x ${cudaplot_file}

echo "Downloading file '$cudapos_file' .."
wget -q -N -O ${cudapos_file} https://github.com/madMAx43v3r/chia-gigahorse/raw/master/chiapos/linux/x86_64/${cudapos_file}
chmod +x ${cudapos_file}

sudo dpkg -i $chia_file
sudo dpkg -i $chiacli_file
