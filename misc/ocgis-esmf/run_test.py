from ocgis.test import *
import os


test_target = os.environ.get('CBUILD_OCGIS_TEST_TARGET')
if test_target == 'simple' or test_target is None:
    run_simple()
elif test_target == 'all':
    run_all()
else:
    raise NotImplementedError(test_target)
