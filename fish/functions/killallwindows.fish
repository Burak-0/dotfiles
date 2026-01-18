function killallwindows
    hyprctl --batch $(hyprctl -j clients | jq -j '.[] | "dispatch killwindow address:\(.address);"')
end
