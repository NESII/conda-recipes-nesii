#!/bin/bash

#if [ "$(uname)" == "Darwin" ]; then
#    export DYLD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
#else
#    export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib64
#fi

export ESMFMKFILE=${PREFIX}/lib/esmf.mk
ESMPY_SRC=${SRC_DIR}/src/addon/ESMPy
cd ${ESMPY_SRC}

${PYTHON} setup.py build --ESMFMKFILE=${ESMFMKFILE}
${PYTHON} setup.py install

#${PYTHON} setup.py test || exit 1
#${PYTHON} setup.py test_examples || exit 1
#${PYTHON} setup.py test_parallel || exit 1
#${PYTHON} setup.py test_examples_parallel || exit 1
