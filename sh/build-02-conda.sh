#!/usr/bin/env bash

LOGDIR=/opt

#ESMPY_PYVER=(3.5)
ESMPY_PYVER=(2.7 3.5 3.6)
OCGIS_PYVER=(2.7 3.5 3.6)
ICCLIM_PYVER=(2.7 3.5 3.6)

ESMF_LABEL="-l dev-esmf"
#ESMF_LABEL="-l main"

OCGIS_LABEL="-l dev-ocgis"
#OCGIS_LABEL="-l main -l ocgis"
#OCGIS_LABEL="-l main -l ocgis-next"

FORCE="false"
#FORCE="true"

#UPLOAD="true"
UPLOAD="false"

BUILD="true"
#BUILD="false"

########################################################################################################################

# Navigate to Anaconda recipes project directory in Docker interactive session.
mkdir -p ${LOGDIR}
cd ..

if [ ${UPLOAD} == "true" ]; then
    anaconda login
fi

# Set the force flag to use for clobbering existing packages on Anaconda.org
if [ ${FORCE} == "true" ]; then
    FORCE_FLAG="--force"
else
    FORCE_FLAG=""
fi

# Set conda-forge channel package priority.
conda config --prepend channels "conda-forge"

########################################################################################################################
# Build ESMF

if [ ${BUILD} == "true" ]; then
    conda build -c conda-forge esmf
fi
if [ ${UPLOAD} == "true" ]; then
    anaconda upload -u nesii ${FORCE_FLAG} ${ESMF_LABEL} `conda build --output esmf`
fi

for ii in ${ESMPY_PYVER[*]}; do
    if [ ${BUILD} == "true" ]; then
        conda build -c conda-forge --python ${ii} esmpy 2>&1 | tee ${LOGDIR}/cb-esmpy-py${ii}-`date +%Y%m%d-%H%M%S`.log
    fi
    if [ ${UPLOAD} == "true" ]; then
        anaconda upload -u nesii ${FORCE_FLAG} ${ESMF_LABEL} `conda build --output --python ${ii} esmpy`
    fi
done

#######################################################################################################################
# Build OCGIS

#for ii in ${OCGIS_PYVER[*]}; do
#    if [ ${BUILD} == "true" ]; then
#        conda build -c conda-forge --python ${ii} ocgis
#    fi
#    if [ ${UPLOAD} == "true" ]; then
#        anaconda upload -u nesii ${FORCE_FLAG} ${OCGIS_LABEL} `conda build --output --python ${ii} ocgis`
#    fi
#done

########################################################################################################################
# Build ICCLIM

#for ii in ${ICCLIM_PYVER[*]}; do
#    if [ ${BUILD} == "true" ]; then
#        conda build -c conda-forge --python ${ii} icclim || exit 1
#    fi
#    if [ ${UPLOAD} == "true" ]; then
#        anaconda upload -u nesii ${FORCE_FLAG} ${OCGIS_LABEL} `conda build --output --python ${ii} icclim` || exit 1
#    fi
#done

########################################################################################################################
