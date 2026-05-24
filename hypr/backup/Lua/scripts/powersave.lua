local state_file = os.getenv("HOME") .. "/.cache/hypr-powersave.state"
local alias = require("config.alias")

local function toggle_powersave()
	local f = io.open(state_file, "r")

	if f then
		local active, inactive, fullscreen, dim, rounding = f:read("*a"):match("(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")

		f:close()

		hl.config({
			animations = { enabled = true },
			decoration = {
				blur = { enabled = true },
				shadow = { enabled = true },
				active_opacity = tonumber(active),
				inactive_opacity = tonumber(inactive),
				fullscreen_opacity = tonumber(fullscreen),
				dim_inactive = dim == "true",
				rounding = tonumber(rounding),
			},
			misc = { disable_autoreload = false },
		})

		hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "auto", scale = 1.25 })

		os.remove(state_file)
		hl.notification.create({ text = "Power Save OFF", timeout = 3000, icon = "ok" })
	else
		f = io.open(state_file, "w")

		f:write(
			hl.get_config("decoration.active_opacity"),
			" ",
			hl.get_config("decoration.inactive_opacity"),
			" ",
			hl.get_config("decoration.fullscreen_opacity"),
			" ",
			tostring(hl.get_config("decoration.dim_inactive")),
			" ",
			hl.get_config("decoration.rounding"),
			"\n"
		)

		f:close()

		hl.config({
			animations = { enabled = false },
			decoration = {
				blur = { enabled = false },
				shadow = { enabled = false },
				active_opacity = 1.0,
				inactive_opacity = 1.0,
				fullscreen_opacity = 1.0,
				rounding = 0,
				dim_inactive = false,
			},
			misc = { disable_autoreload = true },
		})

		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "auto", scale = 1.25 })

		hl.notification.create({ text = "Power Save ON", timeout = 3000, icon = "ok" })
	end
end

hl.bind(alias.mainMod .. " + SHIFT + P", function()
	toggle_powersave()
end, {
	description = "Toggle power save",
})
