#!/bin/bash

## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## vpn_module: vpn scripts for a polybar, setup stock for Mullvad VPN
## 	by Shervin S. (shervin@tuta.io)

## 	vpn_module reports your VPN's status as [<ip_address> | connecting... | No VPN ].
##  With optional dependencies, <ip_address> will be replaced with <city> <country>.
##  You can also connect and disconnect via left-clicks, or with rofi, right-click to
##  access a menu and select between your favorite locations, set in VPN_LOCATIONS,
##  as well as 35 countries covered by Mullvad VPN.

##	dependencies (assuming use with Mullvad VPN):
##		mullvad-vpn (or mullvad-vpn-cli)

##	optional dependencies:
##		rofi 				  - allows menu-based control of mullvad
##		geoip, geoip-database - provide country instead of public ip address
## 		geoip-database-extra  - also provides city info
##      xclip                 - allows copying ip address to clipboard

## polybar setup:
## - Append contents of vpn_user_module file to user_modules.ini
## - Add "vpn" module to your config.ini under modules


## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## User Settings

## [Set VPN commands]. Setup for Mullvad is done below.
# The first three commands should have direct equivalents for most VPNs.
# The relay_set command assumes <country_code> <city_code> will follow as arguments. See below.
VPN_CONNECT="mullvad connect"
VPN_DISCONNECT="mullvad disconnect"
VPN_GET_STATUS="mullvad status"
VPN_RELAY_SET_LOCATION="mullvad relay set location"

## [Set VPN status parsing]
# The first command cuts the status, which is compared to keywords below.
# REMOVED GLOBAL VPN_STATUS ASSIGNMENT HERE
CONNECTED=Connected
CONNECTING=Connecting

## [Set colors] (set each variable to nothing for default color)
# green=#00CC66
# red=#FF3300
# blue=#0066FF
# orange=#FF6600
# yellow=#FFFF00
# purple=#CC33FF
COLOR_CONNECTED=#00CC66
COLOR_CONNECTING=#FFFF00
COLOR_DISCONNECTED=#FF3300

## [Set 8 favorite VPN locations]
# These are passed to your VPN as `$VPNCOMMAND_RELAY_SET_LOCATION <input>`.
VPN_LOCATIONS=("us sea" "us chi" "us nyc" "us" "jp" "au" "fr" "br")

## [Set optional rofi menu style]. `man rofi` for help.
icon_connect=
icon_fav=
icon_country=
rofi_font="Fira Code Retina 15"
rofi_theme="solarized_alternate"
rofi_location="-location 5 -xoffset -50 -yoffset -50"
rofi_menu_name="Mullvad VPN"


## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## Main Script

# Country codes, taken from `mullvad relay list`.
# They ought to connect to your VPN's choice of server in the region.
COUNTRIES=("Albania (al)" "Australia (au)" "Austria (at)" "Belgium (be)" "Brazil (br)" "Bulgaria (bg)" "Canada (ca)" "Czech Republic (cz)" "Denmark (dk)" "Finland (fi)" "France (fr)" "Germany (de)" "Greece (gr)" "Hong Kong (hk)" "Hungary (hu)" "Ireland (ie)" "Israel (il)" "Italy (it)" "Japan (jp)" "Latvia (lv)" "Luxembourg (lu)" "Moldova (md)" "Netherlands (nl)" "New Zealand (nz)" "Norway (no)" "Poland (pl)" "Romania (ro)" "Serbia (rs)" "Singapore (sg)" "Spain (es)" "Sweden (se)" "Switzerland (ch)" "UK (gb)" "United Arab Emirates (ae)" "USA (us)")
COUNTRY_CODES=("al" "au" "at" "be" "br" "bg" "ca" "cz" "dk" "fi" "fr" "de" "gr" "hk" "hu" "ie" "il" "it" "jp" "lv" "lu" "md" "nl" "nz" "no" "pl" "ro" "rs" "sg" "es" "se" "ch" "gb" "ae" "us")

# Concatenate favorite and country arrays
VPN_CODES=("${VPN_LOCATIONS[@]}")
VPN_CODES+=("${COUNTRY_CODES[@]}")
VPN_LOCATIONS+=("${COUNTRIES[@]}")

# Define a signal number for Waybar updates
# IMPORTANT: This must match the 'signal' in your Waybar config.
WAYBAR_VPN_SIGNAL=10
VPN_WATCHER_PID_FILE="/tmp/waybar_vpn_watcher.pid" # File to store the watcher PID

# Function to send signal to Waybar
send_waybar_signal() {
    pkill -SIGRTMIN+$WAYBAR_VPN_SIGNAL waybar
}

