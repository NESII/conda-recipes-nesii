#!/bin/bash

INSTALL=/home/ubuntu/install

./configure --prefix=${INSTALL}/gcc \
            --enable-languages=c,c++,fortran \
            --enable-checking=release \
            --disable-bootstrap \
            --enable-threads \
            --with-gmp=${INSTALL}/gmp \
            --with-mpfr=${INSTALL}/mpfr \
            --with-mpc=${INSTALL}/mpc

make
make install
