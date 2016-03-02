#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib
fi

./configure --prefix=${PREFIX} \
            CC=${PREFIX}/bin/gcc \
            CXX=${PREFIX}/bin/g++\
            F77=${PREFIX}/bin/gfortran \
            FC=${PREFIX}/bin/gfortran 

# build and install
make -j ${CPU_COUNT} all
make install