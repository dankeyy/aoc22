xs ← 1+ > '0'-˜ •file.Lines "08.txt"

M ← >⟜(»⌈`)
•Show +´ ⥊ (M⌾(⌽⍉) ∨ M⌾⌽ ∨ M⌾⍉ ∨ M) xs # p1

•Show ⌈´ ⥊ xs ⊸{
      m 𝕊 ⟨x,y⟩:
      elem ← ⟨x,y⟩ ⊑ m
      ⟨ up,   left ⟩  ← ⟨ ⌽x↑y⊏˘m, ⌽y↑x⊏m ⟩
      ⟨ down, right ⟩ ← ⟨ 1↓x↓y⊏˘m, 1↓y↓x⊏m ⟩
      ×´ {+´ ∧` 1» elem > 𝕩}¨⟨up, left, down, right⟩
} ¨↕≢xs # p2
