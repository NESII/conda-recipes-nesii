from fabric.context_managers import shell_env, prefix, settings
from fabric.contrib.files import append
from fabric.decorators import task
from fabric.operations import put, os
from fabric.state import env
from helpers import itersubclasses

from helpers import git_checkout, GitExists, get_worker
from settings import *


@task
def conda_server_login():
    login = env.worker.run('conda server whoami')
    if 'Anonymous User' in login:
        LOG.info('not logged into conda server. logging in.')
        env.worker.run('conda server login')


@task
def conda_server_channel_show(channel):
    l = env.worker.run('conda server channel --show {} -o nesii'.format(channel))
    l = l.split('+')
    l = [l.strip() for l in l][1:]
    LOG.info(l)
    return l


@task
def conda_server_remove_all(channel):
    l = conda_server_channel_show(channel)
    for p in l:
        conda_server_remove(p)


@task
def conda_server_remove(package):
    cmd = 'conda server remove --force {}'.format(package)
    env.worker.run(cmd)


@task
def conda_server_upload(package_name, channel='dev', user=None):
    """
    Upload packages to Anaconda server.

    :param str channel: The name of the target channel for upload.
    """
    # tdk: doc
    bpath = os.path.join(env.worker.get_git_path(GIT_REPO['url']), package_name)
    with env.worker.cd(bpath):
        path_cmd = '`{0} build --output .`'.format(CONDA)
        cmd = 'conda server upload --force -c {channel} {path}'.format(binstar=BINSTAR, channel=channel, path=path_cmd)
        if user is not None:
            cmd += ' -u {0}'.format(user)
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
def set_worker(name='localhost'):
    """
    Set the target worker.

    :param str name_or_aspect: ``'build'``, ``'test'``, or the exact worker name.
    """

    Worker = get_worker(name)
    Worker()


@task
def an_echo():
    env.worker.sudo('echo "hello world"')
