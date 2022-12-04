def calc(my_pick, his_pick):
    a = {'X': 1, 'Y': 2, 'Z': 3}.get(my_pick)
    b = {'A': 1, 'B': 2, 'C': 3}.get(his_pick)
    a = a or b
    gap = abs(a - b)
    myscore = a

    if gap == 2:
        if a == 1:
            myscore += 6
    elif gap == 1:
        if (a, b) in ((2, 1), (3, 2)):
            myscore += 6
    else:
        myscore += 3

    return myscore


lose = {'A': 'Z', 'B': 'X', 'C': 'Y'}
win  = {'A': 'Y', 'B': 'Z', 'C': 'X'}
draw = {'A': 'A', 'B': 'B', 'C': 'C'}
pick = {'X': lose, 'Z': win, 'Y': draw}


test = open('02.txt').read().splitlines()
# p1
print(
    sum(calc(my_pick, his_pick) for his_pick, _, my_pick in test)
)
# p2
print(
    sum(calc(pick[end][his_pick], his_pick) for his_pick, _, end in test)
)
