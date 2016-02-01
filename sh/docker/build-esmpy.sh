#!/usr/bin/env bash

#anaconda login
conda config --add channels ${ADD_CHANNEL}
cd /conda-esmf
conda build esmpy
#anaconda upload --force -u nesii -c ${UPLOAD_CHANNEL} `conda build --output esmpy esmf`
