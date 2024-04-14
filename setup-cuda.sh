#!/bin/env bash

sudo apt install build-essential -y
sudo apt-get install linux-headers-$(uname -r) -y
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get install cuda -y
sudo apt-get install cuda-toolkit -y
sudo apt-get install nvidia-gds -y
