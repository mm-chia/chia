#!/usr/bin/env python3

import os, sys, glob

path = "/mnt/chia"

#dirs  = os.listdir(path)
#dirs = [os.path.join(path,f) for f in dirs if os.path.isdir(os.path.join(path,f))]

DESTS_PATH = "/mnt/chia"
DESTS = [os.path.join(DESTS_PATH,f) for f in os.listdir(DESTS_PATH) if os.path.isdir(os.path.join(DESTS_PATH,f))]

#for f in dirs:
#    full_path = os.path.join(path,f)
#    if os.path.isdir(full_path):
#        print(full_path)

print(DESTS)

#dests= glob.glob('/mnt/chia/*')
#print(dests)
