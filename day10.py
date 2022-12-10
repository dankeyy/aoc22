lines = (l.partition(' ') for l in reversed(open('10.txt').read().splitlines()))
ops = [int(n or 0) for _op, _, n in lines]
strengh = crt_pos = intbuf = 0
cycles = x = 1
crt = ['.'] * 40

while ops:
    if (cycles - 20) % 40 == 0:
        strengh += cycles * x

    elif cycles % 40 == 0:
        print(*crt, sep='')
        crt = ['.'] * 40

    pos = cycles % 40 -1
    if x - 1 <= pos <= x + 1: # in sprite
        crt[pos] = '#'

    if intbuf:
        x += intbuf
        intbuf = 0
    else:
        intbuf = ops.pop()
    cycles += 1

print(strengh)
