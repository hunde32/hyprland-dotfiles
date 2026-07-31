#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
ROFI_WALLPAPER_SNIPPET="$HOME/.config/rofi/current_wallpaper.rasi"

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 0.5
fi

list_wallpapers() {
  for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,gif}; do
    if [ -f "$img" ]; then
      filename=$(basename "$img")
      echo -en "$filename\0icon\x1f$img\n"
    fi
  done
}

SELECTED=$(list_wallpapers | rofi -dmenu -i -show-icons -p "󰸉 Wallpaper" \
  -theme ~/.config/rofi/wallpaper-picker.rasi)

if [ -n "$SELECTED" ]; then
  FULL_PATH="$WALLPAPER_DIR/$SELECTED"

  echo "imagebox { background-image: url(\"$FULL_PATH\", height); }" >"$ROFI_WALLPAPER_SNIPPET"
  matugen image "$FULL_PATH" -t scheme-tonal-spot --source-color-index 0

  TRANSITIONS=("wave" "fade" "grow")
  RANDOM_TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}

  awww img "$FULL_PATH" \
    --transition-type "$RANDOM_TRANSITION" \
    --transition-fps 60 \
    --transition-duration 1.2 \
    --transition-pos 0.5,0.5 \
    --transition-bezier 0.65,0,0.35,1

  # 1. Hot-Reload Kitty
  kill -SIGUSR1 $(pgrep kitty)

  # 2. Restart Panels & Daemons
  killall waybar && waybar >/dev/null 2>&1 &
  swaync-client -R && swaync-client -rs
  hyprctl reload

  # 3. Hot-Reload VSCodium (Injects JSON securely)
  CODIUM_SETTINGS="$HOME/.config/VSCodium/User/settings.json"
  MATUGEN_CODIUM="$HOME/.config/matugen/codium-colors.json"
  if [ -f "$CODIUM_SETTINGS" ] && [ -f "$MATUGEN_CODIUM" ]; then
    TEMP_JSON=$(mktemp)
    jq -s '.[0] * .[1]' "$CODIUM_SETTINGS" "$MATUGEN_CODIUM" >"$TEMP_JSON"
    mv "$TEMP_JSON" "$CODIUM_SETTINGS"
  fi

  # 4. Hot-Reload GTK 3 & GTK 4 Apps
  # Toggling the settings forces the applications to instantly redraw their UI
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  sleep 0.1
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
  sleep 0.1
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

  notify-send "Wallpaper changed successfully"
fi
