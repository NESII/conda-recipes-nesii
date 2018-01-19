#!/bin/bash

# See http://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html#build_parallel

export CFLAGS="-I$PREFIX/include -fPIC $CFLAGS"
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export CC=mpicc

#./configure \
#    --enable-shared \
#    --enable-netcdf-4 \
#    --enable-dap \
#    --without-ssl \
#    --without-libidn \
#    --disable-ldap \
#    --prefix=${PREFIX} \
#    --disable-shared

./configure \
    --enable-parallel-tests \
    --prefix=${PREFIX}
#    --disable-shared

#./configure --prefix=${PREFIX}

make
#make check
make install
