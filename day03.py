from typing import Iterable
from functools import reduce


def prioritized(x: chr) -> int:
    return ord(x) - (38 if x.isupper() else 96)


def uniques(xs: Iterable[str]) -> set:
    return reduce(set.intersection, map(set, xs)).pop()


def bisected(line: str) -> tuple[str]:
    half = len(line) // 2
    return line[:half], line[half:]


def p1(text: list[str]) -> int:
    return sum(prioritized(uniques(bisected(line))) for line in text)


def p2(text: list[str]) -> int:
    letters = (uniques(text[i:i+3]) for i in range(0, len(text), 3))
    priorities = map(prioritized, letters)
    return sum(priorities)


f = open('3.txt').read().splitlines()
print(p1(f))
print(p2(f))
