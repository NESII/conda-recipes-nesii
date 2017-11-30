#!/bin/bash

export CC=mpicc

./configure --enable-parallel --prefix=${PREFIX}

#./configure \
#     --prefix=${PREFIX} \
#     --enable-fortran \
#     --enable-hl \
#     --enable-shared \
#     --enable-parallel \
#     --with-zlib

make -j ${CPU_COUNT}
#make check
make install
