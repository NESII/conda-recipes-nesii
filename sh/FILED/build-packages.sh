#!/usr/bin/env bash

cd /project/conda-esmf

#conda build -c nesii ocgis
#conda build -c nesii esmf esmpy
#conda build -c nesii esmf

PYS=(
     2.7
     3.5
     3.6
    )

PKGS=(
      ocgis
#      icclim
#      esmf
#      esmpy
      )

for p in ${PYS[*]}; do
    for pkg in ${PKGS[*]}; do
        echo "package:" $pkg, python=$p
        conda build -c conda-forge --python=${p} $pkg || exit 1
    done
done

#anaconda login
#anaconda upload -u nesii `conda build --output ocgis`
#anaconda upload -u nesii `conda build --output icclim`
#anaconda upload -u nesii `conda build --output gdal`
#anaconda upload -u nesii `conda build --output fiona`
