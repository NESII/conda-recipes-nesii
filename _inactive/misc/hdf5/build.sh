#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib64:${PREFIX}/lib
else
    export LD_LIBRARY_PATH=${PREFIX}/lib64:${PREFIX}/lib
fi

./configure --prefix=${PREFIX} \
            --enable-fortran \
            --enable-cxx \

# build and install
make -j ${CPU_COUNT}
make install
