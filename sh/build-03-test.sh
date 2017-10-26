#!/usr/bin/env bash

python_versions=(2.7 3.5 3.6)
image=continuumio/miniconda
name=test-runner

docker pull ${image}
docker rm ${name}
docker run -id --name ${name} ${image}

for ii in ${python_versions[*]}; do
    docker exec ${name} bash -c "conda create -y -n test-${ii} -c nesii/channel/dev-esmf -c conda-forge esmpy nose python=${ii}"
    docker exec ${name} bash -c "source activate test-${ii} && nosetests -vs -a \"!data,!slow,serial\" ESMF"
done

docker stop ${name}
