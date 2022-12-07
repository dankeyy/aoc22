cwd  = []
seen = []
_, *data = map(str.splitlines, open("07.txt").read().split("$ "))

for instruction in data:
    command, *rest = instruction

    if not rest: # cd, could also just check eq on command
        _, dest = command.split() # cd / -> dest='/'
        if dest == '..':
            v = cwd.pop()
            seen.append(v)
        else:
            cwd.append(0)
    else: # ls
        for f in rest:
            a, b = f.split() # e.g 29116 f or `dir bla` (file/ dir names don't matter)
            if a != 'dir':
                for i in range(len(cwd)):
                    cwd[i] += int(a)

for _ in range(len(cwd)):
    seen.append(cwd.pop())

print(sum(x for x in seen if x <= 100000)) # p1
#                total    - outermost
leftover_space = 70000000 - seen[-1]
needed_space = 30000000 - leftover_space
print(next(x for x in seen if x >= needed_space)) # p2
