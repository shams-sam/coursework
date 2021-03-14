import random
import string

random.seed(0)


def get_random_name(l=5):
    return "".join(
        [
            random.choice(
                string.ascii_lowercase
            ) for _ in range(l)
        ]
    )


def get_random_name_set(s=10, l=5):
    return [
        get_random_name(l)
        for _ in range(s)
    ]


def get_random_num(mn=0, mx=1000):
    return random.randint(mn, mx+1)


def get_random_num_set(s=10, mn=0, mx=1000):
    return [
        get_random_num(mn, mx)
        for _ in range(s)
    ]


def sorted_indices(seq):
    return sorted(
        range(len(seq)),
        key=seq.__getitem__)
