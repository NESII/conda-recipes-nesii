#!/usr/bin/env bash


#export CBUILD_ESMF_VERSION=7.0.0bs60
#export CBUILD_ESMF_TAG=ESMF_7_0_0_beta_snapshot_60
export CBUILD_ESMF_VERSION=6.3.0rp1
export CBUILD_ESMF_TAG=ESMF_6_3_0rp1
upload_channel=esmf

#to_upload=(netcdf-fortran esmf esmpy)
to_upload=(esmf esmpy)


conda config --add channels nesii/channel/esmf
cd /conda-esmf
conda build esmpy
for package in ${to_upload[@]}; do
    upload=`conda build --output ${package}`;
    anaconda upload --force -u nesii -c ${upload_channel} ${upload};
done
