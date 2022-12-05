input ← ⊃⎕NGET'/home/dankey/dev/aoc22/03.txt'1
+/((⎕C,⊣),⎕A)⍳({(≢⍵)÷2}(⊃↓∩↑)⊣)¨input       ⍝ p1
+/((⎕C,⊣),⎕A)⍳{⊃¨⊃¨∩/¨(1 0 0⍴⍨(≢⍵))⊂⍵}input ⍝ p2
