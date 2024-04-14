#!/bin/env bash

set -xe

cd ~/chia-src/chia-blockchain/
. ./activate
bash start-gui.sh &
