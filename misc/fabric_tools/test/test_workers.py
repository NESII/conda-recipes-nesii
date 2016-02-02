from base import AbstractCondaESMFTest
from fabric_tools.workers import AbstractWorker


class FooAbstractWorker(AbstractWorker):
    ip_address = 'fake'
    name = 'foo_abstract_worker'
    _default_git_path = '~/not_real'


class TestAbstractWorker(AbstractCondaESMFTest):

    def test_init(self):
        faw = FooAbstractWorker()
        self.assertEqual(faw.path_git, FooAbstractWorker._default_git_path)
        faw = FooAbstractWorker(path_git='~/nowhere')
        self.assertEqual(faw.path_git, '~/nowhere')
