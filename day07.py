cwd  = []
seen = []
_, *data = map(str.splitlines, open("07test.txt").read().split("$ "))

for instruction in data:
    command, *rest = instruction

    if not rest: # cd
        _, dest = command.split() # cd / -> dest='/'
        if dest == '..':
            v = cwd.pop()
            seen.append(v)
        else:
            cwd.append(0)
    else: # ls
        for f in rest:
            a, b = f.split() # e.g 29116 f
            if a != 'dir':
                for i in range(len(cwd)):
                    cwd[i] += int(a)


print(seen)
print(sum(x for x in seen if x <= 100000))
