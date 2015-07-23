#!/bin/bash

export CFLAGS="-I${PREFIX}/include ${CFLAGS}"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
else
    export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
fi

./configure --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install