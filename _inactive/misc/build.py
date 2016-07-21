import os
from subprocess import check_output, check_call

# PKGS = ['gcc', 'openmpi', 'mpich2', 'libnetcdf', 'f90netcdf', 'esmf', 'mpi4py', 'esmpy']
PKGS = ['gcc', 'openmpi', 'hdf5', 'libnetcdf', 'f90netcdf', 'esmf', 'mpi4py', 'esmpy']
ROOT = os.path.expanduser('~/sandbox/conda-esmf')

os.chdir(ROOT)
check_call(['git', 'pull'])
for pkg in PKGS:
    path = os.path.join(ROOT, pkg)
    os.chdir(path)
    #check_call(['conda', 'build', '.'])
    check_call(['conda', 'build', '--no-test', '.'])
