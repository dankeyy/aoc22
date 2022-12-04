chunks ← •BQN¨¨ (⟨⟩⊸≢¨⊸/¨(+`⟨⟩⊸≡¨)⊸⊔) •file.Lines "01.txt"
•Show    ⌈´+´¨ chunks # p1
•Show +´3↑∨+´¨ chunks # p2
