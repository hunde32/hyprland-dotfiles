#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/waybar/Themes"
WAYBAR_DIR="$HOME/.config/waybar"
ROFI_THEME="$HOME/.config/rofi/waybar-switcher.rasi"

if [ ! -d "$THEMES_DIR" ]; then
    notify-send "Waybar Switcher" "Themes directory not found!"
    exit 1
fi

themes=$(ls "$THEMES_DIR")

if [ -z "$themes" ]; then
    notify-send "Waybar Switcher" "No themes found inside $THEMES_DIR"
    exit 1
fi

selected_theme=$(echo "$themes" | rofi -dmenu -i -p "󱕈 Waybar Layout" -theme "$ROFI_THEME")

if [ -z "$selected_theme" ]; then
    exit 0
fi

SRC_CONFIG="$THEMES_DIR/$selected_theme/config"
SRC_STYLE="$THEMES_DIR/$selected_theme/style.css"

if [ ! -f "$SRC_CONFIG" ] || [ ! -f "$SRC_STYLE" ]; then
    notify-send "Waybar Switcher" "Missing 'config' or 'style.css' in $selected_theme"
    exit 1
fi

pkill waybar

rm -f "$WAYBAR_DIR/config" "$WAYBAR_DIR/style.css"

ln -s "$SRC_CONFIG" "$WAYBAR_DIR/config"
ln -s "$SRC_STYLE" "$WAYBAR_DIR/style.css"

waybar &

notify-send "Waybar Switcher" "Switched to layout: $selected_theme"