# Function to start the background VPN status watcher
start_vpn_watcher() {
    # Kill any existing watcher to prevent multiple instances
    if [ -f "$VPN_WATCHER_PID_FILE" ]; then
        PID=$(cat "$VPN_WATCHER_PID_FILE")
        if ps -p $PID > /dev/null; then
            kill $PID 2>/dev/null
        fi
        rm -f "$VPN_WATCHER_PID_FILE"
    fi

    # Only start watcher if we are actually in the connecting phase
    local initial_status="$($VPN_GET_STATUS | cut -d' ' -f3)"
    if [ "$initial_status" != "$CONNECTING" ]; then
        return # Don't start watcher if not connecting
    fi

    (
    # This loop runs in the background
    while true; do
        current_status_full="$($VPN_GET_STATUS)"
        current_status=$(echo "$current_status_full" | cut -d' ' -f3)
        
        # We need to keep checking if it's "Connecting" OR if IP is not yet present for "Connected"
        if [ "$current_status" = "$CONNECTING" ]; then
            send_waybar_signal # Send signal to update Waybar to 'Connecting...'
            sleep 1 # Check frequently while connecting
        elif [ "$current_status" = "$CONNECTED" ]; then
            # Check if IP address is present for 'Connected' status
            ip_check=$(echo "$current_status_full" | awk 'match($0,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print substr($0,RSTART,RLENGTH)}')
            if [ -n "$ip_check" ]; then # If IP address is found
                send_waybar_signal # Send one last signal for 'Connected' with IP
                break # Exit watcher
            else
                send_waybar_signal # Send signal for 'Connected' but no IP yet, keep trying
                sleep 1 # Continue checking for IP
            fi
        else
            # If it's no longer connecting (e.g., Disconnected), send one last signal and exit
            send_waybar_signal
            break
        fi
    done
    ) & # Run the loop in a subshell in the background
    echo $! > "$VPN_WATCHER_PID_FILE" # Save the PID of the background process
    disown # Disown the process from the current shell
}

# Function to stop the background VPN status watcher
stop_vpn_watcher() {
    if [ -f "$VPN_WATCHER_PID_FILE" ]; then
        PID=$(cat "$VPN_WATCHER_PID_FILE")
        if ps -p $PID > /dev/null; then
            kill $PID 2>/dev/null
        fi
        rm -f "$VPN_WATCHER_PID_FILE"
    fi
}


vpn_report() {
# This function is called by Waybar to get the current display.
# It MUST get the current status fresh.
    local status_text=""
    local status_class=""
    local tooltip_text=""

    local mullvad_status_output="$($VPN_GET_STATUS)" # Get full output
    local current_vpn_status=$(echo "$mullvad_status_output" | cut -d' ' -f3)

    if [ "$current_vpn_status" = "$CONNECTED" ]; then
        # Extract IP address from the full status output
        local ip_address=$(echo "$mullvad_status_output" | \
        awk 'match($0,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print substr($0,RSTART,RLENGTH)}')

        if [ -n "$ip_address" ]; then # Check if IP address is not empty
            status_class="connected"
            tooltip_text="IP: $ip_address"

            if hash geoiplookup 2>/dev/null; then
                local country=$(geoiplookup "$ip_address" | head -n1 | cut -c24-25)
                local city=$(geoiplookup "$ip_address" | cut -d',' -f5 | sed -n '2{p;q}' | sed 's/ //')
                status_text="$city $country"
            else
                status_text="$ip_address"
            fi
            stop_vpn_watcher # Stop watcher if connected and IP resolved
        else
            # Connected, but IP not yet available, show "Connecting..." or "Getting IP..."
            status_text="Getting IP..." # Or "Connected (waiting for IP)..."
            status_class="connecting" # Use connecting class/icon
            tooltip_text="VPN connected, waiting for IP address."
            start_vpn_watcher # Keep watcher running to get IP
        fi
    elif [ "$current_vpn_status" = "$CONNECTING" ]; then
        status_text="Connecting..."
        status_class="connecting"
        tooltip_text="VPN is trying to connect..."
        start_vpn_watcher # Start watcher if connecting
    else
        status_text="No VPN"
        status_class="disconnected"
        tooltip_text="VPN is disconnected."
        stop_vpn_watcher # Stop watcher if disconnected
    fi

    # Output JSON
    echo "{\"text\": \"$status_text\", \"alt\": \"$status_class\", \"class\": \"$status_class\", \"tooltip\": \"$tooltip_text\"}"
}


vpn_toggle_connection() {
# connects or disconnects vpn
    # Get current status before deciding to connect/disconnect
    local current_vpn_status="$($VPN_GET_STATUS | cut -d' ' -f3)"

    if [ "$current_vpn_status" = "$CONNECTED" ]; then
        $VPN_DISCONNECT
    else
        $VPN_CONNECT
    fi
    send_waybar_signal # Signal Waybar to update after the action
}


