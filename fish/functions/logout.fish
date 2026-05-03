function logout --wraps='hyprctl dispatch exit'
    hyprctl dispatch exit
end
