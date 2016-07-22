#!/usr/bin/env bash

WD=$(mktemp -d)
BRANCH=build-head
ENV_NAME=esmpy

cd ${WD}
git clone -b ${BRANCH} https://github.com/NESII/conda-recipes-nesii.git
cd conda-recipes-nesii
conda build esmpy
conda create -n ${ENV_NAME} --use-local esmpy==HEAD
source activate ${ENV_NAME}
python -c "import ESMF"
