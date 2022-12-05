import std/enumerate
import std/sugar
import std/strutils
import std/re
import std/algorithm
import std/sequtils

proc parseFile(path: string): (seq[string], seq[string]) =
  let f = open(path)
  let contents = f.readAll().split("\n\n").map(text => text.splitlines())
  return (contents[0], contents[1])


proc stacksFromLayout(crateLayout: seq[string]): seq[seq[char]] =
  var stacks = newSeqWith(10, newSeq[char]())
  let lines = reversed(crateLayout)
  let crates = lines[1..^1]

  for line in crates:
    for i, x in enumerate(1, countup(1, line.len-1, 4)):
      if line[x] != ' ':
          stacks[i].add(line[x])
  return stacks


proc stringFromStackTops(stacks: var seq[seq[char]], instructions: seq[string], part: int): string =
  var ops: seq[int]
  var letters: string
  var amount, source, dest, stackIndex, sourceSize: int

  # updating stack by instructions
  for line in instructions:
    if line.len > 0:
      ops = findAll(line, re"\d+").map(parseInt)
      amount = ops[0]
      source = ops[1]
      dest   = ops[2]

      if part == 2:
        sourceSize = stacks[source].len
        for _ in 1..amount:
          stacks[0].add(stacks[source].pop())
        stackIndex = 0
      else:
        stackIndex = source

      for _ in 1..amount:
        stacks[dest].add(stacks[stackIndex].pop())

  # concatenating letters from top of the stacks
  for i in 1..<stacks.len:
    letters &= stacks[i][^1]
  return letters


let (crateLayout, instructions) = parseFile("05.txt")
var p1stacks = stacksFromLayout(crateLayout)
var p2stacks = deepCopy(p1stacks)

# part 1
echo stringFromStackTops(p1stacks, instructions, 1)
# part 2
echo stringFromStackTops(p2stacks, instructions, 2)
