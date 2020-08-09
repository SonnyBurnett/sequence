
def next_min(lijst):
    n1 = []
    teller = 0
    while teller < len(lijst) - 1:
        n1.append(lijst[teller + 1] - lijst[teller])
        teller += 1
    return n1


def next_deel(n):
    n1 = []
    teller = 0
    while teller < len(n) - 1:
        if n[teller] != 0:
            n1.append(n[teller + 1] / n[teller])
        else:
            return []
        teller += 1
    return n1


def fill_pattern(start_list, patt):
    patt_list = []
    patt_list.append(start_list)
    teller = 0
    for c in patt:
        if c == "m":
            #print("m")
            patt_list.append(next_min(patt_list[teller]))
        elif c == "d":
            #print("d")
            patt_list.append(next_deel(patt_list[teller]))
        else:
            print("niks")
        teller+=1
        if len(patt_list[-1]) < 3:
            break
        if check_equal_list(patt_list[-1]) == True:
            break

    return patt_list


def check_equal_list(listje):
    if len(set([abs(x) for x in listje])) == 1:
        return True
    return False


def is_good_list(lissie):
    for x in lissie:
        print(x)
        if check_equal_list(x):
            return True
    return False


#lijst = [-14, -25, -31, -31, -24]
#lijst = [22, 27, 29, 28]
#[3, 12, 6, 24, 12]

while True:
    lijst = []
    val = "xxx"
    while val != "":
        val = input("Enter your value: ")
        if val != "":
            lijst.append(int(val))
    if len(lijst) < 1:
        break

    total_list = ["mmm", "mmd", "mdm", "mdd", "dmm", "dmd", "ddm", "ddd"]
    for a in total_list:

        p = a
        a = fill_pattern(lijst, p)
        if is_good_list(a):
            if len(a[-1]) == 2:
                a[-1].append(a[-1][0])
            else:
                a[-1].append(a[-1][1])
            t = len(a)-2

            while t >= 0:

                if p[t] == "m":
                    a[t].append(a[t + 1][-1] + a[t][-1])
                else:
                    a[t].append(a[t + 1][-1] * a[t][-1])

                t = t - 1
            print(int(a[0][-1]))
            break

# 19, 34, 94, 274
# 634