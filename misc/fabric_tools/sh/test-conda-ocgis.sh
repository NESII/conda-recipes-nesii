#!/usr/bin/env bash

CENV=test-conda-ocgis
#CHANNEL=https://conda.binstar.org/nesii/channel/dev
CHANNEL=nesii/channel/ocgis
PACKAGE=ocgis
TEST_TARGET=run_no_esmf

# Remove the test environment if it exists.
rm -r ~/anaconda/envs/${CENV}

# Remove any cached packages.
#yes | conda clean -t
sudo rm -r ~/anaconda/pkgs/*

yes | conda create -n ${CENV} nose
source activate ${CENV}
yes | conda install -c ${CHANNEL} ${PACKAGE}

python -c "from ocgis.test import ${TEST_TARGET}; ${TEST_TARGET}()"
source deactivate

rm -r ~/anaconda/envs/${CENV}
