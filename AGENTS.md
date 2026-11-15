# Workbench for AI agents

This file is the entry point for language models and coding agents. Everything you need to apply the Workbench house style is in this repository; read only the files listed for your task.

Workbench is a personal design system in warm, muted colours with one amber accent, named after the operating system of the Amiga 500. It comes with three things an agent can pick up:

| # | What | Where | Kind |
|---|---|---|---|
| 1 | **Design**: colours, type, spacing, components | [`workbench-design/SKILL.md`](workbench-design/SKILL.md) | skill |
| 2 | **Diagrams**: Workbench profile for the diagram-design plugin | [`diagram-design/workbench.md`](diagram-design/workbench.md) | profile for a third-party plugin |
| 3 | **Text graphics**: pictures made of characters | [`textgrafik/SKILL.md`](textgrafik/SKILL.md) | skill with a JavaScript module |

## Which files to read

| Your task | Read, in this order |
|---|---|
| Style a web page, dashboard or HTML report | `workbench-design/SKILL.md` → `css/workbench.css` → `components/workbench-components.css` → `components/README.md` |
| Need exact colour, type or spacing values | `tokens/tokens.json` (the source; dark and light) |
| Coloured terminal output | `terminal/bash/wb.sh` or `terminal/powershell/wb.ps1`, rules in `docs/terminal-und-powershell.md` |
| Draw an architecture, flow, sequence or chart diagram | `diagram-design/README.md` → `diagram-design/workbench.md` |
| Turn a picture, logo or scene into text graphics | `textgrafik/SKILL.md` → `textgrafik/textgrafik.js` → `textgrafik/beispiel/erdrand.html` |
| Word, Excel, PowerPoint | `docs/office.md` |
| Obsidian | `docs/obsidian.md`, theme in `obsidian/Workbench/` |
| Theme for Claude Code itself | `terminal/claude-code/workbench.json`, `docs/claude-code.md` |

Without a checkout, fetch single files from `https://raw.githubusercontent.com/faf-net/workbench/main/<path>`.

## The rules that always hold

1. **The ground is warm.** `grund` is `#1a1918` (light `#efeae1`), never a neutral grey.
2. **One loud accent.** Only `bernstein` (amber, `#cc9166`, light `#975b34`) may be loud. Everything else steps back.
3. **One family.** Muted and earthy. No neon, no pure red, green or blue.
4. **Colour never decides on its own.** Every status carries a word.
5. **At most two levels of emphasis per screen.**
6. **Take values from `tokens/tokens.json`, never from memory.** If a value here and a value there disagree, the tokens win.

## Language

Token and class names are German and stay German (`grund`, `schrift`, `bernstein`, `salbei`, `.wb-knopf`). The detailed guides in `docs/` and `components/README.md` are written in German; `README.md` and the skills' key rules are in English. A glossary is in `workbench-design/SKILL.md`.

## Install for Claude Code

```
bash install.sh                    # Linux, macOS, Git Bash on Windows
pwsh -File Install-Workbench.ps1   # Windows
```

Both set up all three parts: the skills `workbench-design` and `textgrafik` under `~/.claude/skills/`, and the Workbench profile for diagram-design. Each part also has its own installer in its folder.

The diagram part needs the Claude Code plugin [diagram-design](https://github.com/cathrynlavery/diagram-design) by Cathryn Lavery (MIT). That plugin is not part of this repository; only the profile is. The installer adds the plugin if the `claude` command is available and tells you how to do it by hand if not.

## Licence

MIT, except `obsidian/`, which is GPL-3.0 because it builds on the Soft Paper theme. Fonts (Atkinson Hyperlegible Next, JetBrains Mono, Instrument Serif) come from Google Fonts under their own licences.
