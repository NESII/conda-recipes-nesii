#!/usr/bin/env bash


DIMAGE=bekozi/nbuild-centos6

########################################################################################################################
## BUILD DOCKER IMAGE ##

#file=DockerFile
#docker build -t ${dimage} --file ${file} .

########################################################################################################################
docker pull ${DIMAGE}
docker run --cpuset-cpus=4 -it -v ~/l/project:/project ${DIMAGE} bash
