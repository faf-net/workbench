#!/usr/bin/env bash
# Workbench for Claude Code: design skill, text-graphics skill and the diagram-design profile in one go.
# Linux, macOS and Git Bash on Windows. Idempotent. Options: --no-diagrams, --no-textgrafik
set -euo pipefail
HIER="$(cd "$(dirname "$0")" && pwd)"
DIAGRAMME=1; TEXTGRAFIK=1
for a in "$@"; do
  case "$a" in
    --no-diagrams) DIAGRAMME=0 ;;
    --no-textgrafik) TEXTGRAFIK=0 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done

# 1. Design skill, self-contained: the skill file plus the values it refers to
ZIEL="$HOME/.claude/skills/workbench-design"
mkdir -p "$ZIEL"
cp "$HIER/workbench-design/SKILL.md" "$ZIEL/SKILL.md"
cp "$HIER/tokens/tokens.json" "$ZIEL/tokens.json"
cp "$HIER/css/workbench.css" "$ZIEL/workbench.css"
cp "$HIER/components/workbench-components.css" "$ZIEL/workbench-components.css"
cp "$HIER/components/README.md" "$ZIEL/components.md"
cp "$HIER/docs/grundlagen.md" "$ZIEL/grundlagen.md"
cmp -s "$HIER/tokens/tokens.json" "$ZIEL/tokens.json" && echo "workbench-design: skill installed ($ZIEL)"

# 2. Text graphics
if [ "$TEXTGRAFIK" = 1 ]; then
  bash "$HIER/textgrafik/install.sh"
fi

# 3. Diagrams: profile for the third-party plugin diagram-design
if [ "$DIAGRAMME" = 1 ]; then
  bash "$HIER/diagram-design/install.sh" || echo "diagram-design: not set up. Install the plugin, then run diagram-design/install.sh again." >&2
fi
