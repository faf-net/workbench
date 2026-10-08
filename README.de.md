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

### Obsidian

Den Ordner `obsidian/Workbench/` nach `<Vault>/.obsidian/themes/` kopieren, dann unter Einstellungen → Darstellung → Themes „Workbench“ wählen. Die fünf Hauptordner sind nach Namen eingefärbt (`00 KONTEXT` bis `40 RESOURCEN`). Für andere Namen in `obsidian_theme_bauen.py` anpassen und neu bauen:

```
python obsidian/obsidian_theme_bauen.py "<Pfad>/Soft Paper/theme.css" "<Vault>/.obsidian/themes/Workbench"
```

### Windows Terminal, PowerShell, Claude Code

Vorlagen in [`terminal/`](terminal/). Einzelheiten zu Schema, Prompt, Dateifarben und Farbhelfern in [`docs/terminal-und-powershell.md`](docs/terminal-und-powershell.md), zum Claude-Code-Theme in [`docs/claude-code.md`](docs/claude-code.md).

### Word, Excel, PowerPoint

Designfarben, Formatvorlagen und Folienaufbau in [`docs/office.md`](docs/office.md). Die Werte gelten auch für OnlyOffice und LibreOffice.

## Lizenz

- **Alles außer `obsidian/`:** [MIT](LICENSE).
- **`obsidian/`:** [GPL-3.0](obsidian/LICENSE). Das Theme ist abgeleitet aus [Soft Paper](https://github.com/nickmilo/soft-paper) von Nick Milo, das auf [AnuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin) von Anubis beruht. Beide stehen unter GPL-3.0.
- **Schriften** sind nicht enthalten. Atkinson Hyperlegible Next und JetBrains Mono stehen unter der SIL Open Font License 1.1.
