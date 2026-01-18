function hyprconfig --wraps='sudo nano ~/.config/hypr/hyprland.conf' --wraps='sudo nvim ~/.config/hypr/hyprland.conf' --wraps='nvim ~/.config/hypr/hyprland.conf' --description 'alias hyprconfig=nvim ~/.config/hypr/hyprland.conf'
  nvim ~/.config/hypr/hyprland.conf $argv
        
end
