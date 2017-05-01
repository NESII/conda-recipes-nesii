#!/usr/bin/env bash


DIMAGE=bekozi/nbuild-centos6
DNAME=nesii-builder
WD=~/l/project
DWD=/project/conda-recipes-nesii

docker pull ${DIMAGE}
docker rm test-runner
docker run -id --cpuset-cpus=4 -v ${WD}:${DWD} --name ${DNAME} ${DIMAGE} bash

docker exec ${DNAME} bash -c "anaconda login"
docker exec ${DNAME} bash -c "cd ${DWD} && conda build -c nesii -c conda-forge esmpy"

docker stop ${DNAME}


# This succeeds.
docker exec test-runner bash -c "wget --spider ${URI}"
# This fails.
docker exec test-runner bash -c "ncdump -h ${URI}"

# Download the data locally.
docker exec test-runner bash -c "wget ${URI}"
# Inspection works.
docker exec test-runner bash -c "ncdump -h slp.2000.nc"

# Check netCDF4-python version.
docker exec test-runner bash -c "python -c \"import netCDF4 as nc; assert(nc.__version__ == '1.2.2')\"" && \
# Try to load remote file using netCDF4-python. Fails.
docker exec test-runner bash -c "python -c \"import netCDF4 as nc; nc.Dataset('${URI}')\""
# Try to load locally downloaded file. Succeeds.
docker exec test-runner bash -c "python -c \"import netCDF4 as nc; nc.Dataset('slp.2000.nc'); print('successfully loaded 1.2.2')\""
docker exec test-runner bash -c "python -c \"import ocgis; ocgis.RequestDataset('slp.2000.nc').get(); print('successfully loaded ocgis 1.2.2')\""

# Install new netCDF4 version and try again.
docker exec test-runner bash -c "conda install -y -c conda-forge netCDF4"
docker exec test-runner bash -c "python -c \"import netCDF4 as nc; assert(nc.__version__ == '1.2.4')\"" && \
docker exec test-runner bash -c "python -c \"import netCDF4 as nc; nc.Dataset('slp.2000.nc'); print('successfully loaded 1.2.4')\""
docker exec test-runner bash -c "python -c \"import ocgis; ocgis.RequestDataset('slp.2000.nc').get(); print('successfully loaded ocgis 1.2.4')\""

docker stop test-runner