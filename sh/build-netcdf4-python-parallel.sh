#!/usr/bin/env bash

_BUILD="conda build -c conda-forge"

source activate ocgis

cd ..
${_BUILD} hdf5 && \
${_BUILD} libnetcdf && \
${_BUILD} mpi4py && \
${_BUILD} netcdf4
