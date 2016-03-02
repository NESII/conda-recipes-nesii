#!/usr/bin/env bash

CENV=test-conda-ocgis-esmf
CHANNEL_ESMPY=https://conda.binstar.org/nesii/channel/esmf
CHANNEL_OCGIS=https://conda.binstar.org/nesii/channel/ocgis
PACKAGE_ESMPY="esmpy==6.3.0rp1"
PACKAGE_OCGIS="ocgis==1.2.0"
TEST_TARGET=run_all

# Remove the test environment if it exists.
sudo rm -r ~/anaconda/envs/${CENV}

# Remove any cached packages.
#yes | conda clean -t
sudo rm -r ~/anaconda/pkgs/*

yes | conda create -n ${CENV} nose && \
source activate ${CENV} && \
yes | conda install -c ${CHANNEL_ESMPY} ${PACKAGE_ESMPY} && \
yes | conda install -c ${CHANNEL_OCGIS} ${PACKAGE_OCGIS}

python -c "from ocgis.test import ${TEST_TARGET}; ${TEST_TARGET}()"

source deactivate

rm -r ~/anaconda/envs/${CENV}
