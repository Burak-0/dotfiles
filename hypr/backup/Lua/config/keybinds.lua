local alias = require("config.alias")

-- Keybinds
hl.bind(alias.mainMod .. " + T", hl.dsp.exec_cmd(alias.browser), { description = "Open browser" })
hl.bind(alias.mainMod .. " + R", hl.dsp.exec_cmd(alias.terminal), { description = "Open terminal" })
hl.bind(alias.mainMod .. " + E", hl.dsp.exec_cmd(alias.filemanager), { description = "Open file manager" })

hl.bind(
	alias.mainMod .. " + A",
	hl.dsp.exec_cmd(alias.ipc .. " plugin:screen-toolkit annotate"),
	{ description = "Capture selected area" }
)
hl.bind(
	alias.mainMod .. " + SHIFT + A",
	hl.dsp.exec_cmd(alias.ipc .. " plugin:screen-toolkit annotateWindow"),
	{ description = "Capture active window" }
)
hl.bind(
	alias.mainMod .. " + CTRL + A",
	hl.dsp.exec_cmd(alias.ipc .. " plugin:screen-toolkit annotateFullscreen"),
	{ description = "Capture full screen" }
)

hl.bind(alias.mainMod .. " + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("ALT + f4", hl.dsp.window.kill(), { description = "Force close active window" })
hl.bind(alias.mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl dispatch exit"), { description = "Exit Hyprland" })

hl.bind(
	alias.mainMod .. " + V",
	hl.dsp.exec_cmd(alias.ipc .. " launcher clipboard"),
	{ description = "Open clipboard history" }
)
hl.bind(
	alias.mainMod .. " + I",
	hl.dsp.exec_cmd(alias.ipc .. " plugin:keybind-cheatsheet toggle"),
	{ description = "Show keybind cheatsheet" }
)
hl.bind(
	alias.mainMod .. " + SPACE",
	hl.dsp.exec_cmd(alias.ipc .. " launcher toggle"),
	{ description = "Open app launcher" }
)
hl.bind(
	alias.mainMod .. " + N",
	hl.dsp.exec_cmd(alias.ipc .. " controlCenter toggle"),
	{ description = "Toggle control center" }
)

hl.bind(alias.mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Toggle maximize" })
hl.bind(
	alias.mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen" }),
	{ description = "Toggle fullscreen" }
)
hl.bind(alias.mainMod .. " + Y", hl.dsp.window.pin(), { description = "Pin active window" })

hl.bind(alias.mainMod .. " + J", hl.dsp.layout("swapwithmaster"), { description = "Swap with master window" })
hl.bind(alias.mainMod .. " + escape", hl.dsp.exec_cmd("missioncenter"), { description = "Open system monitor" })

hl.bind(
	alias.mainMod .. " + H",
	hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }),
	{ description = "Toggle window opacity" }
)
hl.bind(
	alias.mainMod .. " + P",
	hl.dsp.exec_cmd(alias.ipc .. " plugin:screen-toolkit colorPicker"),
	{ description = "Open color picker" }
)
hl.bind(
	alias.mainMod .. " + code:47",
	hl.dsp.exec_cmd(alias.ipc .. " launcher emoji"),
	{ description = "Open emoji picker" }
)
hl.bind(
	alias.mainMod .. " + CTRL + F",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }),
	{ description = "Toggle client fullscreen state" }
)

