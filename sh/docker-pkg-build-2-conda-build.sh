#!/usr/bin/env bash

source docker-pkg-build-1-interactive.sh
cd /project/conda-recipes-nesii

#conda build -c nesii ocgis
#conda build -c conda-forge esmf
conda build -c nesii -c conda-forge esmpy

#anaconda login
#anaconda upload -u nesii `conda build --output ocgis`
#anaconda upload -u nesii `conda build --output gdal`
#anaconda upload -u nesii `conda build --output fiona`
#anaconda upload -u nesii `conda build --output esmf`
#anaconda upload -u nesii `conda build --output esmpy`
