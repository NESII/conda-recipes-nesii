#!/usr/bin/env bash

image=bekozi/ntest-ubuntu
name=ocgis-test-runner

docker pull ${image}
docker rm ${name}
docker run -id --name ${name} ${image}
docker exec ${name} bash -c "conda create -y -n test-ocgis -c nesii ocgis nose esmpy"
docker exec ${name} bash -c "source activate test-ocgis && python -c \"from ocgis.test import run_all; run_all()\""
docker stop ${name}
