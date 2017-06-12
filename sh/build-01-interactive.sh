#!/usr/bin/env bash


export DIMAGE=condaforge/linux-anvil
#export DIMAGE=bekozi/nbuild-centos6
export HOST_PROJECT=/home/ubuntu/project
#export HOST_PROJECT=~/l/project

########################################################################################################################
## BUILD DOCKER IMAGE ##

#file=DockerFile
#docker build -t ${dimage} --file ${file} .

########################################################################################################################
docker pull ${DIMAGE}
docker run --cpuset-cpus=4 -it -v ${HOST_PROJECT}:/project ${DIMAGE} bash
