def overlapping(pairs, part1=False):
    for pair in pairs:
        a, b, c, d = pair

        yield (
            (a >= c and b <= d) or (c >= a and d <= b)
            if part1
            else
            ((a <= c <= b) or (c <= a <= d))
        )


test = open('04.txt').read().splitlines()
pairs = [
    [int(x) for s in l for x in s.split('-')]
     for l in (line.split(',') for line in test)
]

print(sum(overlapping(pairs, part1=True)))
print(sum(overlapping(pairs, part1=False)))
