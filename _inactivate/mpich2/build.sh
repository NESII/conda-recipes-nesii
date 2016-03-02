#!/bin/bash

#if [ "$(uname)" == "Darwin" ]; then
#    export DYLD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
#else
#    export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
#fi
#
#export CC="${PREFIX}/bin/gcc -pthread"
#export CXX="${PREFIX}/bin/g++ -pthread"
#export CPP=${PREFIX}/bin/cpp
#
#export F77="${PREFIX}/bin/gfortran -fopenmp"
#export FC="${PREFIX}/bin/gfortran -fopenmp"

./configure --prefix=${PREFIX} \
            --enable-shared

# build and install
# parallel build not supported: https://trac.mpich.org/projects/mpich/ticket/955
make
#make -j ${CPU_COUNT}
make install
