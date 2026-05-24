local alias = require("config.alias")

-- General window rules
hl.window_rule({ match = { title = "(?i).*picture-in-picture.*" }, float = true })
hl.window_rule({ match = { xwayland = true }, min_size = { 1, 1 } })
hl.window_rule({ match = { xwayland = true }, scrolling_width = 1, opacity = "1 override" })
hl.window_rule({ match = { float = false }, ["hyprbars:no_bar"] = true })

-- Title based rules
hl.window_rule({
	name = "Float-Title",
	match = {
		title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
              |(?i).*rename.*|(?i).*save.*|(?i).*open.*|\
              |(?i).*setting.*|Better Control|Picture-in-Picture|\
              |Open File|Save File|Steam - Self Updater)$",
	},
	float = true,
})

hl.window_rule({
	name = "Center-Title",
	match = {
		title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
              |(?i).*rename.*|(?i).*save.*|(?i).*open.*|\
              |(?i).*setting.*|Better Control|Picture-in-Picture|\
              |Open File|Save File|Steam - Self Updater)$",
	},
	center = true,
})

hl.window_rule({
	name = "Size-Title",
	match = {
		title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
              |(?i).*rename.*|(?i).*save.*|(?i).*open.*|Better Control)$",
	},
	size = { "monitor_w * 0.65", "monitor_h * 0.65" },
})

-- Class based rules
hl.window_rule({
	name = "Float-Class",
	match = {
		class = "^(7zFM|org.pulseaudio.pavucontrol|com.github.hluk.copyq|\
              |xdg-desktop-portal-gtk.*|xdg-desktop-portal-kde.*|xdg-desktop-portal-hyprland.*|\
              |discord)$",
	},
	float = true,
})

hl.window_rule({
	name = "Scrolling-Width-Class",
	match = {
		class = alias.browserClass,
	},
	scrolling_width = 1,
})

-- No screen share
hl.window_rule({ match = { class = "org.gnome.Nautilus|faugus-launcher" }, no_screen_share = true })
hl.window_rule({ match = { title = ".*Yazi.*" }, no_screen_share = true })

-- Layer rules
hl.layer_rule({ match = { namespace = "noctalia-background-.*$" }, blur = true, blur_popups = true, ignore_alpha = 0.5 })

-- Smart Gaps
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = false, float = false })
hl.window_rule({ match = { workspace = "f[1]", float = false }, border_size = false })
hl.window_rule({ match = { float = true }, border_size = false })
