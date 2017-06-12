#!/bin/bash

./configure --prefix=${PREFIX} \
            --enable-fortran \
            --enable-cxx \

make -j ${CPU_COUNT}
make install
