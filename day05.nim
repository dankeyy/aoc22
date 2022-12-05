import std/sugar
import std/strutils
import std/re
import std/algorithm
import std/sequtils

iterator parseCrate(line: string): char =
  var i = 1
  while i < len(line):
    yield line[i]
    i += 4


proc parseFile (path: string): (seq[string], seq[string]) =
  let f = open(path)
  defer: f.close()
  let contents = f.readAll().split("\n\n").map(text => text.splitlines())
  return (contents[0], contents[1])


proc stacksFromLayout(crateLayout: seq[string]): seq[seq[char]] =
  var stacks = newSeqWith(10, newSeq[char]())
  let lines = reversed(crateLayout)
  let crates = lines[1..len(lines) - 1]
  var i: int

  for line in crates:
    i = 1
    for crate in parseCrate(line):
      if crate != ' ':
          stacks[i].add(crate)
      i += 1
  return stacks


proc updatedStacksByInstructions(
  stacks: var seq[seq[char]],
  instructions: seq[string],
  part: int
): seq[seq[char]] =

  var ops: seq[int]
  var amount, source, dest, stackIndex: int

  for line in instructions:
    if len(line) > 0:
      ops = findAll(line, re"\d+").map(d => parseInt(d))
      amount = ops[0]
      source = ops[1]
      dest   = ops[2]

      if part == 2:
        for _ in 1..amount:
          stacks[0].add(stacks[source].pop())
        stackIndex = 0

      else:
        stackIndex = source

      for _ in 1..amount:
        stacks[dest].add(stacks[stackIndex].pop())

  return stacks


proc stringFromStackTops(stacks: var seq[seq[char]]): string =
  var letters: string
  var length:  int

  for i in 1..<len(stacks):
    length = len(stacks[i])
    if length == 0:
      break
    letters &= stacks[i][length - 1]
  return letters


let (crateLayout, instructions) = parseFile("05.txt")
var p1stacks = stacksFromLayout(crateLayout)
var p2stacks = deepCopy(p1stacks)

# part 1
p1stacks = updatedStacksByInstructions(p1stacks, instructions, 1)
echo stringFromStackTops(p1stacks)

# part 2
p2stacks = updatedStacksByInstructions(p2stacks, instructions, 2)
echo stringFromStackTops(p2stacks)
