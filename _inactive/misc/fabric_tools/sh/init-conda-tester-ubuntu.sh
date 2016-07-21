#!/usr/bin/env bash

# Initialization routines for an Anaconda instance. #

export SHELL_NAME=Anaconda-2.3.0-Linux-x86_64.sh
export DOWNLOAD_URL=https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/${SHELL_NAME}
export PATH_SRC=~/src
export ANACONDA_BIN=~/anaconda/bin

# Update system and install critical packages.
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget git curl

# Install Anaconda. #

mkdir ${PATH_SRC}
pushd ${PATH_SRC}
wget ${DOWNLOAD_URL}
bash ${SHELL_NAME} -b
export PATH=${ANACONDA_BIN}:${PATH}
yes | conda update --all
popd