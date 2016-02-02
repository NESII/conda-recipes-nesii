#!/bin/bash

# Initialization routines for an Anaconda instance. ##

export SHELL_NAME=Anaconda-2.2.0-Linux-x86_64.sh
export PATH_DOWNLOADS=~/src
export PATH_GIT=~/git
export ANACONDA_BIN=~/anaconda/bin
export GIT_CONDA_ESMF=https://github.com/NESII/conda-esmf.git

# centos ##

sudo yum makecache fast
sudo yum -y update
sudo yum -y install wget bzip2 git gcc gcc-c++ m4 autoconf libtool expat-devel texinfo path unzip gcc-gfortran

# install anaconda ##

mkdir ${PATH_DOWNLOADS}
pushd ${PATH_DOWNLOADS}
wget http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/${SHELL_NAME}
bash ${SHELL_NAME} -b
export PATH=${ANACONDA_BIN}:${PATH}
yes | conda update --all
popd

# clone conda-esmf ##

cd
mkdir ${PATH_GIT}
pushd ${PATH_GIT}
git clone ${GIT_CONDA_ESMF}
popd