vpn_location_menu() {
# Allows control of VPN via rofi menu. Selects from VPN_LOCATIONS.

    if hash rofi 2>/dev/null; then

        MENU="$(rofi $rofi_location \
            -columns 1 -width 10 -hide-scrollbar \
            -line-padding 4 -padding 20 -lines 9 \
            -sep "|" -dmenu -i -p "$rofi_menu_name" <<< \
            " $icon_connect (dis)connect| $icon_fav ${VPN_LOCATIONS[0]}| $icon_fav ${VPN_LOCATIONS[1]}| $icon_fav ${VPN_LOCATIONS[2]}| $icon_fav ${VPN_LOCATIONS[3]}| $icon_fav ${VPN_LOCATIONS[4]}| $icon_fav ${VPN_LOCATIONS[5]}| $icon_fav ${VPN_LOCATIONS[6]}| $icon_fav ${VPN_LOCATIONS[7]}| $icon_country ${VPN_LOCATIONS[8]}| $icon_country ${VPN_LOCATIONS[9]}| $icon_country ${VPN_LOCATIONS[10]}| $icon_country ${VPN_LOCATIONS[11]}| $icon_country ${VPN_LOCATIONS[12]}| $icon_country ${VPN_LOCATIONS[13]}| $icon_country ${VPN_LOCATIONS[14]}| $icon_country ${VPN_LOCATIONS[15]}| $icon_country ${VPN_LOCATIONS[16]}| $icon_country ${VPN_LOCATIONS[17]}| $icon_country ${VPN_LOCATIONS[18]}| $icon_country ${VPN_LOCATIONS[19]}| $icon_country ${VPN_LOCATIONS[20]}| $icon_country ${VPN_LOCATIONS[21]}| $icon_country ${VPN_LOCATIONS[22]}| $icon_country ${VPN_LOCATIONS[23]}| $icon_country ${VPN_LOCATIONS[24]}| $icon_country ${VPN_LOCATIONS[25]}| $icon_country ${VPN_LOCATIONS[26]}| $icon_country ${VPN_LOCATIONS[27]}| $icon_country ${VPN_LOCATIONS[28]}| $icon_country ${VPN_LOCATIONS[29]}| $icon_country ${VPN_LOCATIONS[30]}| $icon_country ${VPN_LOCATIONS[31]}| $icon_country ${VPN_LOCATIONS[32]}| $icon_country ${VPN_LOCATIONS[33]}| $icon_country ${VPN_LOCATIONS[34]}| $icon_country ${VPN_LOCATIONS[35]}| $icon_country ${VPN_LOCATIONS[36]}| $icon_country ${VPN_LOCATIONS[37]}| $icon_country ${VPN_LOCATIONS[38]}| $icon_country ${VPN_LOCATIONS[39]}| $icon_country ${VPN_LOCATIONS[40]}| $icon_country ${VPN_LOCATIONS[41]}| $icon_country ${VPN_LOCATIONS[42]}| $icon_country ${VPN_LOCATIONS[43]}")"

        case "$MENU" in
            *connect) vpn_toggle_connection; return;;
            # Each location setting needs to trigger a signal
            *"${VPN_LOCATIONS[0]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[0]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[1]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[1]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[2]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[2]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[3]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[3]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[4]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[4]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[5]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[5]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[6]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[6]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[7]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[7]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[8]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[8]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[9]}") $VPN_RELAY_SET_LOCATION ${VPN_CODES[9]}; send_waybar_signal;;
            *"${VPN_LOCATIONS[10]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[10]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[11]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[11]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[12]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[12]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[13]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[13]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[14]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[14]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[15]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[15]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[16]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[16]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[17]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[17]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[18]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[18]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[19]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[19]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[20]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[20]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[21]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[21]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[22]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[22]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[23]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[23]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[24]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[24]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[25]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[25]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[26]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[26]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[27]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[27]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[28]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[28]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[29]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[29]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[30]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[30]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[31]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[31]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[32]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[32]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[33]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[33]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[34]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[34]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[35]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[35]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[36]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[36]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[37]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[37]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[38]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[38]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[39]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[39]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[40]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[40]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[41]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[41]}"; send_waybar_signal;;
            *"${VPN_LOCATIONS[42]}") $VPN_RELAY_SET_LOCATION "${VPN_CODES[42]}"; send_waybar_signal;;
        esac

        # Re-evaluate status *again* before this final conditional connect.
        local current_vpn_status="$($VPN_GET_STATUS | cut -d' ' -f3)"
        if [ "$current_vpn_status" = "$CONNECTED" ]; then
            true
        else
            # If the user selected a location while disconnected, connect after setting relay
            $VPN_CONNECT
        fi
        send_waybar_signal # Signal Waybar to update after potential final connect
    fi
}


ip_address_to_clipboard() {
# finds your IP and copies to clipboard
# could also use https://ifconfig.io, checkip.amazonaws.com
    ip_address=$(curl --silent https://ipaddr.pub)
     	wl-copy "$ip_address"
        # Handle case where neither wl-copy nor xclip are available
    # No send_waybar_signal here, as copying IP doesn't change VPN status.
}


# cases for polybar user_module.ini
case "$1" in
    --toggle-connection) vpn_toggle_connection ;;
    --location-menu) vpn_location_menu ;;
    --ip-address) ip_address_to_clipboard;;
    # Add a case for stopping the watcher on Waybar exit (optional but good practice)
    --exit) stop_vpn_watcher ;;
    *) vpn_report ;;
esac
