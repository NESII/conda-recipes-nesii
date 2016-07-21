#! /bin/bash

# for output files
DATADIR=$HOME/condabuildoutput
if [ ! -d $DATADIR ]; then
    mkdir $DATADIR
fi

# remove and rebuild test environment
rm -rf ~/anaconda/envs/test_esmpy
yes | conda create -n test_esmpy python || exit 1
source activate test_esmpy

# workaround to make sure that the binstar installed package is the one that is tested
export PYTHONPATH=''

# binstar
yes | conda install -c https://conda.binstar.org/nesii/channel/dev esmpy || exit 1
yes | conda install nose || exit 1

# run esmpy tests and pipe to file, exit as appropriate
ESMFDIR="$(python -c 'import ESMF; print ESMF.__file__')"
nosetests -vs -a '!slow,!data' $ESMFDIR/.. 2>&1 | tee $DATADIR/esmpy_serial_tests.out || exit 1
mpirun -np 4 nosetests -vs -a '!slow,!data,!serial' $ESMFDIR/.. 2>&1 | tee $DATADIR/esmpy_parallel_tests.out || exit 1
