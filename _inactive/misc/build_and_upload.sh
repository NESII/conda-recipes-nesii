#! /bin/bash

# which ESMF to use
export CBUILD_ESMF_TAG=ESMF_7_0_0_beta_snapshot_51
export CBUILD_ESMF_VERSION=7.0.0bs51

# for output files
export DATADIR=$HOME/condabuildoutput
if [ -d "$DIRECTORY" ]; then
    mkdir $DATADIR
fi

python build.py 2>&1 | tee $DATADIR/condabuild.out || exit 1
python upload.py 2>&1 | tee $DATADIR/condaupload.out || exit 1

# move back to parent conda-esmf directory and run tests
./esmpytest.sh 2>&1 | tee $DATADIR/esmpy_tests.out || exit 1
