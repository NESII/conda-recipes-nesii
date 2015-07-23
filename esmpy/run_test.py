import nose
import sys
import os
import subprocess

import ESMF

CBUILD_ESMF_VERSION = os.environ.get('CBUILD_ESMF_VERSION')
if CBUILD_ESMF_VERSION is not None and CBUILD_ESMF_VERSION.startswith('7.0.0'):
    # argv = [sys.argv[0], '-vs', '-a', '!slow,!data', 'ESMF']
    # result = nose.run(argv=argv)
    # if not result:
    #     sys.exit(1)

    cmd = ['mpirun', '-np', '4', 'nosetests', '-vs', '-a', '!slow,!data,!serial', 'ESMF']
    subprocess.check_call(cmd)
