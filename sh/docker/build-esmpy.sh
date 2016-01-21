#!/usr/bin/env bash


anaconda login
conda config --add channels ${ADD_CHANNEL}
cd /conda-esmf
conda build esmpy
for package in ${TO_UPLOAD[@]}; do
    upload=`conda build --output ${package}` && \
    anaconda upload --force -u nesii -c ${UPLOAD_CHANNEL} ${upload}
done
