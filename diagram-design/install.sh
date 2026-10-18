#!/usr/bin/env bash
# diagram-design mit Workbench-Profil einrichten — Linux, macOS und Git Bash unter Windows.
# Idempotent: darf nach jedem Plugin-Update erneut laufen.
set -euo pipefail

HIER="$(cd "$(dirname "$0")" && pwd)"
PROFILE_DIR="$HOME/.diagram-design/profiles"

if command -v claude >/dev/null 2>&1; then
  claude plugin marketplace add cathrynlavery/diagram-design >/dev/null 2>&1 || true
  claude plugin install diagram-design@diagram-design >/dev/null 2>&1 || true
else
  echo "claude nicht im PATH — Plugin von Hand installieren:" >&2
  echo "  /plugin marketplace add cathrynlavery/diagram-design" >&2
  echo "  /plugin install diagram-design@diagram-design" >&2
fi

# Neueste installierte Fassung finden
SG="$(ls -d "$HOME"/.claude/plugins/cache/diagram-design/diagram-design/*/skills/diagram-design/references/style-guide.md 2>/dev/null | sort -V | tail -1 || true)"
if [ -z "$SG" ]; then
  echo "Plugin nicht gefunden — erst installieren, dann erneut ausführen." >&2
  exit 1
fi

mkdir -p "$PROFILE_DIR"

# Werksfassung sichern, solange die installierte Vorlage noch unverändert ist
if [ ! -f "$PROFILE_DIR/default.md" ] && ! head -1 "$SG" | grep -q 'diagram-design-profile'; then
  { printf '<!-- diagram-design-profile\nname: Default\nslug: default\nsource-url: none\ncreated: %s\nupdated: %s\nnotes: Pristine shipped style guide\n-->\n' "$(date +%F)" "$(date +%F)"; cat "$SG"; } > "$PROFILE_DIR/default.md"
fi

cp "$HIER/workbench.md" "$PROFILE_DIR/workbench.md"
cp "$HIER/workbench.md" "$SG"
cmp -s "$HIER/workbench.md" "$SG" && echo "diagram-design: Profil workbench aktiv ($SG)"
