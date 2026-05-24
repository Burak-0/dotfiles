hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.1 } } })
hl.curve("overshot2", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })
hl.curve("overshot3", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1 } } })
hl.curve("spring", { type = "bezier", points = { { 0.18, 0.89 }, { 0.32, 1.28 } } })

hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" }) -- 1, 10
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "spring", style = "popin 90%" }) -- popin 90%
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "overshot2", style = "gnomed" }) -- gnomed
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "overshot2", style = "slide" }) -- slide
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "overshot3" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot2", style = "slidefade 30%" })

hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
