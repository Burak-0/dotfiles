function logout --wraps='hyprctl dispatch exit' --description 'alias logout=hyprctl dispatch exit'
    hyprshutdown -t 'Logging out...' $argv
end
