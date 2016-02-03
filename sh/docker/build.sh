#!/usr/bin/env bash


DIMAGE=bekozi/nbuild-centos6

########################################################################################################################
## BUILD DOCKER IMAGE ##

#file=DockerFile
#docker build -t ${dimage} --file ${file} .

########################################################################################################################
## BUILD/UPLOAD ESMPy ##
docker run --cpuset-cpus=3 -it -v ~/l/project/conda-esmf:/conda-esmf ${DIMAGE} bash
