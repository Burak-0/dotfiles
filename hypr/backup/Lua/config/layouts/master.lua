local alias = require("config.alias")

-- Workspace Navigation
hl.bind(
	alias.mainMod .. " + period",
	hl.dsp.focus({ workspace = "e+1" }),
	{ description = "Scroll through workspaces incrementally" }
)
hl.bind(
	alias.mainMod .. " + comma",
	hl.dsp.focus({ workspace = "e-1" }),
	{ description = "Scroll through workspaces decrementally" }
)

hl.bind(
	alias.mainMod .. " + mouse_down",
	hl.dsp.focus({ workspace = "e+1" }),
	{ description = "Scroll through workspaces incrementally" }
)
hl.bind(
	alias.mainMod .. " + mouse_up",
	hl.dsp.focus({ workspace = "e-1" }),
	{ description = "Scroll through workspaces decrementally" }
)
hl.bind(
	alias.mainMod .. " + slash",
	hl.dsp.focus({ workspace = "previous" }),
	{ description = "Switch to the previous workspace" }
)

-- Window Navigation
hl.bind(alias.mainMod .. " + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus to the left" })
hl.bind(alias.mainMod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus to the right" })
hl.bind(alias.mainMod .. " + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus upwards" })
hl.bind(alias.mainMod .. " + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus downwards" })

-- Window Actions
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + right",
	hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
	{ description = "Resize to the right", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + left",
	hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
	{ description = "Resize to the left", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + up",
	hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
	{ description = "Resize upwards", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + down",
	hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
	{ description = "Resize downwards", repeating = true }
)

hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + l",
	hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
	{ description = "Resize to the right", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + h",
	hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
	{ description = "Resize to the left", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + k",
	hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
	{ description = "Resize upwards", repeating = true }
)
hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + j",
	hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
	{ description = "Resize downwards", repeating = true }
)

-- Workspace Actions
for i = 1, 10 do
	local key = i % 10
	hl.bind(
		alias.mainMod .. " + CTRL + " .. key,
		hl.dsp.window.move({ workspace = i, follow = true }),
		{ description = "Move window and switch to workspace " .. i }
	)
end

hl.bind(
	alias.mainMod .. " + CTRL + left",
	hl.dsp.window.move({ workspace = "-1", follow = true }),
	{ description = "Move window and switch to the next workspace" }
)
hl.bind(
	alias.mainMod .. " + CTRL + right",
	hl.dsp.window.move({ workspace = "+1", follow = true }),
	{ description = "Move window and switch to the previous workspace" }
)

-- Gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
