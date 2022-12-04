chunks = open('01.txt').read().split('\n\n')
chunks = map(str.splitlines, chunks)

totals = (sum(map(int, chunk)) for chunk in chunks)
first, *rest = sorted(totals)[:-3-1:-1]

print(first)             # p1
print(first + sum(rest)) # p2
