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

  ln -sf "$FULL_PATH" ~/.cache/current_wallpaper
  echo "imagebox { background-image: url(\"$FULL_PATH\", height); }" >"$ROFI_WALLPAPER_SNIPPET"

  # --- THE SMART COLOR ALGORITHM ---
  # 1. Calculate the image's average saturation (0.0 to 1.0) using ImageMagick
  SATURATION=$(magick "$FULL_PATH" -colorspace HSL -channel G -separate -format "%[fx:mean]" info:)

  # 2. Check if the image is mostly desaturated (grayscale/black/white)
  # A threshold of 0.15 means if the image is less than 15% saturated, it triggers the fallback.
  IS_DESATURATED=$(echo "$SATURATION < 0.15" | bc -l)

  if [ "$IS_DESATURATED" -eq 1 ]; then
    # Image lacks color. Pick a random vibrant theme hex to keep things fresh!
    # Themes: Gruvbox Orange, Tokyo Night Blue, Catppuccin Mauve, Nord Frost, Rose Pine, Mocha Green
    THEME_COLORS=("#7aa2f7" "#cba6f7" "#88c0d0" "#31748f")
    RANDOM_HEX=${THEME_COLORS[$RANDOM % ${#THEME_COLORS[@]}]}

    matugen color hex "$RANDOM_HEX" -t scheme-tonal-spot
  else
    # Image has good color saturation, let Matugen extract it normally
    matugen image "$FULL_PATH" -t scheme-tonal-spot --source-color-index 0
  fi
  # ---------------------------------

  TRANSITIONS=("wave" "fade" "grow")
  RANDOM_TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}

  awww img "$FULL_PATH" \
    --transition-type "$RANDOM_TRANSITION" \
    --transition-fps 60 \
    --transition-duration 1.2 \
    --transition-pos 0.5,0.5 \
    --transition-bezier 0.65,0,0.35,1

  # Hot-Reload Kitty
  kill -SIGUSR1 $(pgrep kitty)

  # Restart Panels & Daemons
  killall waybar && waybar >/dev/null 2>&1 &
  swaync-client -R && swaync-client -rs
  hyprctl reload

  # Hot-Reload VSCodium
  CODIUM_SETTINGS="$HOME/.config/VSCodium/User/settings.json"
  MATUGEN_CODIUM="$HOME/.config/matugen/codium-colors.json"
  if [ -f "$CODIUM_SETTINGS" ] && [ -f "$MATUGEN_CODIUM" ]; then
    TEMP_JSON=$(mktemp)
    jq -s '.[0] * .[1]' "$CODIUM_SETTINGS" "$MATUGEN_CODIUM" >"$TEMP_JSON"
    mv "$TEMP_JSON" "$CODIUM_SETTINGS"
  fi

  # Hot-Reload GTK 3 & GTK 4 Apps
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  sleep 0.1
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
  sleep 0.1
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

  notify-send "Wallpaper generated successfully"
fi
