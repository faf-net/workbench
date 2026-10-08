# Workbench

[English](README.md) · **Deutsch**

**Ein persönliches Design System in warmen, gedämpften Farben, für Terminal, Web, Office und Obsidian.**

Der Name kommt vom Betriebssystem des **Amiga 500**. Workbench sieht aus wie eine alte Instrumententafel: warmer dunkler Grund, ein einziger lauter Akzent in Bernstein, alle anderen Töne erdig und zurückhaltend.

![Workbench-Bausteine im dunklen Theme](assets/vorschau.png)

Version **1.0** · 09.10.2026

---

## Die drei Regeln

1. **Der Grund ist warm.** `#1a1918`, nie ein neutrales `#1e1e1e`.
2. **Ein lauter Akzent.** Nur Bernstein `#cc9166` darf laut sein. Alles andere tritt zurück.
3. **Eine Familie.** Gedämpft und erdig. Kein Neon, kein reines Rot, Grün oder Blau.

Dazu kommt: **Farbe entscheidet nie allein.** Jede Statusanzeige trägt ein Wort, denn Salbei und Rosé sind bei Rot-Grün-Schwäche kaum zu unterscheiden.

## Die Palette

| | Dunkel | Hell | Bedeutung |
|---|---|---|---|
| Grund | `#1a1918` | `#efeae1` | Seitenhintergrund |
| Panel | `#232120` | `#f7f3ec` | Karten, Flächen |
| Linie | `#3a3634` | `#d3cabb` | Rahmen, Trenner |
| Schrift | `#e9e3d8` | `#2a2724` | Fließtext |
| gedämpft | `#a49c90` | `#6a6258` | Nebentext, Beschriftungen |
| fett | `#f5f1eb` | `#171512` | Fettes, Text auf Markern |
| **Bernstein** | `#cc9166` | `#975b34` | der eine Akzent, das Wichtigste |
| Salbei | `#93a373` | `#5e7040` | gut, erledigt |
| Stahl | `#7d97ab` | `#456579` | neutral, Daten, Verweise |
| Gold | `#c7a854` | `#7e6820` | Achtung, geschätzt |
| Rosé | `#c07f73` | `#9c4d40` | kritisch, Fehler |
| Petrol | `#7fa79f` | `#4e716a` | Nebenton, dritte Datenreihe |
| Malve | `#b1899b` | `#8c5c72` | Nebenton, Code |

Alle 60 Tokens, darunter Textmarker (25 %), dezente Marker (14 %), Hinweisbänder (33 %) und Statustöne, stehen in [`tokens/tokens.json`](tokens/tokens.json). Jeder Token trägt einen Verwendungshinweis mit Kontrastwerten.

## Schrift, Raster, Formen

- **Atkinson Hyperlegible Next** für Überschriften und Text, gebaut für Lesbarkeit (I, l und 1 sind klar getrennt).
- **JetBrains Mono** für Code, Zahlen und Beschriftungen.
- **4er-Raster:** 4 · 8 · 12 · 16 · 24 · 32 · 48 px.
- **Ecken:** 6 px für Karten, 3 px für Marker und Pillen.
- **Tiefe** über Flächen-Ebenen statt Schatten. Ein Schatten nur für schwebende Elemente.
- **Diagramme:** eine Reihe in Stahl mit dem wichtigen Wert in Bernstein. Mehrere Reihen in Bernstein · Stahl · Petrol · Gold, höchstens vier, direkt beschriftet.

## Inhalt

```
tokens/tokens.json                    alle Tokens, dunkel und hell (Quelle)
css/workbench.css                     CSS-Variablen, generiert aus den Tokens
components/workbench-components.css   Bausteine: Hinweisband, Textmarker, Statuspille,
                                      Host-Karte, Balken, Messtabelle, Diagramm, Menü
components/README.md                  Anleitung je Baustein
examples/bausteine.html               alle Bausteine zum Ansehen, dunkel und hell
docs/                                 Grundlagen, Office, Obsidian, Terminal, Claude Code
assets/                               Monogramm „wb“ (dunkel, hell, Favicon)
obsidian/                             Obsidian-Theme „Workbench“ (GPL-3.0, siehe unten)
terminal/                             Windows Terminal, PowerShell-Profil, wb.ps1, wb.sh,
                                      Claude-Code-Theme
```

