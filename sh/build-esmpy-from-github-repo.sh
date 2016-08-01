#!/usr/bin/env bash

# Temporary working directory for recipe directory.
WD=$(mktemp -d)
# The branch containing the recipe for a HEAD build.
BRANCH="build-head"
# Conda environment to install into.
ENV_NAME="esmpy"

conda install --yes conda-build
cd ${WD}
git clone -b ${BRANCH} https://github.com/NESII/conda-recipes-nesii.git
cd conda-recipes-nesii
conda build libnetcdf
conda build netcdf-fortran
conda build esmpy
conda create --yes -n ${ENV_NAME} --use-local esmpy==HEAD
source activate ${ENV_NAME}
python -c "import ESMF; print('ESMF import successful.')"
