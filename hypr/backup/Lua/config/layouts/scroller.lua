local alias = require("config.alias")

-- Window Navigation
hl.bind(
	alias.mainMod .. " + apostrophe",
	hl.dsp.exec_cmd(alias.configPath .. "/scripts/scrollerfocus.sh"),
	{ description = "Focus scroller window" }
)
hl.bind(alias.mainMod .. " + comma", hl.dsp.layout("focus l"), { description = "Focus left column" })
hl.bind(alias.mainMod .. " + period", hl.dsp.layout("focus r"), { description = "Focus right column" })

hl.bind(alias.mainMod .. " + left", hl.dsp.layout("focus l"), { description = "Focus left" })
hl.bind(alias.mainMod .. " + right", hl.dsp.layout("focus r"), { description = "Focus right" })
hl.bind(alias.mainMod .. " + up", hl.dsp.layout("focus u"), { description = "Focus up" })
hl.bind(alias.mainMod .. " + down", hl.dsp.layout("focus d"), { description = "Focus down" })

hl.bind(alias.mainMod .. " + mouse_down", hl.dsp.layout("move +col"), { description = "Move to next column" })
hl.bind(alias.mainMod .. " + mouse_up", hl.dsp.layout("move -col"), { description = "Move to previous column" })

-- Window Actions
hl.bind(
	alias.mainMod .. " + SHIFT + period",
	hl.dsp.window.move({ direction = "r" }),
	{ description = "Move window right" }
)
hl.bind(
	alias.mainMod .. " + SHIFT + comma",
	hl.dsp.window.move({ direction = "l" }),
	{ description = "Move window left" }
)

hl.bind(alias.mainMod .. " + CTRL + comma", hl.dsp.layout("swapcol l"), { description = "Swap column left" })
hl.bind(alias.mainMod .. " + CTRL + period", hl.dsp.layout("swapcol r"), { description = "Swap column right" })

hl.bind(alias.mainMod .. " + slash", hl.dsp.layout("expel"), { description = "Expel window" })
hl.bind(alias.mainMod .. " + SHIFT + slash", hl.dsp.layout("fit active"), { description = "Fit active window" })
hl.bind(alias.mainMod .. " + CTRL + slash", hl.dsp.layout("fit visible"), { description = "Fit visible windows" })
hl.bind(alias.mainMod .. " + SHIFT + CTRL + slash", hl.dsp.layout("fit all"), { description = "Fit all windows" })

hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + right",
	hl.dsp.layout("colresize +conf"),
	{ description = "Resize column right", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + left",
	hl.dsp.layout("colresize -conf"),
	{ description = "Resize column left", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + period",
	hl.dsp.layout("colresize +conf"),
	{ description = "Resize column right", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + comma",
	hl.dsp.layout("colresize -conf"),
	{ description = "Resize column left", repeating = true }
)

-- Workspace Actions
for i = 1, 10 do
	local key = i % 10
	hl.bind(
		alias.mainMod .. " + CTRL + " .. key,
		hl.dsp.window.move({ workspace = i, follow = true }),
		{ description = "Move window to workspace " .. i }
	)
end

-- Gestures
hl.gesture({
	fingers = 3,
	direction = "right",
	action = function()
		hl.dispatch(hl.dsp.layout("focus r"))
	end,
})

hl.gesture({
	fingers = 3,
	direction = "left",
	action = function()
		hl.dispatch(hl.dsp.layout("focus l"))
	end,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	mods = alias.mainMod,
	action = "workspace",
})
