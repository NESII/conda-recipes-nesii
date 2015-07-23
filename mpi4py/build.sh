#!/bin/bash

#export SDKROOT=/

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_LIBRARY_PATH=${PREFIX}/lib
fi

$PYTHON setup.py install
