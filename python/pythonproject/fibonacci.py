from functools import lru_cache


@lru_cache(maxsize=1000)
def fibonacci(n):
    if n == 1:
        return 1
    elif n == 2:
        return 1
    elif n > 2:
        return fibonacci(n-1) + fibonacci(n-2)


print(sum([fibonacci(x) for x in range(1, 40) if fibonacci(x) % 2 == 0 and fibonacci(x) < 4000000]))