## Verwenden

### Im Web

```html
<link rel="stylesheet" href="css/workbench.css">
<link rel="stylesheet" href="components/workbench-components.css">

<div class="wb-band">Kernaussage über die volle Breite</div>
<span class="wb-status wb-status--gut">frei</span>
<span class="wb-mark">Kernergebnis</span>
```

Dunkel ist Standard. Hell schaltet sich über `prefers-color-scheme` ein oder ausdrücklich mit `data-theme="light"` am `<html>`-Element.

### Word, Excel, PowerPoint

Designfarben, Formatvorlagen und Folienaufbau in [`docs/office.md`](docs/office.md). Die Werte gelten auch für OnlyOffice und LibreOffice.

## PowerShell-Design

Das Erscheinungsbild der PowerShell hat vier Ebenen. Jede wirkt für sich, zusammen ergeben sie das volle Bild.

| Ebene | Was | Datei |
|---|---|---|
| Schrift | **JetBrainsMono Nerd Font Mono**, benutzerweit installiert. Ohne sie zeigt der Prompt Kästchen statt Ordner-, Git- und Admin-Zeichen | nicht enthalten, [nerdfonts.com](https://www.nerdfonts.com/) |
| Terminal | Farbschema und Fenster-Theme „Workbench“ für Windows Terminal | `terminal/windows-terminal/terminal-workbench.json` |
| Profil | Syntaxfarben, Ausgabefarben, Dateifarben, Prompt | `terminal/powershell/profile.ps1` |
| Helfer | `wb` für Textmarker und Hinweisbänder in eigenen Skripten | `terminal/powershell/wb.ps1`, `terminal/bash/wb.sh` |

### Windows Terminal

- Schrift JetBrainsMono Nerd Font Mono **11 pt**, Graustufen-Glättung, Cursor als gefüllter Block in Bernstein.
- Innenabstand **12, 10, 12, 10**, kein Acryl, Deckkraft 100.
- `intenseTextStyle: all`: Fettes wird fett **und** heller (`#f5f1eb`), sonst ist es nicht von normalem Text zu unterscheiden.
- Fenster-Theme: aktiver Tab `panel`, Tableiste `rille`, dunkles App-Theme, kein Mica.

Die 16 ANSI-Farben liegen auf der Palette:

| ANSI | normal | hell |
|---|---|---|
| schwarz | `#2b2827` | `#6f6961` |
| rot | `#c07f73` Rosé | `#d69a8d` |
| grün | `#93a373` Salbei | `#adbb8e` |
| gelb | `#c7a854` Gold | `#ddc274` |
| blau | `#7d97ab` Stahl | `#9ab2c4` |
| magenta | `#b1899b` Malve | `#c9a3b4` |
| cyan | `#7fa79f` Petrol | `#9bc0b8` |
| weiß | `#a49c90` | `#f5f1eb` |

Grund `#1a1918`, Vordergrund `#e9e3d8`, Cursor `#cc9166`, Auswahl `#3a3634`.

**Einrichten:** Die Einstellungen des Windows Terminals als JSON öffnen und die drei Teile aus `terminal-workbench.json` einfügen: `scheme` unter `schemes`, `themeDef` unter `themes`, `defaults` nach `profiles.defaults`. Danach `"theme": "Workbench"` setzen.

### Profil

| Element | Farbe |
|---|---|
| Befehl | Bernstein |
| Parameter | Stahl |
| Variable | Salbei |
| Zeichenkette | Gold |
| Zahl | Petrol |
| Typ, Schlüsselwort | Malve |
| Kommentar, Vorhersage | `schwach` |
| Fehler | Rosé |
| Tabellenkopf | Bernstein, fett |
| Fehler / Warnungen | fette Schrift auf Rosé- bzw. Gold-Marker |
| Ordner | Bernstein, fett |
| Skripte und Programme | Salbei |
| Archive | Malve |
| Konfiguration (json, yaml, toml …) | Gold |
| Text (md, txt, log) | gedämpft |
| Bilder, PDF, Verknüpfungen | Petrol |

Der **Prompt** ist zweizeilig. Die erste Zeile zeigt den Pfad in Stahl (Home als `~`), den Git-Zweig in Salbei (sauber) oder Gold (Änderungen) und `admin` in Rosé, wenn die Sitzung erhöht läuft. Die zweite Zeile ist `❯` in Bernstein, nach einem Fehler in Rosé. Das Profil gibt selbst nichts aus, damit maschinell gelesene Ausgaben sauber bleiben.

**Einrichten:** PowerShell 7 muss Standardprofil im Windows Terminal sein. Unter Windows PowerShell 5.1 greift das Profil nicht.

```powershell
Copy-Item terminal\powershell\profile.ps1 $PROFILE.CurrentUserAllHosts
New-Item -ItemType Directory -Force ~\bin | Out-Null
Copy-Item terminal\powershell\wb.ps1 ~\bin\
```

### Farbhelfer `wb`

```powershell
wb band amber "Sicherung fertig, 52 von 52 Prüfungen bestanden"   # Hinweisband über die volle Breite
wb mark sage "erledigt"                                            # Textmarker (25 %)
wb mark -Dezent steel "Hinweis"                                    # dezenter Marker (14 %)
wb swatch                                                          # Palette anzeigen
```

Töne: `amber sage gold rose steel`. Die Bash-Fassung `wb.sh` kennt dieselben Unterkommandos. In der Git Bash unter Windows braucht sie `export LC_ALL=C.UTF-8`, sonst verschieben Umlaute und Geviertstriche die Bänder.

### Fallen

- Windows PowerShell 5.1 liest Skripte ohne BOM als ANSI. Skripte mit Umlauten als UTF-8 **mit** BOM speichern.
- `wb.ps1` aus der Git Bash (`pwsh -File …`) verliert Umlaute über die ANSI-Codepage. Aus der PowerShell aufrufen.
- Die Nerd Font erscheint erst nach einem Neustart des Terminals.

Mehr dazu: [`docs/terminal-und-powershell.md`](docs/terminal-und-powershell.md).

## Claude-Code-Design

Claude Code liest eigene Themes aus `~/.claude/themes/<name>.json` im Format `{ "name", "base", "overrides" }`. Das Workbench-Theme nutzt `base: "dark"` und setzt 50 der 72 Farbschlüssel. Der Rest kommt vom dunklen Basis-Theme. Claude Code überwacht den Ordner und lädt Änderungen sofort.

**Einrichten:**

```
terminal/claude-code/workbench.json  →  ~/.claude/themes/workbench.json
```

Dann in `~/.claude/settings.json`:

```json
"theme": "custom:workbench",
"verbose": true
```

`verbose: true` lässt Werkzeugausgaben aufgeklappt. Ohne die Einstellung faltet Claude Code jeden Farbblock aus `wb` zu einer einzeiligen Zusammenfassung, und man sieht ihn nie.

| Rolle in Claude Code | Schlüssel | Farbe |
|---|---|---|
| Text, gedämpft, schwach | `text` · `inactive` · `subtle` | `schrift` · `gedaempft` · `schwach` |
| Claude selbst, Maskottchen, Ratenbalken | `claude` · `clawd_body` · `rate_limit_fill` | Bernstein |
| Erfolg, Plan-Modus, hinzugefügte Wörter | `success` · `planMode` · `diffAddedWord` | Salbei |
| Fehler, entfernte Wörter | `error` · `diffRemovedWord` | Rosé |
| Warnung, Auto-Accept, Fast Mode | `warning` · `autoAccept` · `fastMode` | Gold |
| Berechtigungen, Skills, Bash-Rahmen, IDE, Vorschläge | `permission` · `skill` · `bashBorder` · `ide` · `suggestion` | Stahl |
| Diff-Zeilen | `diffAdded` · `diffRemoved` (+ `Dimmed`) | Textmarker Salbei / Rosé 25 % und 14 % |
| Nachrichtenhintergrund, Hover | `userMessageBackground` · `…Hover` | `panel` · `panel-2` |
| Schimmer-Animationen | `claudeShimmer` · `warningShimmer` · `permissionShimmer` | helleres Bernstein, Gold, Stahl |

Erlaubte Werte in einem Theme sind `#rrggbb`, `rgb(r,g,b)`, `ansi256(n)` und `ansi:<name>`. Mögliche Basen sind `dark`, `light`, `dark-daltonized`, `light-daltonized`, `dark-ansi` und `light-ansi`.

Mehr dazu: [`docs/claude-code.md`](docs/claude-code.md).

## Obsidian-Theme

Das Theme „Workbench“ ist aus [Soft Paper](https://github.com/nickmilo/soft-paper) 1.2.1 von Nick Milo abgeleitet. Layout, Abstände und die Style-Settings-Schalter stammen von Soft Paper. Farben und Schriften kommen aus Workbench.

| Element | Dunkel | Hell |
|---|---|---|
| Rahmen (Titelleiste, Reiterleisten, Trennlinien, Vault-Leiste) | Bernstein-Marker 25 % `#47372c`, Symbole Bernstein | `#d9c6b6`, Symbole `#975b34` |
| aktiver Seitenleisten-Reiter | `#1a1918`, Symbol Bernstein | `#efeae1` |
| Editor | `#1a1918` | `#efeae1` |
| Seitenleisten | `#151413` | `#ece6db` |
| Akzent (Tags, Auswahl, Zitatbalken) | Bernstein | Bernstein |
| Verweise | Stahl | Stahl |
| Überschriften | H1/H2 Bernstein · H3/H4 fett · H5/H6 gedämpft | ebenso |
| `==Markierung==` | Bernstein-Textmarker | Bernstein-Textmarker |
| übrige Ordner, Dateien im Wurzelordner | `#3a3634` | `#e2dbcf` |
| Schrift | Atkinson Hyperlegible Next, Code JetBrains Mono | ebenso |

**Hauptordner.** Bei fünf Ordnern der obersten Ebene ist die Titelzeile in voller Palettenfarbe gefüllt, mit dunkler Schrift (im hellen Theme mit heller). Der aufgeklappte Inhalt bleibt neutral.

| Ordner | Farbe |
|---|---|
| `00 Home` | Bernstein |
| `10 Inbox` | Salbei |
| `20 Projects` | Stahl |
| `30 Areas` | Gold |
| `40 Resources` | Petrol |

Die Farben hängen am Ordner**namen** (`data-path`, per `:has()`), nicht an der Position. Für eigene Namen die fünf Pfade in `obsidian_theme_bauen.py` ändern und neu bauen.

**Callouts** haben eine feste Bedeutung: `[!success]` Salbei, `[!important]` Bernstein, `[!warning]` Gold, `[!danger]` und `[!failure]` Rosé, `[!note]` und `[!info]` Stahl, `[!tip]` Petrol.

**Einrichten:**

1. `obsidian/Workbench/` nach `<Vault>/.obsidian/themes/Workbench/` kopieren.
2. Einstellungen → Darstellung → Themes → „Workbench“.
3. Unter Darstellung → Schrift das Feld für die Textschrift leer lassen, sonst übersteuert es Atkinson. Die Akzentfarbe auf `#cc9166` setzen.
4. Die Schriften kommen von Google Fonts. Wer das Theme offline nutzen will, installiert Atkinson Hyperlegible Next und JetBrains Mono lokal.

**Neu bauen** nach Änderungen am Bau-Skript (es liest Soft Paper und schreibt das Theme):

```
python obsidian/obsidian_theme_bauen.py "<Pfad>/Soft Paper/theme.css" "<Vault>/.obsidian/themes/Workbench"
```

Danach in Obsidian `Strg+R`. `theme.css` nie von Hand ändern, der nächste Bau überschreibt sie.

Mehr dazu: [`docs/obsidian.md`](docs/obsidian.md).

## Lizenz

- **Alles außer `obsidian/`:** [MIT](LICENSE).
- **`obsidian/`:** [GPL-3.0](obsidian/LICENSE). Das Theme ist abgeleitet aus [Soft Paper](https://github.com/nickmilo/soft-paper) von Nick Milo, das auf [AnuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin) von Anubis beruht. Beide stehen unter GPL-3.0.
- **Schriften** sind nicht enthalten. Atkinson Hyperlegible Next und JetBrains Mono stehen unter der SIL Open Font License 1.1.
