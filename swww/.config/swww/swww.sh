#!/bin/bash

WALLPAPER_DIR="$HOME/.config/swww/wallpapers/"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory '$WALLPAPER_DIR' not found." >&2
    exit 1
fi

CURRENT_WALLPAPER=$(swww query | grep -oP 'image: \K.*' | head -n 1 | xargs basename)

echo "$CURRENT_WALLPAPER"

TOTAL_WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | wc -l)

echo "$TOTAL_WALLPAPERS"

if [ "$TOTAL_WALLPAPERS" -eq 1 ] && [ -n "$CURRENT_WALLPAPER" ]; then
    echo "No other wallpapers available in '$WALLPAPER_DIR'." >&2
    exit 1
fi

while true; do
    NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1 | xargs basename)

    echo "$NEW_WALLPAPER"
  
    if [ -z "$CURRENT_WALLPAPER" ]; then
        break
    fi
  
    if [ "$NEW_WALLPAPER" != "$CURRENT_WALLPAPER" ]; then
        break
    fi
  
    sleep 0.1
done

NEW_WALLPAPER_DIR="$WALLPAPER_DIR$NEW_WALLPAPER"

echo "$NEW_WALLPAPER_DIR"

swww img --transition-fps 165 --transition-duration 1.5 "$NEW_WALLPAPER_DIR" --transition-type any
