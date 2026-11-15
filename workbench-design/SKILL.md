---
name: workbench-design
description: Apply the Workbench house style (warm dark ground, one amber accent, muted earthy tones) to web pages, dashboards, HTML reports, artifacts and terminal output. Use whenever something should look like Workbench or is asked for "in Workbench", and before choosing any colour, font or spacing for such output.
---

# Workbench design

Workbench is a personal design system named after the operating system of the Amiga 500. It looks like an old instrument panel: a warm dark ground, a single loud accent in amber, and every other tone earthy and restrained.

## Where the values are

Installed as a skill, these files sit next to this one. In the repository `faf-net/workbench` they are at the path in brackets.

| File | Content |
|---|---|
| `tokens.json` (`tokens/tokens.json`) | every colour, type, spacing and radius token, dark and light. **The source.** |
| `workbench.css` (`css/workbench.css`) | the tokens as CSS custom properties (`--grund`, `--bernstein`, …), dark by default, light through `prefers-color-scheme` or `data-theme="light"` |
| `workbench-components.css` (`components/workbench-components.css`) | component classes `.wb-*` |
| `components.md` (`components/README.md`) | guide for each component with markup (German) |
| `grundlagen.md` (`docs/grundlagen.md`) | the full rules (German) |

**Read `tokens.json` before you write a value. Never take a hex value from memory**, not even from the short table below; it is there to orient you.

## The rules

1. **The ground is warm.** `grund` `#1a1918`, never a neutral `#1e1e1e`.
2. **One loud accent.** Only `bernstein` may be loud: the cursor, a heading, the one thing that matters. A main button in amber appears at most once per area.
3. **One family.** Muted and earthy. No neon, no pure red, green or blue.
4. **Colour never decides on its own.** Every status surface carries a word. Sage and rosé are hard to tell apart with red-green colour blindness.
5. **At most two levels of emphasis per screen.** The levels, rising: `gedaempft` · `schrift` · `fett` · `bernstein` · text marker.
6. **Depth comes from surfaces and lines, not from shadows.** Three levels `grund` → `panel` → `panel-2`, separated by `linie`. Cards have no shadow.
7. **Say whether a number is measured or estimated.** A chart looks more precise than its data.

## Glossary

| Token | Meaning | Dark | Light |
|---|---|---|---|
| `grund` | page and terminal background | `#1a1918` | `#efeae1` |
| `panel`, `panel-2` | cards; card headers | `#232120`, `#2b2827` | `#f7f3ec`, `#ece6db` |
| `linie` | borders, dividers | `#3a3634` | `#d3cabb` |
| `rille` | empty part of bars and gauges | `#151413` | `#e2dbcf` |
| `schrift` | body text | `#e9e3d8` | `#2a2724` |
| `gedaempft` | secondary text and all labels | `#a49c90` | `#6a6258` |
| `schwach` | lines and disabled things only, **never text** | `#6f6961` | `#8b8377` |
| `fett` | bold text, text on a strong marker | `#f5f1eb` | `#171512` |
| `bernstein` | amber: the one accent, "running" | `#cc9166` | `#975b34` |
| `salbei` | sage: good, done | `#93a373` | `#5e7040` |
| `gold` | gold: caution, open, estimated | `#c7a854` | `#7e6820` |
| `rose` | rosé: critical, error | `#c07f73` | `#9c4d40` |
| `stahl` | steel: neutral, data, links | `#7d97ab` | `#456579` |
| `petrol`, `malve` | side tones for code and a third data series; never together in one chart | | |

Tinted surfaces are fixed hex values in the tokens, not opacity: `dezent-*` (20 %, quiet marker, text `schrift`), `marker-*` (25 %, strong marker, text `fett`), `pille-*` (30 %, status pill, word in `status-*`), `band-*` (33 %, full-width banner, text `fett`).

## Type, grid, shapes

- **Instrument Serif** for page and section titles and, in italics, for annotations. Weight 400 only. Never for body text, controls or numbers.
- **Atkinson Hyperlegible Next** for sub-headings, text, names and controls.
- **JetBrains Mono** for code, commands, paths, numbers in tables and all labels, with `tabular-nums`. Only for technical content.
- Sizes: serif 40 / 28 / 16 italic; sans 19 bold / 15 / 13, pill 12 in capitals, button 15 bold; mono 13, label 11 in capitals with 0.18em tracking, large number 34.
- Spacing on a grid of 4: 4 · 8 · 12 · 16 · 24 · 32 · 48 px.
- Corners 6 px for cards, 3 px for markers and buttons. Round only for the switch track. The status pill is flat with a 3 px edge bar in the full tone on the left and 3 px corners on the right.
- Focus: a solid 2 px ring in `stahl` with 2 px offset.

## Components

Load both stylesheets, then use the classes. Markup for every component is in `components.md`.

```html
<link rel="stylesheet" href="workbench.css">
<link rel="stylesheet" href="workbench-components.css">

<div class="wb-band">Key message across the full width</div>
<span class="wb-status wb-status--gut">free</span>
<span class="wb-mark">Key result</span>
<button class="wb-knopf wb-knopf--haupt">Start backup</button>
```

Available: banner `.wb-band`, text marker `.wb-mark`, status pill `.wb-status`, host card `.wb-host`, segmented bar `.wb-balken`, measurement table `.wb-mess` with origin tags `.wb-herkunft`, chart `.wb-diagramm`, button `.wb-knopf`, input `.wb-feld`, switch `.wb-schalter`, tabs `.wb-reiter`, toast `.wb-meldung`, empty state `.wb-leer`, floating element `.wb-schwebend`.

For a page that must work as a single file, copy the custom properties and the classes you use inline instead of linking.

## Charts and diagrams

- One series: `diagramm-reihe` (steel), the one highlighted value in `diagramm-hervorhebung` (amber).
- Several series: `diagramm-1` to `diagramm-4` (amber · steel · petrol · gold), at most four, labelled directly at the series instead of a legend.
- Architecture, flow, sequence and similar diagrams: use the plugin diagram-design with the profile `workbench` (folder `diagram-design/` in the repository).
- Pictures made of characters: use the skill `textgrafik` (folder `textgrafik/`).

## Light theme and print

- Light is complete, not an afterthought. In the light theme `bernstein` and `gold` reach 4.5 : 1 on `grund` and `panel` but not on `panel-2`; do not use them as text there.
- Print is always light. Tinted surfaces need `print-color-adjust: exact`. No shadow, glow or animation on paper.

## Terminal

Use the colour helper instead of your own escape codes: `wb.sh` (Bash) or `wb.ps1` (PowerShell) from `terminal/` in the repository, with `band`, `mark`, `status` and `swatch` and the tones `amber sage gold rose steel`. In a terminal the status pill takes the console form `[ SAVED ]`.

## Do not

- mix Workbench tones into work that has its own corporate design,
- use `schwach` for readable text,
- put amber on more than one or two things per screen,
- use rounded pills, drop shadows on cards, gradients as decoration or emoji,
- let a colour carry meaning without a word.

## Check before you show it

1. Every value traces back to `tokens.json`.
2. One amber accent, at most two levels of emphasis.
3. Every status has a word.
4. Dark and light both render; text contrast is at least 4.5 : 1.
5. Numbers say measured or estimated.
6. Look at the rendered result, not only at the code.
