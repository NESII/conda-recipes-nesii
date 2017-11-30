#!/bin/bash

export HDF5_DIR=${PREFIX}
#export HDF5_INCDIR=${PREFIX}/include
#export HDF5_LIBDIR=${PREFIX}/lib
#
#export NETCDF4_DIR=${PREFIX}
#export NETCDF4_INCDIR=${PREFIX}/include
#export NETCDF4_LIBDIR=${PREFIX}/lib
#
#export MPI_INCDIR=${PREFIX}/include
#
#export USE_NCCONFIG=1

#export CFLAGS="-fPIC ${CFLAGS}"

${PYTHON} setup.py install
