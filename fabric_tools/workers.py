from abc import ABCMeta, abstractproperty, abstractmethod
from fabric.context_managers import cd, lcd, settings
from fabric.operations import sudo, run, local, os
import time
from settings import *
from fabric.state import env


class AbstractWorker(object):
    __metaclass__ = ABCMeta

    user = None
    _default_git_path = '~/git'

    def __init__(self, path_git=None):
        self.path_git = path_git or self._default_git_path

        env.worker = self
        env.hosts = [self.ip_address]
        env.connection_attempts = 10
        if self.user is not None:
            env.user = self.user

    @abstractproperty
    def ip_address(self):
        return '56.90.78.90'

    @classmethod
    def launch(cls):
        pass

    @abstractproperty
    def name(self):
        return 'centos6-worker'

    def packages_to_install(self):
        return []

    def password(self):
        """The password for the server."""

    @classmethod
    def cd(cls, *args, **kwargs):
        return cd(*args, **kwargs)

    @classmethod
    def get_git_path(cls, git_url):
        name = os.path.split(git_url)[1]
        return os.path.join(cls._default_git_path, name)

    @classmethod
    def run(cls, *args, **kwargs):
        return run(*args, **kwargs)

    @classmethod
    def sudo(cls, *args, **kwargs):
        return sudo(*args, **kwargs)

    def system_install_packages(self):
        raise NotImplementedError

    def system_update(self):
        raise NotImplementedError

    def terminate(self):
        pass


class AbstractWorkerAWS(AbstractWorker):
    __metaclass__ = ABCMeta

    try:
        from saws import AwsManager
    except ImportError:
        pass
    else:
        manager = AwsManager()
        aws_key_path = manager.conf.aws_key_path
    password = None

    def __init__(self, *args, **kwargs):
        AbstractWorker.__init__(self, *args, **kwargs)
        env.key_filename = self.aws_key_path
        assert self.instance is not None

    @property
    def ip_address(self):
        self.instance = self.manager.get_instance_by_name(self.aws_name)
        return self.instance.ip_address

    @abstractproperty
    def aws_ami(self):
        return 'ami-65625655'

    @abstractproperty
    def aws_name(self):
        return 'conda-builder'

    @abstractproperty
    def aws_type(self):
        return 't2.micro'

    @abstractproperty
    def server_dir_data(self):
        return '/home/me/data'

    @classmethod
    def ebs_mount(cls):
        cmd = 'mount {0} {1}'.format(AWS_EBS_MOUNT_NAME, cls.server_dir_data)
        sudo(cmd)

    @classmethod
    def launch(cls):
        from helpers import get_ssh_cmd

        LOG.info('launching aws instance')
        if AWS_EBS_SHOULD_MOUNT:
            ebs_snapshot_id = AWS_EBS_SNAPSHOT_ID
        else:
            ebs_snapshot_id = None

        i = cls.manager.launch_new_instance(cls.aws_name, image_id=cls.aws_ami, instance_type=cls.aws_type,
                                            ebs_snapshot_id=ebs_snapshot_id)
        if AWS_EBS_SHOULD_MOUNT:
            with settings(host_string=i.ip_address, connection_attempts=10, user=cls.user):
                LOG.info('attaching volume')
                cls.run('mkdir -p {0}'.format(cls.server_dir_data))
                LOG.info('sleeping')
                time.sleep(5)
                cls.ebs_mount()
        LOG.info('instance launched')
        LOG.info(get_ssh_cmd(cls.aws_key_path, cls.user, i.ip_address))

    def terminate(self):
        self.instance.terminate()
        LOG.info('instance terminated')

class BuilderCentos6(AbstractWorkerAWS):
    aws_name = AWS_NAME_BUILD
    name = 'build-centos6-aws'
    aws_ami = 'ami-4fb7b07f'
    aws_type = AWS_TYPE_BUILD
    user = 'root'
    server_dir_data = '/root/data'
    packages_to_install = ['wget', 'bzip2', 'git', 'gcc', 'gcc-c++', 'm4', 'autoconf', 'libtool', 'expat-devel',
                           'texinfo', 'patch', 'unzip', 'gcc-gfortran']

    def system_install_packages(self):
        for pkg in self.packages_to_install:
            sudo('yum install -y {0}'.format(pkg))

    def system_update(self):
        sudo('yum makecache fast')
        sudo('yum update -y')


class BuilderCentos7(BuilderCentos6):
    name = 'build-centos7-aws'
    aws_ami = 'ami-79ebc849'
    user = 'centos'
    server_dir_data = '/home/centos/data'


class InstallerUbuntu(AbstractWorkerAWS):
    aws_name = AWS_NAME_TEST
    name = 'test-ubuntu-aws'
    aws_ami = 'ami-3bb8820b'
    aws_type = AWS_TYPE_TEST
    user = 'ubuntu'
    server_dir_data = '/home/ubuntu/data'
    packages_to_install = []

    def system_install_packages(self):
        for pkg in self.packages_to_install:
            sudo('apt-get install -y {0}'.format(pkg))

    def system_update(self):
        sudo('apt-get update')
        sudo('apt-get upgrade -y')


class BuilderEris(AbstractWorker):
    name = 'build-osx-eris'
    ip_address = '172.24.254.122'
    user = 'ryan.okuinghttons'
    _default_git_path = '~/sandbox'


class BuilderUbuntu(InstallerUbuntu):
    aws_ami = 'ami-a12d0b91'
    name = 'build-ubuntu-aws'
    packages_to_install = ['dh-autoreconf', 'texinfo', 'libexpat1-dev']


class BuilderLocalhost(AbstractWorker):
    ip_address = 'localhost'
    name = 'localhost'
    packages_to_install = []
    password = None

    @classmethod
    def cd(cls, *args, **kwargs):
        return lcd(*args, **kwargs)

    @classmethod
    def run(cls, *args, **kwargs):
        return local(*args, **kwargs)

    @classmethod
    def sudo(cls, *args, **kwargs):
        args = list(args)
        args[0] = 'sudo ' + args[0]
        return local(*args, **kwargs)

    def system_install_packages(self):
        raise NotImplementedError

    def system_update(self):
        raise NotImplementedError


class BuilderHaumea(BuilderLocalhost):
    name = 'build-osx-haumea'
    _default_git_path = '~/src'


class BuilderHaumea(BuilderLocalhost):
    name = 'localhost-bwk'
    _default_git_path = '~/l/project'
