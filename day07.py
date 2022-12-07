cwd  = []
seen = []
_, *data = map(str.splitlines, open("07test.txt").read().split("$ "))

for instruction in data:
    command, *rest = instruction

    if rest: # ls
        for f in rest:
            n, _ = f.split() # e.g 29116 f or `dir bla` (file/ dir names don't matter)
            if n != 'dir':
                for i in range(len(cwd)):
                    cwd[i] += int(n)
    else: # cd, could also just check eq on command
        _, dest = command.split() # cd / -> dest='/'
        if dest == '..':
            seen.append(cwd.pop())
        else:
            cwd.append(0)
seen.extend(reversed(cwd))

print(sum(x for x in seen if x <= 100000)) # p1
#                total    - outermost
leftover_space = 70000000 - seen[-1]
needed_space = 30000000 - leftover_space
print(next(x for x in seen if x >= needed_space)) # p2
