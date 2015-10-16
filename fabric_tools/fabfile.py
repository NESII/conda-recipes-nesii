from fabric.context_managers import shell_env, prefix, settings
from fabric.contrib.files import append
from fabric.decorators import task
from fabric.operations import put, os
from fabric.state import env
from helpers import itersubclasses

from helpers import git_checkout, GitExists, get_worker
from settings import *


@task
def binstar_login():
    login = env.worker.run('binstar whoami')
    if 'Anonymous User' in login:
        LOG.info('not logged into binstar. logging in.')
        env.worker.run('binstar login')


@task
def binstar_package():
    #tdk: doc
    binstar_login()
    cmd = 'binstar package --private {0}/'.format(BINSTAR_USER)
    for pkgs in TO_BUILD.itervalues():
        for pkg in pkgs:
            env.worker.run(cmd + pkg)


@task
def binstar_remove(package=None):
    #tdk: doc
    binstar_login()
    cmd = 'yes | binstar remove {0}/'.format(BINSTAR_USER)
    if package is None:
        for pkgs in TO_BUILD.itervalues():
            for pkg in pkgs:
                env.worker.run(cmd + pkg)
    else:
        env.worker.run(cmd + package)


@task
def build(upload='false', channel='dev', upload_only='false', no_test='false', clean_lock='false',
          add_channels='false'):
    """Build the packages using conda."""

    if upload_only == 'true':
        upload = 'true'

    if clean_lock == 'true':
        env.worker.run('{0} clean --lock'.format(CONDA))

    if upload == 'true':
        binstar_login()

    if add_channels == 'true':
        for c in BINSTAR_ADD_CHANNELS:
            env.worker.run('{0} config --add channels {1}'.format(CONDA, c))
    # try:
    with shell_env(**CBUILD_ENV):
        for k, v in TO_BUILD.iteritems():
            path_git_repo = env.worker.get_git_path(GIT_REPOS[k]['url'])
            LOG.info('initializing git for {0}. path is {1}.'.format(k, path_git_repo))
            with settings(abort_exception=GitExists):
                with env.worker.cd(env.worker.path_git):
                    try:
                        git_clone(GIT_REPOS[k]['url'])
                    except GitExists:
                        # tdk: SSL certificate problems?
                        # pass
                        LOG.info('git repo exists. pulling in {0}'.format(path_git_repo))
                        with env.worker.cd(path_git_repo):
                            env.worker.run('git pull')

            for package_name in v:
                LOG.info('initializing git for {0}:{1}'.format(k, package_name))
                bpath = os.path.join(path_git_repo, package_name)
                LOG.info('path is {0}'.format(bpath))
                with env.worker.cd(bpath):
                    branch = GIT_REPOS[k]['branch']
                    LOG.info('checking out branch {0}'.format(branch))
                    # tdk: SSL certificate problems?
                    git_checkout(branch)

                    if upload_only == 'false':
                        if no_test == 'true':
                            nt = ' --no-test'
                        else:
                            nt = ''
                        cmd = '{0} build{1} .'.format(CONDA, nt)
                        env.worker.run(cmd)

                if upload == 'true':
                    build_upload(k, package_name, channel=channel, user=BINSTAR_ORGANIZATION)
    # finally:
    #     if add_channels == 'true':
    #         env.worker.run('{0} config -f --remove channels {1}'.format(CONDA, BINSTAR_ADD_CHANNELS))


@task
def build_upload(key, package_name, channel='dev', user=None):
    """
    Upload packages to binstar.

    :param str channel: The name of the target channel for upload.
    """
    # tdk: doc
    bpath = os.path.join(env.worker.get_git_path(GIT_REPOS[key]['url']), package_name)
    with env.worker.cd(bpath):
        path = env.worker.run('{0} build --output .'.format(CONDA)).strip()
        cmd = '{binstar} upload --force -c {channel} {path}'.format(binstar=BINSTAR, channel=channel, path=path)
        if user is not None:
            cmd += ' -u {0}'.format(user)
        env.worker.run(cmd)

