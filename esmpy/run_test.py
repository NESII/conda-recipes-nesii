import os
import subprocess

import ESMF

if ESMF.__version__.startswith('7') and os.uname()[0] != 'Darwin':
    cmd = ['mpirun', '-np', '4', 'nosetests', '-vs', '-a', '!slow,!data,!serial', 'ESMF']
    subprocess.check_call(cmd)
