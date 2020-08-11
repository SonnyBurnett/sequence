#
# Guess the next number in a sequence
#
# (c) Taco Bakker
#

from itertools import permutations


def get_next_divisor(input_list):
    return [input_list[t + 1] / input_list[t] for t in range(0, len(input_list)-1) if input_list[t] != 0]


def get_next_minus(input_list):
    return [input_list[t + 1] - input_list[t] for t in range(0, len(input_list)-1)]


def get_next_pattern(input_list, action):
    return_list = input_list
    if action == "m":
        return_list.append(get_next_minus(return_list[-1]))
    else:
        return_list.append(get_next_divisor(return_list[-1]))
    return return_list


def get_all_patterns(start_list, patt_list):
    return_list = start_list
    for c in patt_list:
        get_next_pattern(start_list, c)
        if len(return_list[-1]) < 3 or check_equal_values_list(return_list[-1]):
            break
    return return_list


def check_equal_values_list(input_list):
    if len(set([abs(x) for x in input_list])) == 1:
        return True
    return False


def len_two_checker(input_list):
    if len(input_list[-1]) == 2 and int(abs(input_list[-1][0] - input_list[-1][1])) == 1:
        return True
    return False


def is_good_pattern(input_list):
    if True in [check_equal_values_list(x) for x in input_list]:
        return True
    return len_two_checker(input_list)


def get_user_numbers():
    return_list = []
    val = "xxx"
    while val != "":
        val = input("Getal: ")
        if val != "":
            return_list.append(int(val))
    return return_list


def make_pattern_list():
    return ["mmm", "mmd", "mdm", "mdd", "dmm", "dmd", "ddm", "ddd"]


def add_first_number(input_list):
    if len(input_list[-1]) == 2:
        if abs(input_list[-1][0]) == abs(input_list[-1][1]):
            return input_list[-1][0]
        else:
            return input_list[-1][1] - (input_list[-1][0] - input_list[-1][1])
    else:
        return input_list[-1][1]


def append_number(a, b, operation):
    if operation == "m":
        return a + b
    else:
        return a * b


def add_rest_of_numbers(input_list, pattern):
    output_list = input_list
    t = len(output_list) - 2
    while t >= 0:
        output_list[t].append(append_number(output_list[t+1][-1], output_list[t][-1], pattern[t]))
        t = t - 1
    return output_list


def get_solution(input_list):
    return int(input_list[0][-1])


def main():
    user_list = get_user_numbers()
    pattern_list = make_pattern_list()
    solution_found = False
    for p in pattern_list:
        a = get_all_patterns(user_list, p)
        if is_good_pattern(a):
            c = add_first_number(a)
            d = add_rest_of_numbers(c)
            e = get_solution(d)
            print(e)
            solution_found = True
            break
    if not solution_found:
        print("Sorry I do not know the answer!")


if __name__ == '__main__':
    main()
