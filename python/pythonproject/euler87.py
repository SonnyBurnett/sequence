import numpy as np
import sympy


MAXNUM = 50000000


def make_nums(max,num):
    numbers = []
    counter = 2
    result = np.power(counter, num)
    while result < max:
        numbers.append(result)
        counter += 1
        if sympy.isprime(counter):
            result = np.power(counter, num)
    return numbers


def sum_em_all(l1,l2,l3, max):
    sums = []
    for a in l1:
        for b in l2:
            for c in l3:
                if a+b+c < max:
                    sums.append(a+b+c)
    return sums


print(len(sorted(set(sum_em_all(make_nums(MAXNUM, 2), make_nums(MAXNUM, 3), make_nums(MAXNUM,4), MAXNUM)))))