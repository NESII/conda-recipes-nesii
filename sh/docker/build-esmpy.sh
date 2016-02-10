#!/usr/bin/env bash

cd /conda-esmf
conda config --add channels nesii
conda build esmf
conda build esmpy
#anaconda login
#anaconda upload -u nesii `conda build --output esmpy esmf`
