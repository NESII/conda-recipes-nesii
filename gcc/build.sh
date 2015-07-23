#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib
fi

./configure --prefix=${PREFIX} \
            --enable-languages=c,c++,fortran \
            --enable-checking=release \
            --enable-threads \
            --with-gmp=${PREFIX} \
            --with-mpfr=${PREFIX} \
            --with-mpc=${PREFIX} \
            --disable-multilib \
            --disable-bootstrap

# build optimized, save 40% disk space for final installation
#make BOOT_CFLAGS='-O' bootstrap

# build and install
make -j ${CPU_COUNT}
make install
