#!/usr/bin/env bash

cd ..
conda build hdf5 && \
conda build netcdf-c && \
conda build mpi4py && \
conda build netcdf4-python
