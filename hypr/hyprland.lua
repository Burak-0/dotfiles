local dir = os.getenv("HOME") .. "/.config/hypr"
package.path = package.path .. ";" .. dir .. "/?.lua"

local color = require("color")

require("config.environment")
require("config.keybinds")
require("config.gkeybinds")
require("config.monitor")
require("config.windowrules")
require("config.animations")
require("config.startup")
require("config.permissions")

require("config.plugins.hyprbars")
--require("config.plugins.kinetic_scroll")

require("config.layouts.scroller")
-- require("config.layouts.master")

require("scripts.powersave")
require("scripts.scrollerfocus")

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		numlock_by_default = true,

		scroll_button_lock = true,

		follow_mouse = 1,
		follow_mouse_threshold = 0.0,
		float_switch_override_focus = 1,
		focus_on_close = 0,
		--accel_profile="flat",
		--force_no_accel=true,

		repeat_delay = 350,
		repeat_rate = 30,

		touchpad = {
			natural_scroll = true,
		},

		sensitivity = 0,
	},

	general = {
		gaps_in = 5,
		gaps_out = 8,
		border_size = 1,
		["col.active_border"] = color.mauve, -- $blue 30deg
		["col.inactive_border"] = color.base,

		layout = "scrolling",

		allow_tearing = true,

		resize_on_border = true,
		extend_border_grab_area = 1,

		snap = {
			enabled = true,
		},
	},

	decoration = {
		active_opacity = 0.96,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,

		dim_inactive = true,
		dim_strength = 0.15,

		rounding = 8,
		rounding_power = 3,

		blur = {
			enabled = true,
			size = 5,
			passes = 3,
			noise = 0.1,
			new_optimizations = true,
		},

		shadow = {
			enabled = true,
			range = 17,
			render_power = 4,
			color = "rgba(1a1a1aaf)",
		},
	},

	group = {
		auto_group = false,
		["col.border_active"] = "rgba(ffb4befe)",
		["col.border_inactive"] = "rgba(ff313244)",

		groupbar = {
			rounding = 5,
			rounding_power = 3,
			text_color = color.base,
			text_color_inactive = color.overlay0,
			font_size = 12,
			height = -6,
			indicator_gap = 4,
			indicator_height = 16,
			round_only_edges = false,
			["col.active"] = "rgba(ff89b4fa)",
			["col.inactive"] = "rgba(ffb4befe)",
			keep_upper_gap = true,
			text_offset = -8,
		},
	},

	scrolling = {
		follow_min_visible = 0.1,
		focus_fit_method = 1,
	},

	cursor = {
		no_hardware_cursors = 0,
	},

	misc = {
		disable_hyprland_logo = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		initial_workspace_tracking = 1,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		font_family = "SF Pro Display Medium",
		focus_on_activate = false,
	},

	debug = {
		vfr = true,
	},

	ecosystem = {
		enforce_permissions = false,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
