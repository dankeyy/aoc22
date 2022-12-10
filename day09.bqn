ToInt ← 10⊸×⊸+˜´∘⌽-⟜'0'
ops ← {⟨1↑𝕩, ToInt(2↓𝕩)⟩}¨ •FLines "09.txt"

Directions ← {
    "D": ⟨ 0, ¯1 ⟩;
    "U": ⟨ 0,  1 ⟩;
    "L": ⟨¯1,  0 ⟩;
    "R": ⟨ 1,  0 ⟩
}

heads ← +` ∾ { ⟨d, n⟩: n / ⋈ Directions d } ¨ ops

TailTrails ← {
     𝕨 {
        tail𝕊head:
        delta ← head - tail
        {
            ∧´ (2 > |delta)
            ? tail
            ; tail + ×delta  # using × as signum
        }
    }` 𝕩
}

•Show ≠⍷(<0‿0) TailTrails     heads  # p1
•Show ≠⍷(<0‿0) TailTrails ⍟9 heads  # p2
