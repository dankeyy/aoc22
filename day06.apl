xs ← ⊃⊃⎕NGET'/home/dankey/dev/aoc22/06.txt'1
marker ← {¯1+⍵+⍵⍳⍨≢¨⍵∪/⍺}
xs marker 4  ⍝ p1
xs marker 14 ⍝ p2
