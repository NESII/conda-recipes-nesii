#!/usr/bin/env bash


DIMAGE=bekozi/nbuild-centos6

BUILD_TARGET=ocgis
#BUILD_TARGET=esmpy

CBUILD_ESMF_VERSION=6.3.0rp1
CBUILD_ESMF_TAG=ESMF_6_3_0rp1
CBUILD_OCGIS_VERSION=1.2.0.dev1
CBUILD_OCGIS_TAG=next

UPLOAD_CHANNEL=dev-ocgis
#UPLOAD_CHANNEL=esmf

TO_UPLOAD=(ocgis)
#TO_UPLOAD=(netcdf-fortran esmf esmpy)
#TO_UPLOAD=(esmf esmpy)

########################################################################################################################
## BUILD DOCKER IMAGE ##

#file=DockerFile
#docker build -t ${dimage} --file ${file} .

########################################################################################################################
## BUILD/UPLOAD ESMPy ##

ENV="-e UPLOAD_CHANNEL=${UPLOAD_CHANNEL} -e TO_UPLOAD=${TO_UPLOAD} -e CBUILD_ESMF_VERSION=${CBUILD_ESMF_VERSION} \
     -e CBUILD_ESMF_TAG=${CBUILD_ESMF_TAG} -e CBUILD_OCGIS_VERSION=${CBUILD_OCGIS_VERSION} \
     -e CBUILD_OCGIS_TAG=${CBUILD_OCGIS_TAG}"
docker run ${ENV} --cpuset-cpus=3 -it -v ~/project/conda-esmf:/conda-esmf ${DIMAGE} \
    bash /conda-esmf/sh/build-${BUILD_TARGET}.sh
