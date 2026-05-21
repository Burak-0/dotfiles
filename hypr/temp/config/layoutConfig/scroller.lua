bind = $mainMod, apostrophe, exec, ~/.config/hypr/scripts/scrollerfocus.sh
bindd = $mainMod, COMMA, Scroll through workspaces decrementally, layoutmsg, focus l
bindd = $mainMod, PERIOD, Scroll through workspaces decrementally, layoutmsg, focus r

bindd = $mainMod, left, Move focus to the left, layoutmsg, focus l
bindd = $mainMod, right,  Move focus to the right, layoutmsg, focus r
bindd = $mainMod, up, Move focus upwards, layoutmsg, focus u
bindd = $mainMod, down, Move focus downwards, layoutmsg, focus d

bindd = $mainMod, mouse_down, Scroll through workspaces incrementally, layoutmsg, move +col
bindd = $mainMod, mouse_up, Scroll through workspaces decrementally, layoutmsg, move -col

bind = $mainMod SHIFT, period, movewindow, r
bind = $mainMod SHIFT, comma, movewindow, l

bind = $mainMod CTRL, comma, layoutmsg, swapcol l
bind = $mainMod CTRL, period, layoutmsg, swapcol r

bind = $mainMod, slash, layoutmsg, expel
bind = $mainMod SHIFT, slash, layoutmsg, fit active
bind = $mainMod CTRL, slash, layoutmsg, fit visible
bind = $mainMod SHIFT CTRL, slash, layoutmsg, fit all

bindde = $mainMod CTRL SHIFT, right, Resize to the right, layoutmsg, colresize +conf
bindde = $mainMod CTRL SHIFT, left, Resize to the left, layoutmsg, colresize -conf
bindde = $mainMod CTRL SHIFT, period, Resize to the right, layoutmsg, colresize +conf
bindde = $mainMod CTRL SHIFT, comma, Resize to the left, layoutmsg, colresize -conf

bindd = $mainMod CTRL, 1, Move window and switch to workspace 1, movetoworkspace, 1
bindd = $mainMod CTRL, 2, Move window and switch to workspace 2, movetoworkspace, 2
bindd = $mainMod CTRL, 3, Move window and switch to workspace 3, movetoworkspace, 3
bindd = $mainMod CTRL, 4, Move window and switch to workspace 4, movetoworkspace, 4
bindd = $mainMod CTRL, 5, Move window and switch to workspace 5, movetoworkspace, 5
bindd = $mainMod CTRL, 6, Move window and switch to workspace 6, movetoworkspace, 6
bindd = $mainMod CTRL, 7, Move window and switch to workspace 7, movetoworkspace, 7
bindd = $mainMod CTRL, 8, Move window and switch to workspace 8, movetoworkspace, 8
bindd = $mainMod CTRL, 9, Move window and switch to workspace 9, movetoworkspace, 9
bindd = $mainMod CTRL, 0, Move window and switch to workspace 10, movetoworkspace, 10

#bindd = $mainMod CTRL, 1, Move window silently to workspace 1, layoutmsg, movecoltoworkspace 1
#bindd = $mainMod CTRL, 2, Move window silently to workspace 2, layoutmsg, movecoltoworkspace 2
#bindd = $mainMod CTRL, 3, Move window silently to workspace 3, layoutmsg, movecoltoworkspace 3
#bindd = $mainMod CTRL, 4, Move window silently to workspace 4, layoutmsg, movecoltoworkspace 4
#bindd = $mainMod CTRL, 5, Move window silently to workspace 5, layoutmsg, movecoltoworkspace 5
#bindd = $mainMod CTRL, 6, Move window silently to workspace 6, layoutmsg, movecoltoworkspace 6
#bindd = $mainMod CTRL, 7, Move window silently to workspace 7, layoutmsg, movecoltoworkspace 7
#bindd = $mainMod CTRL, 8, Move window silently to workspace 8, layoutmsg, movecoltoworkspace 8
#bindd = $mainMod CTRL, 9, Move window silently to workspace 9, layoutmsg, movecoltoworkspace 9
#bindd = $mainMod CTRL, 0, Move window silently to workspace 10, layoutmsg, movecoltoworkspace 10

general {
        gesture = 3, right, dispatcher, layoutmsg, focus r
        gesture = 3, left, dispatcher, layoutmsg, focus l

        gesture = 3, horizontal, mod:SUPER, workspace
}
