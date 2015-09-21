from collections import OrderedDict

from logbook import Logger


# https://github.com/bekozi/simple-aws

WORKER_NAME_BUILD = 'build-centos6-aws'
WORKER_NAME_TEST = 'test-ubuntu-aws'

# AWS #

AWS_NAME_BUILD = 'conda-build'

# AWS_TYPE_BUILD = 't2.micro'
# AWS_TYPE_BUILD = 'm3.large'
# AWS_TYPE_BUILD = 'm3.xlarge'
AWS_TYPE_BUILD = 'm3.2xlarge'

AWS_TYPE_TEST = 'm3.large'
AWS_NAME_TEST = 'ocgis-test-node'

AWS_EBS_SHOULD_MOUNT = False
AWS_EBS_MOUNT_NAME = '/dev/xvdg'
AWS_EBS_SNAPSHOT_ID = 'snap-310873bc'

# PATHS #

CONDA_BASE = '~/anaconda'

# BUILDING #

#tdk: change back to dev branch for conda-esmf
GIT_REPOS = {
             # 'conda-esmf': {'url': 'https://github.com/NESII/conda-esmf', 'branch': 'dev'},
             'conda-esmf': {'url': 'https://github.com/NESII/conda-esmf', 'branch': 'master'},
             'dougal': {'url': 'https://github.com/NESII/conda-recipes-2', 'branch': 'dev'}}

TO_BUILD_OCGIS = OrderedDict()
# TO_BUILD_OCGIS['dougal'] = [
#     'libspatialindex',
#     'rtree'
# ]
TO_BUILD_OCGIS['conda-esmf'] = [
    # 'expat',
    # 'udunits',
    # 'proj4',
    # 'cfunits',
    # 'icclim',
    'ocgis',
]

TO_BUILD_ESMF = OrderedDict()
TO_BUILD_ESMF['conda-esmf'] = [
    'gcc',
    'hdf5',
    'libnetcdf',
    'f90netcdf',
    'mpich2',
    'mpi4py',
    'esmf',
    'esmpy',
]

# TO_BUILD = TO_BUILD_OCGIS
TO_BUILD = TO_BUILD_ESMF

CBUILD_ENV = dict(
    # CBUILD_ESMF_TAG='ESMF_6_3_0rp1',
    # CBUILD_ESMF_VERSION='6.3.0rp1',
    # CBUILD_ESMF_TAG='HEAD',
    # CBUILD_ESMF_VERSION='HEAD',
    CBUILD_ESMF_TAG='ESMF_7_0_0_beta_snapshot_55',
    CBUILD_ESMF_VERSION='7.0.0bs55',
    # CBUILD_OCGIS_TAG='next',
    # CBUILD_OCGIS_VERSION='1.1.0n',
    CBUILD_OCGIS_TAG='v1.2.0',
    CBUILD_OCGIS_VERSION='1.2.0',
    # set to "simple" to run smaller test target. set to "all" to run all tests
    CBUILD_OCGIS_TEST_TARGET='simple',
    CBUILD_NETCDF4_PYTHON_VERSION='1.1.7',
    CBUILD_NETCDF4_PYTHON_TAG='v1.1.7rel',
    CBUILD_CFUNITS_VERSION='1.0',
    # osx related build variables
    # DYLD_LIBRARY_PATH='/Users/ben.koziol/anaconda/envs/_test/lib:${DYLD_LIBRARY_PATH}',
    # GIT_SSL_NO_VERIFY='true'
)

BINSTAR_ADD_CHANNELS = 'https://conda.binstar.org/nesii/channel/ocgis'
BINSTAR_CHANNEL = 'https://conda.binstar.org/nesii/channel/dev'
BINSTAR_USER = 'bekozi'
BINSTAR_ORGANIZATION = 'nesii'

TEST_CONDA_PACKAGES = ['esmpy', 'ocgis']

# env.user = 'root'
# env.hosts = ['52.24.47.96']
# env.key_filename = '~/.ssh/ocgis-bwk.pem'
# env.connection_attempts = 10

########################################################################################################################

CONDA_BIN = '{0}/bin'.format(CONDA_BASE)
BINSTAR = '{0}/binstar'.format(CONDA_BIN)
CONDA = '{0}/conda'.format(CONDA_BIN)
CONDA_ACTIVATE = '{0}/activate'.format(CONDA_BIN)
CONDA_DEACTIVATE = '{0}/deactivate'.format(CONDA_BIN)
CONDA_ENVS = '{0}/envs'.format(CONDA_BASE)
LOG = Logger('conda-build')

