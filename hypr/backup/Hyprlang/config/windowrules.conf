# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                    Windowrules Configuration                ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

source = ~/.config/hypr/config/defaults.conf

# General window rules
#windowrule = idle_inhibit fullscreen, match:class .*
#windowrule = render_unfocused on, match:class .*(steam_app_|wine|proton|lutris|heroic).*  
#windowrule = render_unfocused on, match:xwayland true
windowrule = float on, match:title ^(Picture-in-Picture)$
windowrule = min_size 1 1, match:xwayland true 
windowrule = stay_focused on, dim_around on, match:class ^(polkit-gnome-authentication-agent-1|com.github.hluk.copyq)$
windowrule = hyprbars:no_bar true, match:float false

# Title based rules 
windowrule = float on, match:title ^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
                                    |(?i).*rename.*|(?i).*save.*|(?i).*open.*|\
                                    |(?i).*setting.*|Better Control|Picture-in-Picture|\
                                    |Open File|Save File|Steam - Self Updater)$

windowrule = center on, match:title ^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
                                     |(?i).*rename.*|(?i).*save.*|(?i).*open.*|(?i).*setting.*|Better Control|Picture-in-Picture)$
 
windowrule = size (monitor_w*0.65) (monitor_h*0.65), match:title ^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp|\
                                                                  |(?i).*rename.*|(?i).*save.*|(?i).*open.*|Better Control)$

# Class based rules
windowrule = float on, match:class ^(7zFM|org.pulseaudio.pavucontrol|com.github.hluk.copyq|\
                                    |xdg-desktop-portal-gtk.*|xdg-desktop-portal-kde.*|xdg-desktop-portal-hyprland.*|\
                                    |discord)$

windowrule = center on, match:class ^(xdg-desktop-portal-gtk|com.github.hluk.copyq|discord)$
windowrule = size (monitor_w*0.4) (monitor_h*0.4), match:class ^(com.github.hluk.copyq|xdg-desktop-portal-gtk)$
windowrule = size (monitor_w*0.8) (monitor_h*0.8), match:class ^(discord)$

windowrule = workspace special:magic silent, match:class spotify
windowrule = scrolling_width 1, match:class $browserClass
windowrule = scrolling_width 1, opacity 1 override, match:xwayland true

windowrule = no_screen_share true, match:class org.gnome.Nautilus, match:class faugus-launcher
windowrule = no_screen_share true, match:title .*Yazi.*

# Layers Rules #
layerrule = animation slide down, blur on, ignore_alpha 0, match:namespace waybar
layerrule = animation fade 50%, match:namespace wallpaper
layerrule = dim_around on, animation popin 97%, ignore_alpha 0, match:namespace rofi

layerrule = animation slide top, dim_around on, match:namespace swaync-control-center
layerrule = dim_around on, animation popin 98%, match:namespace walker

layerrule = no_screen_share true, match:namespace swaync-notification-window
layerrule = blur on, blur_popups on, ignore_alpha 0.5, match:namespace noctalia-background-.*$

# smart gaps
windowrule = border_size 0, match:float 0, match:workspace w[tv1]
windowrule = border_size 0, match:float 1
windowrule = border_size 0, match:float 0, match:workspace f[1]
