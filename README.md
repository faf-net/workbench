# Workbench

**English** · [Deutsch](README.de.md)

**A personal design system in warm, muted colours for the terminal, the web, office documents and Obsidian.**

The name comes from the operating system of the **Amiga 500**. Workbench looks like an old instrument panel: a warm dark ground, a single loud accent in amber, and every other tone earthy and restrained.

![Workbench components in the dark theme](assets/vorschau.png)

Version **1.0** · 9 October 2026

---

## The three rules

1. **The ground is warm.** `#1a1918`, never a neutral `#1e1e1e`.
2. **One loud accent.** Only amber (*Bernstein*) `#cc9166` may be loud. Everything else steps back.
3. **One family.** Muted and earthy. No neon, no pure red, green or blue.

And one more: **colour never decides on its own.** Every status indicator carries a word, because sage and rosé are hard to tell apart for people with red-green colour blindness.

## The palette

Token names are German. They are listed here with their English meaning.

| Token | Dark | Light | Meaning |
|---|---|---|---|
| `grund` (ground) | `#1a1918` | `#efeae1` | page background |
| `panel` | `#232120` | `#f7f3ec` | cards, surfaces |
| `linie` (line) | `#3a3634` | `#d3cabb` | borders, dividers |
| `schrift` (text) | `#e9e3d8` | `#2a2724` | body text |
| `gedaempft` (muted) | `#a49c90` | `#6a6258` | secondary text, labels |
| `fett` (bold) | `#f5f1eb` | `#171512` | bold text, text on markers |
| **`bernstein`** (amber) | `#cc9166` | `#975b34` | the one accent, what matters most |
| `salbei` (sage) | `#93a373` | `#5e7040` | good, done |
| `stahl` (steel) | `#7d97ab` | `#456579` | neutral, data, links |
| `gold` | `#c7a854` | `#7e6820` | caution, estimated |
| `rose` (rosé) | `#c07f73` | `#9c4d40` | critical, error |
| `petrol` | `#7fa79f` | `#4e716a` | secondary tone, third data series |
| `malve` (mauve) | `#b1899b` | `#8c5c72` | secondary tone, code |

All 68 tokens live in [`tokens/tokens.json`](tokens/tokens.json). That includes text markers (25 %), subtle markers (20 %), banners (33 %), status pill fills (30 %) and status tones. Every token has a usage note with contrast ratios. The notes and the documentation in `docs/` are written in German.

## Type, grid, shapes

- **Instrument Serif** for page and section titles, and in italics for annotations. Weight 400 only; emphasis comes from size and the bold text colour.
- **Atkinson Hyperlegible Next** for subheadings, body text, names and controls, designed for legibility (I, l and 1 are clearly distinct).
- **JetBrains Mono** for code, numbers and labels, and only for technical content.
- **4 px grid:** 4 · 8 · 12 · 16 · 24 · 32 · 48 px.
- **Corners:** 6 px for cards, 3 px for markers, buttons and the right side of status pills. Only the switch track is fully round.
- **Status pill:** flat, 30 % fill, a 3 px edge bar in the full tone on the left, square left corners, 3 px on the right, the word in capitals. In terminals and on status displays it takes the console form `[ BACKED UP ]`: brackets muted, word bold in the status tone, no fill. Printing always uses the light values with print-color-adjust: exact.
- **Depth** comes from surface layers instead of shadows. Only floating elements get a shadow.
- **Charts:** a single series in steel, with the value that matters in amber. Multiple series in amber · steel · petrol · gold, at most four, labelled directly.

## Contents

```
tokens/tokens.json                    all tokens, dark and light (the source)
css/workbench.css                     CSS custom properties, generated from the tokens
components/workbench-components.css   components: banner, text marker, status pill,
                                      host card, bar, measurement table, chart, menu,
                                      button, input, switch, tabs, toast, empty state
components/README.md                  guide for each component (German)
examples/bausteine.html               every component on one page, dark and light
diagram-design/                       profile and installers for the diagram-design plugin
docs/                                 basics, office, Obsidian, terminal, Claude Code (German)
assets/                               "wb" monogram, lockup with wordmark, favicon,
                                      app icons 180/192/512 (rules in assets/README.md)
obsidian/                             Obsidian theme "Workbench" (GPL-3.0, see below)
terminal/                             Windows Terminal, PowerShell profile, wb.ps1, wb.sh,
                                      Claude Code theme
```

