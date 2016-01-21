#!/usr/bin/env bash


anaconda login
conda config --add channels ioos
cd /conda-esmf
conda build ocgis
for package in ${TO_UPLOAD[@]}; do
    upload=`conda build --output ${package}`;
    anaconda upload --force -u nesii -c ${UPLOAD_CHANNEL} ${upload};
done
