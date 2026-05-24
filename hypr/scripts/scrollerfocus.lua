local alias = require("config.alias")

hl.bind(alias.mainMod .. " + APOSTROPHE", function()
	local current = hl.get_config("scrolling:focus_fit_method")
	local next_val = (current == 0) and 1 or 0

	hl.config({ scrolling = { focus_fit_method = next_val } })
	hl.dispatch(hl.dsp.focus({ direction = "u" }))
	hl.dispatch(hl.dsp.focus({ direction = "d" }))
	hl.notification.create({
		text = "focus_fit_method: " .. next_val,
		timeout = 2000,
		icon = "ok",
	})
end, {
	description = "Toggle scrolling focus fit method",
})
