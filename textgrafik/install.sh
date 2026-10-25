#!/usr/bin/env bash
# Skill „textgrafik“ für Claude Code einrichten — Linux, macOS und Git Bash unter Windows. Idempotent.
set -euo pipefail
HIER="$(cd "$(dirname "$0")" && pwd)"
ZIEL="$HOME/.claude/skills/textgrafik"
mkdir -p "$ZIEL/beispiel"
cp "$HIER/SKILL.md" "$HIER/textgrafik.js" "$HIER/pruefen.sh" "$ZIEL/"
cp "$HIER/beispiel/erdrand.html" "$HIER/beispiel/erdrand.js" "$ZIEL/beispiel/"
chmod +x "$ZIEL/pruefen.sh"
cmp -s "$HIER/textgrafik.js" "$ZIEL/textgrafik.js" && echo "textgrafik: Skill eingerichtet ($ZIEL)"
