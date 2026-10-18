<!-- diagram-design-profile
name: Workbench
slug: workbench
source-url: https://github.com/faf-net/workbench
created: 2026-10-18
updated: 2026-10-18
notes: Workbench, Werte aus tokens/tokens.json
-->
# Style Guide

**The single source of truth for colors, typography, and tokens.** This is the house style **Workbench**, named after the Amiga 500 operating system. Values come from `tokens/tokens.json` in this repository. If they change, update this profile from them, never from memory.

## Workbench overrides (read first)

This profile deliberately departs from SKILL.md in four places. For diagrams rendered with this profile, **this section wins over SKILL.md and its pre-output checklist**:

1. **Three families, Workbench edition**. Instrument Serif for the title and italic callouts, as the plugin intends. Atkinson Hyperlegible Next (not Geist) for node names. JetBrains Mono (not Geist Mono) for every technical label. The checklist items "Human-readable names in Geist sans?" and "No JetBrains Mono anywhere?" are replaced by: names in Atkinson, mono only for technical content and labels, and that mono is JetBrains Mono. "Page title in Instrument Serif?" and "Callouts in italic Instrument Serif?" stay as written.
2. **Dark is the primary skin.** Default to the dark column; light is for print and for explicit requests. Printed output always uses the light values.
3. **Language: German** with real umlauts (ä ö ü ß, never ae/oe/ue/ss). Numbers German: `1.740`, `4,5`, dates `18.10.2026`. No emoji.
4. **Color never decides alone.** Every status-colored node also carries a word. Salbei and Rosé are nearly indistinguishable under deuteranopia.

5. **Templates carry the shipped hex values.** `assets/template*.html` hard-code `#2d3142`, `#f5f5f5`, `#f08a59`, Geist and Instrument Serif in `:root`, the font `<link>`, the markers and the background rect. Replace every one with the values below; SKILL.md's "opaque `fill=\"#f5f5f5\"` rect" means `paper` here.
6. **Label masks match the surface they sit on.** Inside a zone (`ink @ 0.02` over `paper`) a mask in plain `paper` shows as a dark patch. Use the composited zone color: dark `#1e1d1c`, light `#ebe6dd`. Tested 18.10.2026.
7. **In a claude.ai Artifact the diagram follows the viewer's theme.** Do not hard-code fills: give SVG elements classes whose `fill`/`stroke` read Workbench CSS tokens, dark values on bare `:root`, light values under `prefers-color-scheme: light` (guarded `:root:not([data-theme="dark"])`) and again under `:root[data-theme="light"]`. Markers too. Leave out ports and IP addresses (external output).

Do not customize this profile from a website (onboarding). It is maintained by hand from the design system.

---

## Tokens

### Semantic roles

| Role | Purpose | Default (light) | Default (dark) |
|---|---|---|---|
| `paper` | Page background, default node fill | `#efeae1` (grund) | `#1a1918` (grund) |
| `paper-2` | Diagram container bg, secondary fill | `#f7f3ec` (panel) | `#232120` (panel) |
| `ink` | Primary text, primary stroke | `#2a2724` (schrift) | `#e9e3d8` (schrift) |
| `ink-strong` | High-contrast text on warm accent fills | `#f7f3ec` (on-bernstein) | `#1a1918` (on-bernstein) |
| `muted` | Secondary text, default arrow stroke | `#6a6258` (gedaempft) | `#a49c90` (gedaempft) |
| `soft` | Sublabels, boundary labels | `#6a6258` (gedaempft) | `#a49c90` (gedaempft) |
| `rule` | Hairline borders | `#d3cabb` (linie) | `#3a3634` (linie) |
| `rule-solid` | Stronger borders, baselines | `#8b8377` (schwach) | `#6f6961` (schwach) |
| `accent` | Focal / 1–2 max per diagram | `#975b34` (bernstein) | `#cc9166` (bernstein) |
| `accent-tint` | Fill for accent-bordered boxes | `#ddcdbe` (dezent-bernstein) | `#3e3128` (dezent-bernstein) |
| `link` | HTTP/API calls, external arrows | `#456579` (stahl) | `#7d97ab` (stahl) |

