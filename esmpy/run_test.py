import os
import subprocess

import ESMF

try:
    import mpi4py
    has_mpi4py = True
except ImportError:
    has_mpi4py = False

if ESMF.__version__.startswith('7') and os.uname()[0] != 'Darwin':
    if has_mpi4py:
        cmd = ['mpirun', '-np', '4']
    else:
        cmd = []
    cmd.extend(['nosetests', '-vs', '-a', '!slow,!data,serial', 'ESMF'])
    subprocess.check_call(cmd)
