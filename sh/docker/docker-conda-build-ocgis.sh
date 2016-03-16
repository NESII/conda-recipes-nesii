#!/usr/bin/env bash

# Script should not be run from command line.
exit 1

image=bekozi/nbuild-centos6
docker pull ${image}
docker run -it -v ~/l/project:/project ${image} bash

cd /project/conda-esmf
conda build -c nesii ocgis
#conda build proj.4

anaconda login
#anaconda upload -u nesii -c ocgis `conda build --output gdal fiona ocgis udunits2 munch rtree libspatialindex click-plugins cf_units`
anaconda upload -u nesii -c ocgis -c main `conda build --output ocgis`