> **Workbench mapping notes.** Workbench has exactly one secondary text color, `gedaempft`, so `muted` and `soft` share it. `schwach` is **never text** (3,2 : 1); here it is only `rule-solid` for lines and baselines. Light `bernstein` reaches 4,5 : 1 on `grund` and `panel` but not on darker surfaces: never set light accent text on `accent-tint`. `ink-strong` sits on accent fills, so it flips with the skin (light text on dark-ish light-skin bernstein, dark text on bright dark-skin bernstein). **Light skin: an accent fill that carries text is solid (opacity 1.0), not 0.85.** On the full fill `on-bernstein` reaches 4,92 : 1; on the plugin's usual 0.85 fill no Workbench text color reaches 4.5:1 (best 4,34 : 1). `verify-contrast.py` therefore reports one known finding for light `ink-strong`; it is accepted under this rule. Dark skin passes at 0.85 (5,07 : 1).

### Workbench status tones (opt-in, for status words only)

Use these only when a node carries a state word (OK, WARNUNG, FEHLER, LÄUFT). They are not focal and do not replace `accent`. Text on a tone fill uses the `status-*` color; the fill is the `pille-*` value.

| Tone | Meaning | Line (light / dark) | Fill `pille-*` (light / dark) | Word `status-*` (light / dark) |
|---|---|---|---|---|
| `salbei` | gut, in Ordnung | `#5e7040` / `#93a373` | `#c3c5b1` / `#3e4233` | `#485530` / `#adbb8e` |
| `gold` | Achtung, geschätzt | `#7e6820` / `#c7a854` | `#cdc3a7` / `#4e442a` | `#5f4e18` / `#ddc274` |
| `rose` | kritisch (written „Rosé“) | `#9c4d40` / `#c07f73` | `#d6bbb1` / `#4c3833` | `#7a3c32` / `#d69a8d` |
| `stahl` | neutral, Daten | `#456579` / `#7d97ab` | `#bcc2c2` / `#383f44` | `#385262` / `#9ab2c4` |
| `bernstein` | läuft, das Wichtigste | `#975b34` / `#cc9166` | `#d5bfad` / `#4f3d2f` | `#734528` / `#e0a87f` |

### Contrast contract

Every token must clear the threshold for each role it plays, against the background it actually sits on, in both skins. `scripts/verify-contrast.py --style-guide <this file>` checks it.

| Use | Minimum vs. its actual background |
|---|---|
| Regular text, including any `soft`, `link`, or `accent` used as text | 4.5:1 |
| Large text (24px+, or 18.7px+ at weight 600+) | 3:1 |
| Essential non-text marks: lines, arrows, borders, focus outlines, data points | 3:1 against the adjacent color |
| Decorative rules and translucent tints (`rule`, `rule-solid`, `paper-2`, `accent-tint`, fills at opacity) | No minimum, but never the only carrier of meaning |

### Inversion rule (light → dark)

Workbench gives explicit hex values for both skins; use the matching column instead of flipping RGB. Opacities stay the same.

### Series palette (multi-series chart types only)

Workbench allows **at most four series including the focal one**: `accent` (bernstein) is series one, then the tokens below in order. Label series directly instead of a legend. Never use petrol and malve in the same diagram.

| Token | Light | Dark | Notes |
|---|---|---|---|
| `series-1` | `#456579` (stahl) | `#7d97ab` | diagramm-2 |
| `series-2` | `#4e716a` (petrol) | `#7fa79f` | diagramm-3 |
| `series-3` | `#7e6820` (gold) | `#c7a854` | diagramm-4 |
| `series-4` | `#5e7040` (salbei) | `#93a373` | Only if unavoidable; exceeds the four-series rule |
| `series-5` | `#6a6258` (gedaempft) | `#a49c90` | Only if unavoidable; exceeds the four-series rule |

Fills sit at `0.18` opacity light, `0.22` dark; strokes use the full color. **Don't backfill these tokens to non-chart types.**

### Terminal skin (opt-in alternate)

Mapped onto Workbench dark, so a terminal window looks like a real Workbench terminal.

| Token | Hex | Purpose |
|---|---|---|
| `terminal-page` | `#151413` | Page background behind the window (rille) |
| `terminal-paper` | `#1a1918` | Window body, node fill (grund) |
| `terminal-bar` | `#2b2827` | Titlebar strip (panel-2) |
| `terminal-border` | `#3a3634` | Window border, hairlines (linie) |
| `terminal-ink` | `#e9e3d8` | Primary text, primary stroke (schrift) |
| `terminal-muted` | `#a49c90` | Secondary text, sublabels (gedaempft) |
| `terminal-soft` | `#6f6961` | Tertiary, inactive dots, spokes; never text (schwach) |
| `terminal-accent` | `#cc9166` | The one accent (bernstein) |
| `terminal-accent-tint` | `#3e3128` | Fill for accent-bordered boxes (dezent-bernstein) |

