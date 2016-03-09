#!/bin/bash

./configure prefix=${PREFIX} --with-gmp-include=${PREFIX}/include --with-gmp-lib=${PREFIX}/lib

make -j ${CPU_COUNT}
make install