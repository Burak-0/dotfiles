local color = require("color")
local size = 13

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 27,
			bar_color = "rgb(1d1d20)",
			bar_title_enabled = true,
			bar_text_size = 14,
			bar_button_padding = 10,
			bar_part_of_window = true,
			bar_blur = true,
			inactive_button_color = "rgb(333336)",
			bar_padding = 10,
			bar_precedence_over_border = true,
			on_double_click = "hyprctl dispatch togglefloating && hyprctl dispatch fullscreenstate 1",
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = color.red,
	fg_color = "rgb(ffffff)",
	size = size,
	action = "hyprctl dispatch killactive",
	icon = "",
})

hl.plugin.hyprbars.add_button({
	bg_color = color.yellow,
	fg_color = "rgb(ffffff)",
	size = size,
	action = "hyprctl dispatch fullscreenstate 1",
	icon = "",
})

hl.plugin.hyprbars.add_button({
	bg_color = color.green,
	fg_color = "rgb(ffffff)",
	size = size,
	action = "hyprctl dispatch togglefloating",
	icon = "",
})
