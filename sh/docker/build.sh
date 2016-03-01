#!/usr/bin/env bash


DIMAGE=bekozi/nbuild-centos6

## UPDATE DOCKER IMAGE ##
#conda update --all
#yum -y update && yum clean all
#docker commit -m "Updated libraries" ekozi/nbuild-centos6 bekozi/nbuild-centos6
#docker push bekozi/nbuild-centos6

########################################################################################################################
## BUILD DOCKER IMAGE ##

#file=DockerFile
#docker build -t ${dimage} --file ${file} .

########################################################################################################################
## BUILD/UPLOAD ESMPy ##
docker pull ${DIMAGE}
docker run --cpuset-cpus=3 -it -v ~/l/project/conda-esmf:/conda-esmf ${DIMAGE} bash