@task
def conda_create(name, packages='ipython'):
    """
    Create a conda environment.

    :param str name: Name of the conda environment.
    :param str packages: The packages to install in the environment.

    >>> packages = 'ipython numpy'
    """
    cmd = '{c} create --yes -n {n} {p}'.format(c=CONDA, n=name, p=packages)
    env.worker.run(cmd)


@task
def configure_builder():
    from saws.tasks import run_bash_script
    script = os.path.join(os.path.split(os.path.realpath(__file__))[0], 'sh', 'init-conda-builder-centos6.sh')
    env.worker.manager.do_task(run_bash_script, args=(script,))
    append('~/.bashrc', 'export PATH=~/anaconda/bin:$PATH')


@task
def git_clone(uri):
    with env.worker.cd(env.worker.path_git):
        env.worker.run('git clone {0}'.format(uri))


@task
def git_clone_recipes():
    """Clone the GitHub recipe repositories."""
    with env.worker.cd(env.worker.path_git):
        for v in GIT_REPOS.itervalues():
            cmd = 'git clone {0}'.format(v)
            env.worker.run(cmd)


@task
def list_workers():
    from workers import AbstractWorker
    lworkers = []
    for Sub in itersubclasses(AbstractWorker):
        if not Sub.__name__.startswith('Abstract'):
            lworkers.append(Sub.name)
    lworkers.sort()
    for l in lworkers:
        print l


@task
def put_file(local_path, remote_path):
    """
    Put a file on the remote server: local_path,remote_path
    """

    put(local_path=local_path, remote_path=remote_path)


@task
def run_bash_script(script_name):
    from saws.tasks import run_bash_script
    script = os.path.join(os.path.split(os.path.realpath(__file__))[0], 'sh', script_name)
    env.worker.manager.do_task(run_bash_script, args=(script,), name=env.worker.aws_name)


@task
def set_worker(name_or_aspect, launch='false', path_git=None):
    """
    Set the target worker.

    :param str name_or_aspect: ``'build'``, ``'test'``, or the exact worker name.
    :param str launch: ``(='false')`` If ``'true'``, launch the AWS worker.
    :param str path_git: ``(=None)`` The path to the directory to clone git repositories.
    """
    names = {'build': WORKER_NAME_BUILD,
             'test': WORKER_NAME_TEST}
    the_name = names.get(name_or_aspect)
    if the_name is None:
        the_name = name_or_aspect
    Worker = get_worker(the_name)
    if launch == 'true':
        Worker.launch()
    Worker(path_git=path_git)


@task
def an_echo():
    env.worker.sudo('echo "hello world"')


@task
def worker_initialize(update='true', install_packages='true', update_conda='true'):
    if update == 'true':
        env.worker.system_update()
    if install_packages == 'true':
        env.worker.system_install_packages()
    if update_conda == 'true':
        env.worker.run('yes | conda update --all')


@task
def worker_terminate():
    env.worker.terminate()

@task
def test_conda(remove_env='true', package_to_test=None):
    # tdk: doc
    if package_to_test is None:
        packages_to_test = TEST_CONDA_PACKAGES
    else:
        packages_to_test = [package_to_test]

    for pkg in packages_to_test:
        n = 'test-{0}'.format(pkg)
        conda_create(n, packages='nose')
        try:
            with prefix('source {0} {1}'.format(CONDA_ACTIVATE, n)):
                env.worker.run('conda install --yes -c {0} {1}'.format(BINSTAR_CHANNEL, pkg))
                if pkg == 'ocgis':
                    env.worker.run('python -c "from ocgis.test import run_no_esmf;run_no_esmf()"')
                elif pkg == 'ocgis-esmf':
                    env.worker.run('python -c "from ocgis.test import run_all;run()"')
                elif pkg == 'esmpy':
                    cmd = "nosetests -vs -a '!slow,!data' {0}".format('ESMF')
                    env.worker.run(cmd)
                else:
                    raise NotImplementedError(pkg)
        finally:
            if remove_env == 'true':
                env.worker.run('rm -r {0}'.format(os.path.join(CONDA_ENVS, n)))
    LOG.info('all tests pass')


@task
def test_conda_ocgis():
    run_bash_script('test-conda-ocgis.sh')


@task
def test_conda_ocgis_esmf():
    run_bash_script('test-conda-ocgis-esmf.sh')