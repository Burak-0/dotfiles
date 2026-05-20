# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         Startup Apps                        ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Services
#exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#exec-once = elephant & walker --gapplication-service &

exec-once = hyprpm reload -n &
#exec-once = hyprpaper & waybar & hypridle &

#exec-once = swayosd-server & niri-screen-time -daemon & 
exec-once = xembedsniproxy &

exec-once = fcitx5 & 
#exec-once = sleep 2 && wlsunset -s 22:00 -S 06:30 &

exec-once = qs -c noctalia-shell

# Apps
exec-once = xfce4-power-manager &
exec-once = [workspace special:magic silent] steam -silent & 
exec-once = [workspace special:magic silent] spotify-launcher &
exec-once = easyeffects -w & tuxedo-control-center --tray &
exec-once = cachy-update --tray & 
#exec-once = swaync &

# Slow app launch fix
exec-once = systemctl --user import-environment &
exec-once = hash dbus-update-activation-environment 2>/dev/null &
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

exec-once = /usr/lib/gvfsd &
exec-once = /usr/lib/gvfsd-fuse /run/user/1000/gvfs -f &

# General
exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
exec = gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
exec = hyprctl setcursor Future-black-cursors 24
