import numpy as np
import itertools


def get_divisors(num):
    return [x for x in range(1, int(num/2)+1) if num % x == 0]


def get_prod_sum(k, n):
    return [p for p in itertools.combinations_with_replacement(get_divisors(n), k) if sum(p) == n and np.prod(p) == n]


def get_mutations(k, n):
    return [p for p in itertools.combinations_with_replacement(get_divisors(n), k)]


def get_first_mutation(k, n):
    for combination in itertools.combinations_with_replacement(get_divisors(n), k):
        if sum(combination) == n and np.prod(combination) == n:
            return combination
    return []


def get_all_minimum_prod_sum(m):
    total_list = []
    for k in range(2, m+1):
        print(k)
        counter = k
        while len(get_first_mutation(k, counter)) < 1:
            counter += 1
        total_list.append(counter)
    return total_list


print(sum(set(get_all_minimum_prod_sum(120))))
