hl.on("hyprland.start", function()
	-- Services
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("xembedsniproxy")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("xfce4-power-manager")

	-- Apps
	hl.exec_cmd("steam -silent & spotify-launcher")
	hl.exec_cmd("easyeffects -w & tuxedo-control-center --tray")
	hl.exec_cmd("cachy-update --tray")

	-- Slow app launch fix
	hl.exec_cmd("systemctl --user import-environment")
	hl.exec_cmd("hash dbus-update-activation-environment 2>/dev/null")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/gvfsd & /usr/lib/gvfsd-fuse /run/user/1000/gvfs -f")

	-- Set settings
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"')
	hl.exec_cmd("hyprctl setcursor Future-black-cursors 24")
end)
