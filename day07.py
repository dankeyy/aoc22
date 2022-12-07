cwd  = []
seen = []
_, *data = map(str.splitlines, open("07.txt").read().split("$ "))

for command, *rest in data:
    if rest: # ls. could also just check eq on command
        for ls_output in rest:
            size_or_dir, _name = ls_output.split() # e.g `8033020 d.log` or `dir stuff` (file/ dir names don't matter)
            if size_or_dir != 'dir':
                for i in range(len(cwd)):
                    cwd[i] += int(size_or_dir) # file here means +file-size for all nodes up the tree
    else: # cd
        _cd, dest = command.split() # `cd /` -> dest='/'
        if dest == '..':
            seen.append(cwd.pop())
        else:
            cwd.append(0)
seen.extend(reversed(cwd))

print(sum(x for x in seen if x <= 100000)) # p1

outermost = seen[-1]
leftover_space = 70000000 - outermost
needed_space = 30000000 - leftover_space
print(next(x for x in seen if x >= needed_space)) # p2
