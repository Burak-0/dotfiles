hl.config({
  plugin = {
    kinetic-scroll = {
      enabled = 1
    }

    hyprbars = {
      bar_height = 27
      bar_color = rgb(1d1d20)
      bar_title_enabled = true
      bar_text_size = 14
      bar_button_padding = 10
      bar_part_of_window = true
      bar_blur = true
      inactive_button_color = rgb(333336)
      bar_padding = 10
      bar_precedence_over_border = true
      hyprbars-button = $red, 13, , hyprctl dispatch killactive
      hyprbars-button = $yellow, 13, , hyprctl dispatch fullscreenstate 1
      hyprbars-button = $green, 13, , hyprctl dispatch togglefloating
      on_double_click = hyprctl dispatch togglefloating && hyprctl dispatch fullscreenstate 1
    }
  }
)}
