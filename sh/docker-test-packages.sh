#!/usr/bin/env bash

image=bekozi/ntest-ubuntu
name=ocgis-test-runner

docker pull ${image}
docker rm ${name}
docker run -id --name ${name} ${image}

#docker exec ${name} bash -c "conda create -y -n test -c nesii ocgis nose esmpy"
#docker exec ${name} bash -c "conda create -y -n test -c nesii/label/ocgis-next -c nesii ocgis-next nose esmpy"
docker exec ${name} bash -c "conda create -y -n test -c nesii/label/ocgis-next -c nesii ocgis-next nose"

#docker exec ${name} bash -c "source activate test && python -c \"from ocgis.test import run_all; run_all()\""
docker exec ${name} bash -c "source activate test && python -c \"from ocgis.test import run_simple; run_simple()\""

docker stop ${name}
