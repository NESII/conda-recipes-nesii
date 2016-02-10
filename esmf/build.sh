#!/bin/bash


export ESMF_DIR=`pwd`
export ESMF_INSTALL_PREFIX=${PREFIX}
export ESMF_INSTALL_BINDIR=${PREFIX}/bin
export ESMF_INSTALL_DOCDIR=${PREFIX}/doc
export ESMF_INSTALL_HEADERDIR=${PREFIX}/include
export ESMF_INSTALL_LIBDIR=${PREFIX}/lib
export ESMF_INSTALL_MODDIR=${PREFIX}/mod
export ESMF_NETCDF="split"
export ESMF_NETCDF_INCLUDE=${PREFIX}/include
export ESMF_NETCDF_LIBPATH=${PREFIX}/lib
if [ "$(uname)" == "Darwin" ]; then
    export ESMF_COMM=mpiuni
#    export ESMF_COMM=openmpi
else
    export ESMF_COMM=mpich2
fi

make  -j ${CPU_COUNT}
#make all_tests | tee ~/esmf_all_tests.out
#make check
make install
