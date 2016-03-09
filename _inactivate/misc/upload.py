import os
from subprocess import check_output, check_call


# PKGS = ['gcc', 'openmpi', 'mpich2', 'libnetcdf', 'f90netcdf', 'esmf', 'mpi4py', 'esmpy']
PKGS = ['gcc', 'openmpi', 'hdf5', 'libnetcdf', 'f90netcdf', 'esmf', 'mpi4py', 'esmpy']
ROOT = os.path.expanduser('~/sandbox/conda-esmf')

for pkg in PKGS:
    os.chdir(os.path.join(ROOT, pkg))
    to_upload = check_output(['conda', 'build', '--output', '.']).strip()
    check_call(['binstar', 'upload', '--force', '-c', 'dev', to_upload, '-u', 'nesii'])
