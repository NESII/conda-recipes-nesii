#!/usr/bin/env bash

cd /conda-esmf
conda build -c nesii esmf
conda build -c nesii esmpy
#anaconda login
#anaconda upload -u nesii -c esmf -c main `conda build --output esmpy esmf`
#anaconda upload -u nesii -c esmf -c main `conda build --output esmf`
