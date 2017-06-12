#!/usr/bin/env bash

image=continuumio/miniconda
name=test-runner

docker pull ${image}
docker rm ${name}
docker run -id --name ${name} ${image}

#docker exec ${name} bash -c "conda create -y -n test -c nesii ocgis nose esmpy"
#docker exec ${name} bash -c "conda create -y -n test -c nesii/label/ocgis-next -c nesii ocgis-next nose esmpy"
docker exec ${name} bash -c "conda create -y -n test -c nesii -c conda-forge esmpy nose"
#docker exec ${name} bash -c "conda create -y -n test -c esmpy ocgis nose"

docker exec ${name} bash -c 'source activate test && nosetests -vs -a "!data,!slow,serial" ESMF'

#docker exec ${name} bash -c "source activate test && python -c \"from ocgis.test import run_all; run_all()\""
#docker exec ${name} bash -c "source activate test && python -c \"from ocgis.test import run_simple; run_simple()\""

docker stop ${name}
