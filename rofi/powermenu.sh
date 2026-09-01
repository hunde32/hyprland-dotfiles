#!/usr/bin/env bash

# Define the menu options
shutdown="⏻ Shutdown"
reboot="⟳ Restart"
sleep="󰤄 Sleep"
hibernate="⏾ Hibernate"
logout="󰍃 Logout"

# Pipe the options into rofi and apply the custom theme
chosen=$(printf "%s\n%s\n%s\n%s\n%s" "$shutdown" "$reboot" "$sleep" "$hibernate" "$logout" | rofi -dmenu -i -theme ~/.config/rofi/powermenu.rasi -p "Power Menu")

# Execute the selected command
case "$chosen" in
"$shutdown") systemctl poweroff ;;
"$reboot") systemctl reboot ;;
"$sleep") systemctl suspend ;;
"$hibernate") systemctl hibernate ;;
"$logout") command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()' ;;
esac