hl.bind("ALT + TAB", function()
	hl.dispatch(hl.dsp.focus({ last = true }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { description = "Switch to last window" })

hl.bind(
	alias.mainMod .. " + M",
	hl.dsp.exec_cmd(alias.ipc .. " sessionMenu toggle"),
	{ description = "Open session menu" }
)
hl.bind(
	alias.mainMod .. " + B",
	hl.dsp.exec_cmd(alias.ipc .. " battery togglePanel"),
	{ description = "Open battery panel" }
)

hl.bind(
	"ALT_R",
	hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle && swayosd-client --input-volume 0"),
	{ description = "Toggle microphone mute" }
)
hl.bind(
	"Control_R",
	hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle || wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ description = "Toggle audio mute" }
)

-- Grouping Windows
hl.bind(alias.mainMod .. " + K", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(alias.mainMod .. " + SHIFT + Tab", hl.dsp.group.next(), { description = "Switch group window" })

-- Volume Control
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(alias.ipc .. " volume increase"),
	{ description = "Increase volume", locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(alias.ipc .. " volume decrease"),
	{ description = "Decrease volume", locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(alias.ipc .. " volume muteOutput"),
	{ description = "Toggle output mute", locked = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(alias.ipc .. " brightness increase"),
	{ description = "Increase brightness", locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(alias.ipc .. " brightness decrease"),
	{ description = "Decrease brightness", locked = true, repeating = true }
)

-- Playback Control
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause && swayosd-client --playerctl play-pause"),
	{ description = "Toggle media playback" }
)
hl.bind(
	"XF86AudioNext",
	hl.dsp.exec_cmd("playerctl next && swayosd-client --playerctl next"),
	{ description = "Next media track" }
)
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous && swayosd-client --playerctl previous"),
	{ description = "Previous media track" }
)

-- Screen Brightness
hl.bind(alias.mainMod .. " + L", hl.dsp.exec_cmd(alias.ipc .. " lockScreen lock"), { description = "Lock screen" })
hl.bind(alias.mainMod .. " + O", hl.dsp.exec_cmd("fish -c noctalia-restart"), { description = "Restart shell UI" })

-- Window Actions
hl.bind(
	alias.mainMod .. " + SHIFT + left",
	hl.dsp.window.move({ direction = "l" }),
	{ description = "Move window left" }
)
hl.bind(
	alias.mainMod .. " + SHIFT + right",
	hl.dsp.window.move({ direction = "r" }),
	{ description = "Move window right" }
)
hl.bind(alias.mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(
	alias.mainMod .. " + SHIFT + down",
	hl.dsp.window.move({ direction = "d" }),
	{ description = "Move window down" }
)

hl.bind(alias.mainMod .. " + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next({}))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { description = "Cycle windows" })

hl.bind(
	alias.mainMod .. " + CTRL + SHIFT + K",
	hl.dsp.window.alter_zorder({ mode = "top" }),
	{ description = "Bring window to front" }
)

hl.bind(alias.mainMod .. " + CTRL + C", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.center())
end, { description = "Toggle floating mode" })

hl.bind(alias.mainMod .. " + SHIFT + C", hl.dsp.window.center(), { description = "Center floating window" })

hl.bind(alias.mainMod .. " + C", function()
	hl.dispatch(hl.dsp.window.float({ action = "enable" }))
	hl.dispatch(hl.dsp.window.resize({ x = 80, y = 80, relative = false }))
	hl.dispatch(hl.dsp.window.center())
end, { description = "Float and center window" })

hl.bind(
	alias.mainMod .. " + mouse:273",
	hl.dsp.window.resize(),
	{ description = "Resize window with mouse", mouse = true }
)
hl.bind(alias.mainMod .. " + mouse:272", hl.dsp.window.drag(), { description = "Move window with mouse", mouse = true })

for i = 1, 10 do
	local key = i % 10
	hl.bind(
		alias.mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end

-- Workspace Actions
for i = 1, 10 do
	local key = i % 10
	hl.bind(
		alias.mainMod .. " + " .. key,
		hl.dsp.focus({ workspace = i }),
		{ description = "Switch to workspace " .. i }
	)
end

hl.bind(
	alias.mainMod .. " + CTRL + minus",
	hl.dsp.window.move({ workspace = "special" }),
	{ description = "Move window to special workspace" }
)
hl.bind(
	alias.mainMod .. " + minus",
	hl.dsp.window.move({ workspace = "special" }),
	{ description = "Send window to special workspace" }
)
hl.bind(
	alias.mainMod .. " + equal",
	hl.dsp.workspace.toggle_special("special"),
	{ description = "Toggle special workspace" }
)

for i = 1, 5 do
	hl.bind(
		alias.mainMod .. " + F" .. i,
		hl.dsp.workspace.toggle_special("scratchpad:" .. i),
		{ description = "Toggle scratchpad " .. i }
	)
	hl.bind(
		alias.mainMod .. " + SHIFT + F" .. i,
		hl.dsp.window.move({ workspace = "special:scratchpad:" .. i }),
		{ description = "Move window to scratchpad " .. i }
	)
end

hl.bind(alias.mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle magic workspace" })
hl.bind(
	alias.mainMod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:magic" }),
	{ description = "Move window to magic workspace" }
)

hl.bind(
	alias.mainMod .. " + CTRL + S",
	hl.dsp.window.move({ workspace = "+0" }),
	{ description = "Move window to current workspace" }
)
hl.bind(
	alias.mainMod .. " + SHIFT + CTRL + S",
	hl.dsp.window.move({ workspace = "+0", follow = true }),
	{ description = "Move window and follow" }
)

-- Additional Settings
hl.config({
	binds = {
		allow_workspace_cycles = true,
		workspace_back_and_forth = true,
		workspace_center_on = true,
		movefocus_cycles_fullscreen = true,
		window_direction_monitor_fallback = true,
	},
})
