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
    if action == "m":
        return get_next_minus(input_list)
    else:
        return get_next_divisor(input_list)


def calculate_pattern_lists(start_list, patt_list):
    return_lists = []
    return_lists.append(start_list)
    for c in patt_list:
        return_lists.append(get_next_pattern(return_lists[-1], c))
        if len(return_lists[-1]) < 3 or check_equal_values_list(return_lists[-1]):
            break
    return return_lists


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


def calculate_first_number(input_list):
    if len(input_list) == 2:
        if abs(input_list[0]) == abs(input_list[1]):
            return input_list[0]
        else:
            return input_list[1] - (input_list[0] - input_list[1])
    else:
        return input_list[1]


def add_first_number(input_lists):
    output_lists = input_lists
    output_lists[-1].append(calculate_first_number(output_lists[-1]))
    return output_lists


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


def find_solution(user_list):
    pattern_list = make_pattern_list()
    solution_found = False
    for p in pattern_list:
        a = calculate_pattern_lists(user_list, p)
        if is_good_pattern(a):
            print("solution:", get_solution(add_rest_of_numbers(add_first_number(a), p)))
            solution_found = True
            break
    if not solution_found:
        print("Sorry I do not know the answer!")


def main():
    while True:
        user_list = get_user_numbers()
        if len(user_list) < 1:
            break
        else:
            find_solution(user_list)


if __name__ == '__main__':
    main()
