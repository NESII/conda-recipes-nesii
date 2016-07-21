from fabric.state import env
from fabric_tools.fabfile import set_worker
from fabric_tools.test.base import AbstractCondaESMFTest


class Test(AbstractCondaESMFTest):

    def test_set_worker(self):
        set_worker('localhost', path_git='~/nowhere/good')
        self.assertEqual(env.worker.path_git, '~/nowhere/good')