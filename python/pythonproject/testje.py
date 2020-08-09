
div_list = []


def init_array(limit):
    return [1] * limit


def set_divisor_sums(limit, dl):
    for i in range(2, limit // 2):
        for j in range(2 * i, limit, i):
            dl[j] += i
    return dl


def find_next(n):
    try:
        x = div_list[n]
    except:
        x = -1
    return x


def good_chain(c):
    if c[0] == c[-1]:
        return c
    else:
        return []


def find_chain(n):
    chain = []
    while True:
        chain.append(n)
        n = find_next(n)
        if n in chain or n < 0:
            chain.append(n)
            break
    return good_chain(chain)


def find_longest(m):
    longeste = 0
    for x in range(2, m):
        res_list = find_chain(x)
        if len(res_list) > longeste:
            print(len(res_list), min(res_list), res_list)
            longeste = len(res_list)


limitos = 1000000
div_list = set_divisor_sums(limitos, init_array(limitos))
find_longest(limitos)

