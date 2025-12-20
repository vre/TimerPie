#!/bin/bash
# Regenerate documentation screenshots
# Requires: Chrome, ImageMagick (magick), local server running (npm start)

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
BASE="http://localhost:8080/#autostart=1&controls=0"
OUT="screenshots"

echo "Taking screenshots..."

# Light mode - orange CCW 5min
"$CHROME" --headless --screenshot="$OUT/light-orange-5min.png" \
  --window-size=1000,1000 "$BASE&time=5&mode=ccw"

# Dark mode - blue CCW 26min
"$CHROME" --headless --screenshot="$OUT/dark-blue-26min.png" \
  --window-size=1000,1000 "$BASE&dark=1&color=4a90e2&time=26&mode=ccw"

# Digital+Analog light mode - green 83min (1:23)
"$CHROME" --headless --screenshot="$OUT/digital-green-83min.png" \
  --window-size=1000,1000 "$BASE&color=50c878&time=83&mode=ccw&display=digital"

# End time dark mode - red at 3:10
"$CHROME" --headless --screenshot="$OUT/end-dark-red.png" \
  --window-size=1000,1000 "$BASE&dark=1&color=e74c3c&time=3:10&mode=end"

echo "Cropping..."

# Trim and add 10px border (dark bg for dark mode, white for light)
magick "$OUT/light-orange-5min.png" -trim -bordercolor white -border 10 "$OUT/light-orange-5min.png"
magick "$OUT/dark-blue-26min.png" -trim -bordercolor "#111" -border 10 "$OUT/dark-blue-26min.png"
magick "$OUT/digital-green-83min.png" -trim -bordercolor white -border 10 "$OUT/digital-green-83min.png"
magick "$OUT/end-dark-red.png" -trim -bordercolor "#111" -border 10 "$OUT/end-dark-red.png"

echo "Done. Screenshots saved to $OUT/"
