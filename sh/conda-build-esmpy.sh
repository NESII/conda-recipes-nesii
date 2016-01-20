#!/usr/bin/env bash


export CBUILD_ESMF_VERSION=7.0.0
export CBUILD_ESMF_TAG=ESMF_7_0_0

git clone -b next https://github.com/NESII/conda-esmf
cd conda-esmf

# Removing downloaded packages is a good idea.
#find `conda info --root`/pkgs -name 'netcdf-fortran*' -o -name 'mpich2*' -o -name 'mpi4py*' -o -name 'esmf*' -o -name 'esmpy*' | exec rm {} \;

# Assumes "conda-build" is installed. If not, run: "conda install conda-build".
conda build netcdf-fortran
conda build mpich2
conda build mpi4py
conda build esmf
conda build esmpy

# Use these commands to install and quickly test the build ESMPy installation.
#conda create --use-local -n esmpy "esmpy=7.0.0 esmf"
#source activate esmpy
#python -c "import ESMF"
