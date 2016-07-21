#!/usr/bin/env bash

cd /conda-esmf

#conda build -c nesii ocgis
#conda build -c nesii esmf esmpy
conda build -c nesii esmf

#anaconda login
#anaconda upload -u nesii `conda build --output ocgis`
anaconda upload -u nesii `conda build --output gdal`
anaconda upload -u nesii `conda build --output fiona`
