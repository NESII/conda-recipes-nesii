#!/bin/bash

ZDIR=${PREFIX}
./configure --prefix=${ZDIR}
make check
make install