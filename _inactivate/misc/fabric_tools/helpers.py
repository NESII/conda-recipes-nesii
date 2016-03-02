from fabric.state import env
from workers import AbstractWorker


def fcmd(name, cmd):
    return name(tfs(cmd))


def get_ssh_cmd(key_filename, user, dns):
    msg = 'ssh -i {0} {1}@{2}'.format(key_filename, user, dns)
    return msg


def get_worker(name):
    for Sub in itersubclasses(AbstractWorker):
        if Sub.name == name:
            return Sub


def git_checkout(branch):
    env.worker.run('git pull')
    env.worker.run('git checkout {0}'.format(branch))
    env.worker.run('git pull')


def itersubclasses(cls, _seen=None):
    """
    itersubclasses(cls)

    Generator over all subclasses of a given class, in depth first order.

    >>> list(itersubclasses(int)) == [bool]
    True
    >>> class A(object): pass
    >>> class B(A): pass
    >>> class C(A): pass
    >>> class D(B,C): pass
    >>> class E(D): pass
    >>>
    >>> for cls in itersubclasses(A):
    ...     print(cls.__name__)
    B
    D
    E
    C
    >>> # get ALL (new-style) classes currently defined
    >>> [cls.__name__ for cls in itersubclasses(object)] #doctest: +ELLIPSIS
    ['type', ...'tuple', ...]
    """

    if not isinstance(cls, type):
        raise TypeError('itersubclasses must be called with '
                        'new-style classes, not %.100r' % cls)
    if _seen is None: _seen = set()
    try:
        subs = cls.__subclasses__()
    except TypeError: # fails only when cls is type
        subs = cls.__subclasses__(cls)
    for sub in subs:
        if sub not in _seen:
            _seen.add(sub)
            yield sub
            for sub in itersubclasses(sub, _seen):
                yield sub


def tfs(sequence):
    return ' '.join(sequence)


class GitExists(Exception):
    pass