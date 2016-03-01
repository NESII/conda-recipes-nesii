#!/usr/bin/env bash

cd /conda-esmf
conda build -c nesii esmf
conda build -c nesii esmpy
#anaconda login
#anaconda upload -u nesii `conda build --output esmpy esmf`
