def solve(packet: str, w: int):
    return next (i for i in range(w, len(p)) if len({*p[i - w: i]}) == w)

p = open("06.txt").read()
print(solve(p, 4))  # p1
print(solve(p, 14)) # p2
