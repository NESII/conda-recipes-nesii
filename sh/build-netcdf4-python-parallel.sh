#!/usr/bin/env bash

_CONDA_ROOT=~/l/anaconda/bin/
_CONDA="${_CONDA_ROOT}/conda"
_BUILD="${_CONDA} build -c conda-forge"

source activate ocgis

cd ..
${_BUILD} hdf5 && \
${_BUILD} libnetcdf && \
${_BUILD} mpi4py && \
${_BUILD} netcdf4
