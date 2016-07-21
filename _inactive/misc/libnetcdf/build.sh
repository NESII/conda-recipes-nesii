#!/bin/bash

export CFLAGS="-I${PREFIX}/include $CFLAGS"
export CPPLAGS="-I${PREFIX}/include $CPPFLAGS"
export LDFLAGS="-L${PREFIX}/lib $LDFLAGS"

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
else
    export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
fi

./configure \
    --enable-shared \
    --enable-netcdf-4 \
    --enable-dap \
    --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install
