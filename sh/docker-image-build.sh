#!/usr/bin/env bash


pushd ~/l/project/conda-esmf

name=bekozi/nbuild-centos6
file=./Dockerfile-CentOS6-Builder
docker build --no-cache -t ${name} --file ${file} .
docker push ${name}

#name=bekozi/ntest-ubuntu
#file=./Dockerfile-Ubuntu-Tester
#docker build --no-cache -t ${name} --file ${file} .
#docker push ${name}

popd
