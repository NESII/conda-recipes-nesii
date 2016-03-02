#!/bin/bash

# Initialization routines for an Anaconda instance. ##

export SHELL_NAME=Anaconda-2.2.0-MacOSX-x86_64.sh
export PATH_SRC=~/src
export ANACONDA_BIN=~/anaconda/bin
export GIT_CONDA_ESMF=https://github.com/NESII/conda-esmf.git

# install anaconda ##

mkdir ${PATH_SRC}
pushd ${PATH_SRC}
curl -O https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/${SHELL_NAME}
bash ${SHELL_NAME} -b
export PATH=${ANACONDA_BIN}:${PATH}
yes | conda update --all
popd

# clone conda-esmf ##

cd
mkdir ${PATH_SRC}
pushd ${PATH_SRC}
git clone ${GIT_CONDA_ESMF}
popd

