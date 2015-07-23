#!/usr/bin/env bash

TMPDIR=`mktemp -d`

pushd ${TMPDIR}
${SRC_DIR}/configure --prefix=${PREFIX}
make -j ${CPUCOUNT}
make install
popd

sudo rm -r ${TMPDIR}