## Usage

### On the web

```html
<link rel="stylesheet" href="css/workbench.css">
<link rel="stylesheet" href="components/workbench-components.css">

<div class="wb-band">Key message across the full width</div>
<span class="wb-status wb-status--gut">free</span>
<button class="wb-knopf wb-knopf--haupt">Start backup</button>
<span class="wb-mark">Key result</span>
```

Dark is the default. Light switches on through `prefers-color-scheme`, or explicitly with `data-theme="light"` on the `<html>` element.

### Word, Excel, PowerPoint

Theme colours, paragraph styles and slide layout are in [`docs/office.md`](docs/office.md). The values also apply to OnlyOffice and LibreOffice.

## PowerShell design

The PowerShell look has four layers. Each one works on its own, together they give the full picture.

| Layer | What | File |
|---|---|---|
| Font | **JetBrainsMono Nerd Font Mono**, installed per user. Without it the prompt shows boxes instead of folder, git and admin glyphs | not included, [nerdfonts.com](https://www.nerdfonts.com/) |
| Terminal | colour scheme and window theme "Workbench" for Windows Terminal | `terminal/windows-terminal/terminal-workbench.json` |
| Profile | syntax colours, output colours, file colours, prompt | `terminal/powershell/profile.ps1` |
| Helper | `wb` for text markers and banners in your own scripts | `terminal/powershell/wb.ps1`, `terminal/bash/wb.sh` |

### Windows Terminal

- Font JetBrainsMono Nerd Font Mono **11 pt**, grayscale antialiasing, cursor as a filled block in amber.
- Padding **12, 10, 12, 10**, no acrylic, opacity 100.
- `intenseTextStyle: all`: bold text becomes bold **and** brighter (`#f5f1eb`), otherwise it cannot be told apart from normal text.
- Window theme: active tab `panel`, tab row `rille`, dark application theme, no Mica.

The 16 ANSI colours map onto the palette:

| ANSI | normal | bright |
|---|---|---|
| black | `#2b2827` | `#6f6961` |
| red | `#c07f73` rosé | `#d69a8d` |
| green | `#93a373` sage | `#adbb8e` |
| yellow | `#c7a854` gold | `#ddc274` |
| blue | `#7d97ab` steel | `#9ab2c4` |
| magenta | `#b1899b` mauve | `#c9a3b4` |
| cyan | `#7fa79f` petrol | `#9bc0b8` |
| white | `#a49c90` | `#f5f1eb` |

Background `#1a1918`, foreground `#e9e3d8`, cursor `#cc9166`, selection `#3a3634`.

**Install:** open the Windows Terminal settings as JSON and merge the three parts of `terminal-workbench.json`. Add `scheme` to `schemes`, add `themeDef` to `themes`, and copy `defaults` into `profiles.defaults`. Then set `"theme": "Workbench"`.

### Profile

| Element | Colour |
|---|---|
| command | amber |
| parameter | steel |
| variable | sage |
| string | gold |
| number | petrol |
| type, keyword | mauve |
| comment, prediction | `schwach` |
| error | rosé |
| table header | amber, bold |
| errors / warnings | bold text on rosé / gold marker |
| folders | amber, bold |
| scripts and executables | sage |
| archives | mauve |
| configuration (json, yaml, toml …) | gold |
| text (md, txt, log) | muted |
| images, PDF, links | petrol |

The **prompt** has two lines. The first shows the path in steel (home as `~`), the git branch in sage (clean) or gold (changes), and `admin` in rosé when elevated. The second line is `❯` in amber, or in rosé after a failed command. The profile prints nothing on its own, so output that other tools read stays clean.

**Install:** PowerShell 7 must be the default profile in Windows Terminal, Windows PowerShell 5.1 does not apply the profile.

```powershell
Copy-Item terminal\powershell\profile.ps1 $PROFILE.CurrentUserAllHosts
New-Item -ItemType Directory -Force ~\bin | Out-Null
Copy-Item terminal\powershell\wb.ps1 ~\bin\
```

### Colour helper `wb`

```powershell
wb band amber "Backup finished, 52 of 52 checks passed"   # banner across the full width
wb mark sage "done"                                        # text marker (25 %)
wb mark -Dezent steel "note"                               # subtle marker (20 %)
wb status sage "backed up"                                 # status in console form: [ BACKED UP ]
wb swatch                                                  # show the palette
```

Tones: `amber sage gold rose steel`. The Bash version `wb.sh` has the same subcommands. In Git Bash on Windows it needs `export LC_ALL=C.UTF-8`, otherwise umlauts and dashes break the alignment of banners.

### Pitfalls

- Windows PowerShell 5.1 reads scripts without a BOM as ANSI. Save scripts with umlauts as UTF-8 **with** BOM.
- Calling `wb.ps1` from Git Bash (`pwsh -File …`) loses umlauts through the ANSI code page. Call it from PowerShell.
- The Nerd Font only appears after restarting the terminal.

More detail (German): [`docs/terminal-und-powershell.md`](docs/terminal-und-powershell.md).

## Claude Code design

Claude Code reads custom themes from `~/.claude/themes/<name>.json` in the format `{ "name", "base", "overrides" }`. The Workbench theme uses `base: "dark"` and sets 50 of the 72 colour keys. Everything else comes from the dark base theme. Claude Code watches the folder and reloads changes immediately.

**Install:**

```
copy terminal/claude-code/workbench.json  →  ~/.claude/themes/workbench.json
```

Then add this to `~/.claude/settings.json`:

```json
"theme": "custom:workbench",
"verbose": true
```

`verbose: true` keeps tool output expanded. Without it, Claude Code folds every coloured block from `wb` into a one-line summary and you never see it.

| Role in Claude Code | Keys | Colour |
|---|---|---|
| text, muted, faint | `text` · `inactive` · `subtle` | `schrift` · `gedaempft` · `schwach` |
| Claude itself, mascot, rate bar | `claude` · `clawd_body` · `rate_limit_fill` | amber |
| success, plan mode, added words | `success` · `planMode` · `diffAddedWord` | sage |
| error, removed words | `error` · `diffRemovedWord` | rosé |
| warning, auto-accept, fast mode | `warning` · `autoAccept` · `fastMode` | gold |
| permissions, skills, bash border, IDE, suggestions | `permission` · `skill` · `bashBorder` · `ide` · `suggestion` | steel |
| diff lines | `diffAdded` · `diffRemoved` (+ `Dimmed`) | sage / rosé text markers 25 % and 14 % |
| message background, hover | `userMessageBackground` · `…Hover` | `panel` · `panel-2` |
| shimmer animations | `claudeShimmer` · `warningShimmer` · `permissionShimmer` | lighter amber, gold, steel |

Allowed values in a theme are `#rrggbb`, `rgb(r,g,b)`, `ansi256(n)` and `ansi:<name>`. Possible bases are `dark`, `light`, `dark-daltonized`, `light-daltonized`, `dark-ansi` and `light-ansi`.

More detail (German): [`docs/claude-code.md`](docs/claude-code.md).

## Diagrams

I draw architecture sketches, flows, sequences, timelines and about 40 other diagram types with the Claude Code plugin [diagram-design](https://github.com/cathrynlavery/diagram-design) by Cathryn Lavery (MIT). It writes one self-contained HTML file with inline SVG and takes its colours and fonts from a swappable profile. [`diagram-design/workbench.md`](diagram-design/workbench.md) is that profile for Workbench, and I use it on every machine that runs Claude Code.

**Install:**

```
bash diagram-design/install.sh                          # Linux, macOS, Git Bash
pwsh -File diagram-design/Install-DiagramDesign.ps1     # Windows
```

The scripts install the plugin, keep the shipped style guide as `~/.diagram-design/profiles/default.md` and make `workbench` the active profile. Then run `/reload-plugins` in Claude Code. Run the script again after every plugin update, because an update replaces the bundled style guide.

The profile maps the plugin's roles onto Workbench: paper is `grund`, ink is `schrift`, the one accent is amber, links are steel, and extra series are steel · petrol · gold. Titles use Instrument Serif, names Atkinson Hyperlegible Next, labels JetBrains Mono. The plugin's checklist bans JetBrains Mono because generic diagrams use it for everything. Here it only sets technical labels, which is where the plugin wants a monospace face anyway. Dark is the main theme, print uses the light values.

More detail (German): [`diagram-design/README.md`](diagram-design/README.md).

## Obsidian theme

The theme "Workbench" is derived from [Soft Paper](https://github.com/nickmilo/soft-paper) 1.2.1 by Nick Milo. Layout, spacing and the Style Settings toggles come from Soft Paper. Colours and fonts come from Workbench.

| Element | Dark | Light |
|---|---|---|
| frame (title bar, tab bars, dividers, vault bar) | amber marker 25 % `#47372c`, icons amber | `#d9c6b6`, icons `#975b34` |
| active sidebar tab | `#1a1918`, icon amber | `#efeae1` |
| editor | `#1a1918` | `#efeae1` |
| sidebars | `#151413` | `#ece6db` |
| accent (tags, selection, quote bar) | amber | amber |
| links | steel | steel |
| headings | H1/H2 amber · H3/H4 bold · H5/H6 muted | same |
| `==highlight==` | amber text marker | amber text marker |
| other folders, files in the vault root | `#3a3634` | `#e2dbcf` |
| font | Atkinson Hyperlegible Next, code JetBrains Mono | same |

**Main folders.** The title row of five top-level folders is filled with a full palette colour, with dark text (light text in the light theme). Their open contents stay neutral.

| Folder | Colour |
|---|---|
| `00 Home` | amber |
| `10 Inbox` | sage |
| `20 Projects` | steel |
| `30 Areas` | gold |
| `40 Resources` | petrol |

The colours are tied to the folder **names** (`data-path`, via `:has()`), not to their position. To use your own names, edit the five paths in `obsidian_theme_bauen.py` and rebuild.

**Callouts** keep a fixed meaning: `[!success]` sage, `[!important]` amber, `[!warning]` gold, `[!danger]` and `[!failure]` rosé, `[!note]` and `[!info]` steel, `[!tip]` petrol.

**Install:**

1. Copy `obsidian/Workbench/` to `<vault>/.obsidian/themes/Workbench/`.
2. Settings → Appearance → Themes → "Workbench".
3. Leave the text font empty under Settings → Appearance → Font, otherwise it overrides Atkinson. Set the accent colour to `#cc9166`.
4. The fonts load from Google Fonts. To use the theme offline, install Atkinson Hyperlegible Next and JetBrains Mono locally.

**Rebuild** after changing the build script (it reads Soft Paper and writes the theme):

```
python obsidian/obsidian_theme_bauen.py "<path>/Soft Paper/theme.css" "<vault>/.obsidian/themes/Workbench"
```

Then press `Ctrl+R` in Obsidian. Do not edit `theme.css` by hand, the next build overwrites it.

More detail (German): [`docs/obsidian.md`](docs/obsidian.md).

## Licence

- **Everything except `obsidian/`:** [MIT](LICENSE).
- **`obsidian/`:** [GPL-3.0](obsidian/LICENSE). The theme is derived from [Soft Paper](https://github.com/nickmilo/soft-paper) by Nick Milo, which builds on [AnuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin) by Anubis. Both are licensed under GPL-3.0.
- **Fonts** are not included. Instrument Serif, Atkinson Hyperlegible Next and JetBrains Mono are licensed under the SIL Open Font License 1.1.
- **`diagram-design/`** contains only my profile and installers. The plugin itself is [diagram-design](https://github.com/cathrynlavery/diagram-design) by Cathryn Lavery (MIT) and is not included.
