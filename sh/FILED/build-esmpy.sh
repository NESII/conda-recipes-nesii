#!/usr/bin/env bash


docker pull bekozi/nbuild-ubuntu
docker run -it -v ~/project:/project bekozi/nbuild ubuntu

cd ~/project/conda-esmf
conda build -c nesii netcdf-fortran esmf esmpy

anaconda login
anaconda upload -u nesii `conda build --output netcdf-fortran esmf esmpy`