**1-accent rule still holds.**

---

## Typography

| Role | Family | Size | Weight | Usage |
|---|---|---|---|---|
| `title` | Instrument Serif | 1.75rem | 400 | Page H1, color `fett` (`#f5f1eb` dark / `#171512` light) |
| `node-name` | Atkinson Hyperlegible Next (sans) | 12px | 600 | Human-readable labels |
| `sublabel` | JetBrains Mono | 9px | 400 | Port, protocol, URL, field type |
| `eyebrow` | JetBrains Mono | 7–8px | 500, tracked 0.18em, uppercase | Type tags, axis labels |
| `arrow-label` | JetBrains Mono | 8px | 400, tracked 0.06em | Arrow annotations |
| `callout` | Instrument Serif *italic* | 14px | 400 | Editorial asides only |

Font stacks: serif `"Instrument Serif", Georgia, serif` · sans `"Atkinson Hyperlegible Next", "Segoe UI", system-ui, sans-serif` · mono `"JetBrains Mono", "JetBrainsMono Nerd Font", ui-monospace, Consolas, monospace`. Numbers in mono use `font-variant-numeric: tabular-nums`.

### Font stack

```html
<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Atkinson+Hyperlegible+Next:ital,wght@0,400;0,600;0,700;0,800;1,400&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
```

### Font source

Font source: `web`

| Value | What ships | Network |
|---|---|---|
| `web` (default) | The Google Fonts `<link>` above; text renders in Instrument Serif, Atkinson Hyperlegible Next and JetBrains Mono | One stylesheet request to `fonts.googleapis.com`, plus the font files |
| `system` | No font `<link>`; stacks fall through to Segoe UI / Consolas or the installed faces | None |

In `system` mode omit the `<link>` and keep the stacks; where JetBrains Mono is installed locally, it still resolves.

### Non-Latin labels

Atkinson Hyperlegible Next and JetBrains Mono cover Latin including all German characters. For Korean, Chinese or Cyrillic labels follow the pristine guide's rules with the Workbench families in front.

**Load-bearing rule:** Mono is for *technical* content and labels (ports, commands, paths, field types, eyebrows, arrow labels). Names go in Atkinson sans. Title is Instrument Serif; italic Instrument Serif only for callouts.

---

## Stroke, radius, spacing

| Token | Value | Use |
|---|---|---|
| `stroke-thin` | `0.8` | Tag-box outlines, leaf nodes |
| `stroke-default` | `1` | Most strokes |
| `stroke-strong` | `1.2` | Emphasis strokes |
| `radius-sm` | `3` | Small tags (ecke-marker) |
| `radius-md` | `6` | Node boxes (ecke-karte) |
| `radius-lg` | `6` | Containers (ecke-karte; Workbench has no larger corner) |
| `grid` | `4` | Every coord, size, and gap is divisible by 4 (hard rule) |

No shadows on nodes or cards. Depth comes from the surface levels `paper` → `paper-2` and the `rule` line.

---

## Node type → treatment

| Type | Fill | Stroke |
|---|---|---|
| `focal` (1–2 max) | `accent-tint` | `accent` |
| `backend` | `paper-2` (panel) | `ink` |
| `store` | `ink @ 0.05` | `muted` |
| `external` | `ink @ 0.03` | `ink @ 0.30` |
| `input` | `muted @ 0.10` | `soft` |
| `optional` | `ink @ 0.02` | `ink @ 0.20` dashed `4,3` |
| `security` | `accent @ 0.05` | `accent @ 0.50` dashed `4,4` |

---

## Customizing the skin

Maintained by hand from the Workbench design system. Do not run onboarding over it.

### Constraints (don't break these)

- **Warm ground**: `paper` is `#1a1918` / `#efeae1`, never neutral grey or pure white.
- **One accent**: bernstein only. Everything else recedes.
- **One family of tones**: muted, earthy, no neon, no pure red/green/blue.
- **At most two emphasis levels per diagram** (for example `accent` plus one status tone).
- **Dot pattern off**, **container clean** by default, as in the pristine guide.
