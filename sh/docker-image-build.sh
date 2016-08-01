#!/usr/bin/env bash


#docker login

pushd ~/l/project/conda-esmf

name=bekozi/nbuild-centos6
file=./Dockerfile-CentOS6-Builder
docker build --pull --no-cache -t ${name} --file ${file} .
docker push ${name}

name=bekozi/ntest-ubuntu
file=./Dockerfile-Ubuntu-Tester
docker build --pull --no-cache -t ${name} --file ${file} .
docker push ${name}

name=bekozi/nbuild-ubuntu
file=./Dockerfile-Ubuntu-Builder
docker build --pull --no-cache -t ${name} --file ${file} .
docker push ${name}

popd
