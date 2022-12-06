def solve(packet: str, w: int) -> int:
    return next(i for i in range(w, len(p)) if len({*p[i - w: i]}) == w)

packet = open("06.txt").read()
print(solve(packet, 4))  # p1
print(solve(packet, 14)) # p2
