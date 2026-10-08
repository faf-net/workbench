# Claude Code

So ist Claude Code auf Rechner A und Rechner B eingerichtet, und so antwortet jede Claude-Instanz im Terminal.

## Einstellungen

In `~/.claude/settings.json`:

```json
"verbose": true,
"theme": "custom:workbench"
```

- **`verbose: true` ist Pflicht.** Ohne faltet Claude Code jede Werkzeugausgabe zu „Ran 1 shell command“ zusammen, und sieht keinen einzigen Farbblock.
- **`theme: custom:workbench`** färbt die Oberfläche von Claude Code selbst. Für die Farbblöcke ist es nicht nötig, weil `wb.sh` und `wb.ps1` 24-Bit-Farbe direkt schreiben.

## Das Theme

Datei `~/.claude/themes/workbench.json`, Format `{ "name", "base", "overrides" }`. `base` ist `dark`. Von 72 möglichen Schlüsseln sind 50 gesetzt, der Rest kommt vom Basis-Theme. Claude Code überwacht das Verzeichnis und lädt Änderungen sofort. Das Original liegt unter `terminal/` → `claude-code-workbench.json`.

| Rolle in Claude Code | Schlüssel | Ton |
|---|---|---|
| Text, gedämpft, schwach | `text` · `inactive` · `subtle` | `schrift` · `gedaempft` · `schwach` |
| Text auf Akzent | `inverseText` | `grund` |
| Claude selbst, Maskottchen, Effort Ultra, Ratenbalken | `claude` · `clawd_body` · `effortUltra` · `rate_limit_fill` | `bernstein` |
| Erfolg, Plan-Modus, Diff-Wort hinzugefügt | `success` · `planMode` · `diffAddedWord` | `salbei` |
| Fehler, Diff-Wort entfernt | `error` · `diffRemovedWord` | `rose` |
| Warnung, Auto-Accept, Fast Mode | `warning` · `autoAccept` · `fastMode` · `chromeYellow` | `gold` |
| Berechtigung, Skills, Bash-Rahmen, IDE, Vorschläge, Spinner, „Du“-Label | `permission` · `skill` · `bashBorder` · `ide` · `suggestion` · `briefLabelYou` u. a. | `stahl` |
| Eingaberahmen | `promptBorder` | `schwach` |
| Diff-Zeilen | `diffAdded` / `diffAddedDimmed` · `diffRemoved` / `diffRemovedDimmed` | `marker-salbei` / `dezent-salbei` · `marker-rose` / `dezent-rose` |
| Nachrichtenhintergrund, Hover, Seitenleiste | `userMessageBackground` · `…Hover` · `composerSidebarBackground` | `panel` · `panel-2` · `panel` |
| Bash-Ausgabe, Gedächtnis, Auswahl | `bashMessageBackgroundColor` · `memoryBackgroundColor` · `selectionBg` | `dezent-stahl` · `dezent-bernstein` · `marker-stahl` |
| Leerer Ratenbalken | `rate_limit_empty` | `linie` |
| Schimmer (Animation) | `claudeShimmer` · `warningShimmer` · `permissionShimmer` · `inactiveShimmer` | `schimmer-bernstein` · `schimmer-gold` · `schimmer-stahl` · `schimmer-schrift` |

Erlaubte Werte in einem Theme: `#rrggbb`, `rgb(r,g,b)`, `ansi256(n)` oder `ansi:<name>`. Mögliche Basen: `dark`, `light`, `dark-daltonized`, `light-daltonized`, `dark-ansi`, `light-ansi`.

## Wie Claude antwortet

- **Jede Antwort mit Status, Messwerten, Inventar, Vergleich oder Bewertung bekommt mindestens einen Farbblock**, und zwar **vor** der Prosa. Nur Rückfragen und Einzeiler ohne.
- Der Farbblock kommt aus `wb.sh` (Rechner A, Bash-Werkzeug) bzw. `wb.ps1` (Rechner B, PowerShell-Werkzeug). Zuerst `hostname` messen, nie die Maschine annehmen.
- **Kernaussage zuerst**, Nebenbefunde weglassen. Ein Farbblock, der in Prosa untergeht, ist wertlos.
- In der Chat-Antwort selbst gibt es keine frei wählbare Farbe. Struktur entsteht dort über Codeblöcke mit Box-Zeichen `╭─│└├╰`, ausgerichtete Spalten, Markdown-Tabellen, Statussymbole `● ✗ ▸ ⚠ ✔ ⏸ ◐` und Balken aus `█`. `Code-Spans` erscheinen im Akzentton, **Fettes** heller. Beides bestimmt das Theme.
- Immer sagen, was **gemessen** und was **geschätzt** ist.
- Will die eingeklappte Werkzeugausgabe sehen: **Strg+O** anbieten, nicht voraussetzen.
- Für eine echte Grafik (längere Analyse, mehrere Dimensionen, Zahlen im Vergleich, etwas zum Behalten) ein HTML-Artefakt in Workbench bauen. Nicht für Zwischenstände.
