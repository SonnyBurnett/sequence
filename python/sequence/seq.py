
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
            print("unexpected error")
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
        #print(x)
        if check_equal_list(x):
            return True
        if len(lissie[-1]) == 2:
            if int(abs(lissie[-1][0] - lissie[-1][1])) == 1:
                #print("uitkomst 1", lissie[-1])
                return True
    return False


#lijst = [-14, -25, -31, -31, -24]
#lijst = [22, 27, 29, 28]
#[3, 12, 6, 24, 12]

print("Welkom bij de nummer kraker!")
print("type een getal en druk op <enter>")
print("na laatste getal, type alleen een <enter>")
print("stop het programma door een reeks te starten met een <enter>")
print("Veel plezier en succes!")
print()

while True:
    lijst = []
    val = "xxx"
    while val != "":
        val = input("Getal: ")
        if val != "":
            lijst.append(int(val))
    if len(lijst) < 1:
        break

    solution_found = False

    total_list = ["mmm", "mmd", "mdm", "mdd", "dmm", "dmd", "ddm", "ddd"]
    for a in total_list:

        p = a
        a = fill_pattern(lijst, p)
        if is_good_list(a):
            if len(a[-1]) == 2:
                if abs(a[-1][0]) == abs(a[-1][1]):
                    a[-1].append(a[-1][0])
                else:
                    a[-1].append(a[-1][1] - (a[-1][0]-a[-1][1]))
            else:
                a[-1].append(a[-1][1])
            t = len(a)-2

            while t >= 0:

                if p[t] == "m":
                    a[t].append(a[t + 1][-1] + a[t][-1])
                else:
                    a[t].append(a[t + 1][-1] * a[t][-1])

                t = t - 1

            #for q in a:
            #    print(q)

            print("Oplossing:", int(a[0][-1]))
            print()
            solution_found = True
            break
    if solution_found == False:
        print("Sorry ik weet het niet!")
        print()

# 19, 34, 94, 274
# 634

