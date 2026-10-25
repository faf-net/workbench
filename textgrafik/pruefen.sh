#!/usr/bin/env bash
# Eine Textgrafik-Seite im kopflosen Chrome abfotografieren — der Prüfweg, ohne den man nur rät.
#   pruefen.sh <seite.html> <bild.png> [breite] [hoehe] [wartezeit_ms]
# Läuft unter Windows (Git Bash, Chrome oder Edge), Linux und macOS (chromium/google-chrome).
# --allow-file-access-from-files: sonst gilt ein lokal geladenes Bild als fremd und getImageData wirft.
set -euo pipefail

seite="$1"; bild="$2"; breite="${3:-1920}"; hoehe="${4:-1080}"; warten="${5:-2500}"

browser=""
for k in "/c/Program Files/Google/Chrome/Application/chrome.exe" \
         "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
         chromium chromium-browser google-chrome; do
  if [ -x "$k" ] || command -v "$k" >/dev/null 2>&1; then browser="$k"; break; fi
done
[ -n "$browser" ] || { echo "kein Chrome/Chromium/Edge gefunden" >&2; exit 1; }

abs() { (cd "$(dirname "$1")" && printf '%s/%s' "$(pwd)" "$(basename "$1")"); }
url="file://$(abs "$seite")"
ziel="$(abs "$(dirname "$bild")")/$(basename "$bild")"
if command -v cygpath >/dev/null 2>&1; then url="file:///$(cygpath -m "$(abs "$seite")")"; ziel="$(cygpath -w "$ziel")"; fi

"$browser" --headless=new --disable-gpu --hide-scrollbars --allow-file-access-from-files \
  --window-size="$breite,$hoehe" --virtual-time-budget="$warten" --screenshot="$ziel" "$url" 2>/dev/null
[ -s "$bild" ] && echo "$bild" || { echo "kein Bild entstanden" >&2; exit 1; }
