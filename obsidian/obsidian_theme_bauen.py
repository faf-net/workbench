import io, re, os, json

import sys
SRC = sys.argv[1]  # Pfad zu Soft Paper theme.css
DST_DIR = sys.argv[2]  # Zielordner, z. B. <Vault>/.obsidian/themes/Workbench

css = io.open(SRC, encoding="utf-8").read()

def rgb(h):
    h = h.lstrip('#'); return f"{int(h[0:2],16)}, {int(h[2:4],16)}, {int(h[4:6],16)}"

DARK = {
    'rosewater': 'c07f73', 'flamingo': 'cc9166', 'pink': 'b1899b', 'mauve': 'a49c90',
    'red': 'c07f73', 'maroon': 'c07f73', 'peach': 'cc9166', 'yellow': 'c7a854',
    'green': '93a373', 'teal': '7fa79f', 'sky': '7fa79f', 'sapphire': '7d97ab',
    'blue': '7d97ab', 'lavender': 'b1899b', 'text': 'e9e3d8', 'subtext1': 'c0b8ab',
    'subtext0': 'a49c90', 'overlay2': 'a49c90', 'overlay1': 'a49c90', 'overlay0': '7d97ab',
    'surface2': '3a3634', 'surface1': '2b2827', 'surface0': '232120',
    'base': '1a1918', 'mantle': '151413', 'crust': '151413',
}
LIGHT = {
    'rosewater': '9c4d40', 'flamingo': '975b34', 'pink': '8c5c72', 'mauve': '6a6258',
    'red': '9c4d40', 'maroon': '9c4d40', 'peach': '975b34', 'yellow': '7e6820',
    'green': '5e7040', 'teal': '4e716a', 'sky': '4e716a', 'sapphire': '456579',
    'blue': '456579', 'lavender': '8c5c72', 'text': '2a2724', 'subtext1': '975b34',
    'subtext0': '6a6258', 'overlay2': '6a6258', 'overlay1': 'd3cabb', 'overlay0': '456579',
    'surface2': '8b8377', 'surface1': 'd3cabb', 'surface0': 'e2dbcf',
    'base': 'efeae1', 'mantle': 'ece6db', 'crust': 'e2dbcf',
}

def remap_block(css, start_marker, palette):
    i = css.index(start_marker)
    j = css.index('/* Color mappings to Obsidian variables */', i)
    block = css[i:j]
    def sub(m):
        name = m.group(1)
        return f"--ctp-{name}: {rgb(palette[name])};" if name in palette else m.group(0)
    block2 = re.sub(r"--ctp-([a-z0-9]+):\s*[0-9]+,\s*[0-9]+,\s*[0-9]+;", sub, block)
    return css[:i] + block2 + css[j:]

css = remap_block(css, "/* Light mode — Rosé Pine Light base colors */", LIGHT)
css = remap_block(css, "/* Dark mode — Frappé base colors */", DARK)

# Workbench-Variablen je Modus, direkt nach den Paletten einhängen
WB_LIGHT = """
  /* Workbench — hell */
  --wb-grund: #efeae1; --wb-panel: #f7f3ec; --wb-panel2: #ece6db; --wb-linie: #d3cabb; --wb-rille: #e2dbcf;
  --wb-schrift: #2a2724; --wb-gedaempft: #6a6258; --wb-fett: #171512;
  --wb-bernstein: #975b34; --wb-stahl: #456579; --wb-on-akzent: #f7f3ec; --wb-auf-farbe: #f7f3ec;
  --wb-h1: #975b34; --wb-h2: #975b34; --wb-h3: #171512; --wb-h4: #171512; --wb-h5: #6a6258; --wb-h6: #6a6258;
  --sp-teal-link: #456579; --sp-teal-active: #975b34; --sp-blue-light: #975b34; --sp-teal-dark: #975b34;
  --sp-surface-gray: #f7f3ec; --sp-cream-light: #e2dbcf;
  --text-highlight-bg: #d9c6b6; --text-highlight-bg-active: #d2bba8;
  --wb-marker-bernstein: #d9c6b6; --wb-band-bernstein: #d2bba8;
  --wb-kat-1: #975b34; --wb-kat-2: #5e7040; --wb-kat-3: #456579; --wb-kat-4: #7e6820; --wb-kat-5: #4e716a;
  --wb-rahmen: #d9c6b6; --wb-rahmen-aktiv: #efeae1;
"""
WB_DARK = """
  /* Workbench — dunkel */
  --wb-grund: #1a1918; --wb-panel: #232120; --wb-panel2: #2b2827; --wb-linie: #3a3634; --wb-rille: #151413;
  --wb-schrift: #e9e3d8; --wb-gedaempft: #a49c90; --wb-fett: #f5f1eb;
  --wb-bernstein: #cc9166; --wb-stahl: #7d97ab; --wb-on-akzent: #1a1918; --wb-auf-farbe: #1a1918;
  --wb-h1: #cc9166; --wb-h2: #cc9166; --wb-h3: #f5f1eb; --wb-h4: #f5f1eb; --wb-h5: #a49c90; --wb-h6: #a49c90;
  --sp-teal-link: #7d97ab; --sp-teal-active: #cc9166; --sp-blue-light: #cc9166; --sp-teal-dark: #cc9166;
  --sp-surface-gray: #1a1918; --sp-cream-light: #e2dbcf;
  --text-highlight-bg: #47372c; --text-highlight-bg-active: #554132;
  --wb-marker-bernstein: #47372c; --wb-band-bernstein: #554132;
  --wb-kat-1: #cc9166; --wb-kat-2: #93a373; --wb-kat-3: #7d97ab; --wb-kat-4: #c7a854; --wb-kat-5: #7fa79f;
  --wb-rahmen: #47372c; --wb-rahmen-aktiv: #1a1918;
"""
k = "  /* Color mappings to Obsidian variables */"
first = css.index(k)
css = css[:first] + WB_LIGHT + css[first:]
second = css.index(k, css.index("/* Dark mode — Frappé base colors */"))
css = css[:second] + WB_DARK + css[second:]

# Fest eingetragene Werte
HEX = [
    # Überschriften (dunkel-Block, globaler Block, Einstellungsblock)
    ('--inline-title-color: #C6CEEF;', '--inline-title-color: var(--wb-fett);'),
    ('--h1-color: #E78284;', '--h1-color: var(--wb-h1);'), ('--h2-color: #EF9F76;', '--h2-color: var(--wb-h2);'),
    ('--h3-color: var(--sp-teal-link);', '--h3-color: var(--wb-h3);'),
    ('--h4-color: #67C48F;', '--h4-color: var(--wb-h4);'), ('--h5-color: #BB93D6;', '--h5-color: var(--wb-h5);'),
    ('--h1-color: #BA7184;', '--h1-color: var(--wb-h1);'), ('--h2-color: #DD7F67;', '--h2-color: var(--wb-h2);'),
    ('--h3-color: #6E9A8D;', '--h3-color: var(--wb-h3);'), ('--h4-color: #5BA57B;', '--h4-color: var(--wb-h4);'),
    ('--h5-color: #9A85AE;', '--h5-color: var(--wb-h5);'), ('--h6-color: #8D8D8D;', '--h6-color: var(--wb-h6);'),
    ('--h3-color: rgb(var(--ctp-teal));', '--h3-color: var(--wb-h3);'),
    ('--h4-color: rgb(var(--ctp-green));', '--h4-color: var(--wb-h4);'),
    # Texte und Flächen
    ('color: #575279;', 'color: var(--wb-fett);'),
    ('#C6CEEF', 'var(--wb-schrift)'),
    ('background-color: #12B7C5;', 'background-color: var(--wb-panel2);'),
    ('#1A7DA4', 'var(--wb-bernstein)'),
    ('background-color: rgba(75, 143, 171, 0.92);', 'background-color: rgba(var(--ctp-accent), 0.92);'),
    ('background-color: #6097AE !important;', 'background-color: rgba(var(--ctp-accent), 0.85) !important;'),
    ('background-color: #1E8F9D !important;', 'background-color: rgba(var(--ctp-accent), 0.85) !important;'),
    ('color: #8A6DE3;', 'color: var(--wb-bernstein);'),
    ('#414459', 'var(--wb-auf-farbe)'),
    ('background-color: #DAD5D0;', 'background-color: var(--wb-rille);'),
    ('color: #C4C5C1;', 'color: var(--wb-rille);'),
    ('#EEE6DD', 'var(--wb-auf-farbe)'),
    ('background-color: #D0CFCE;', 'background-color: var(--wb-rille);'),
    ('background-color: #E6DBD1;', 'background-color: var(--wb-panel2);'),
    ('#525252', 'var(--wb-gedaempft)'),
    ('rgb(40, 40, 40)', 'var(--wb-schrift)'),
    ('rgb(235, 235, 235)', 'var(--wb-schrift)'),
    # Akzent: Bernstein statt Saphir
    ('--ctp-accent: var(--ctp-sapphire);', '--ctp-accent: var(--ctp-peach);'),
    ('/* Accent: Sapphire */', '/* Akzent: Bernstein (Workbench) */'),
    # Schriften
    ('"Source Serif Pro", serif', 'var(--wb-sans)'),
]
for a, b in HEX:
    n = css.count(a)
    if n == 0:
        print("NICHT GEFUNDEN:", a)
    css = css.replace(a, b)

# :root-Block mit den alten sp-Farben neutralisieren (Werte kommen jetzt aus den Modus-Blöcken)
css = re.sub(r":root \{\n  --sp-teal-link: #0AD1D0;.*?\n\}", ":root {\n  --wb-sans: \"Atkinson Hyperlegible Next\", \"Segoe UI\", system-ui, sans-serif;\n  --wb-mono: \"JetBrains Mono\", \"JetBrainsMono Nerd Font Mono\", Consolas, monospace;\n}", css, count=1, flags=re.S)

# Kopf und Style-Settings-Kennung
head_old = css[:css.index('/*===============================================================\n * STYLE SETTINGS METADATA')]
head_new = """@import url("https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Next:wght@400;600;700;800&family=JetBrains+Mono:wght@400;600;800&display=swap");

/*
 * Workbench — Obsidian-Theme in den Workbench-Farben
 * Version 1.1.0 · 14.10.2026 (Statuspille für Tags und Eigenschaften)
 *
 * Abgeleitet aus Soft Paper 1.2.1 von Nick Milo (https://github.com/nickmilo/soft-paper),
 * das wiederum auf AnuPpuccin von Anubis beruht (https://github.com/AnubisNekhet/AnuPpuccin).
 * Beide stehen unter GPL-3.0, dieses Theme damit ebenfalls.
 *
 * Geändert gegenüber Soft Paper: alle Farben auf die Workbench-Palette
 * (Design System „Workbench“), Akzent Bernstein statt Saphir, Verweise Stahl,
 * Überschriften Bernstein/fett/gedämpft statt Regenbogen, Callouts nach der
 * festen Workbench-Zuordnung, Schriften Atkinson Hyperlegible Next und JetBrains Mono.
 * Aufbau, Layout und Style-Settings-Schalter sind unverändert.
 */

"""
css = head_new + css[len(head_old):]
css = css.replace("name: Soft Paper\nid: soft-paper-dark-settings", "name: Workbench\nid: workbench-settings", 1)

TAIL = """

/*===============================================================
 * WORKBENCH — SCHRIFTEN, CALLOUTS, LETZTE ÜBERSTEUERUNGEN
 *===============================================================*/

body {
  --font-text-theme: var(--wb-sans);
  --font-interface-theme: var(--wb-sans);
  --font-monospace-theme: var(--wb-mono);
  --anp-header-font: var(--wb-sans);
}

/* Callouts: feste Zuordnung nach der Workbench-Palette */
.callout[data-callout=success], .callout[data-callout=check], .callout[data-callout=done] { --callout-color: var(--ctp-green); }
.callout[data-callout=important] { --callout-color: var(--ctp-peach); }
.callout[data-callout=warning], .callout[data-callout=caution], .callout[data-callout=attention] { --callout-color: var(--ctp-yellow); }
.callout[data-callout=danger], .callout[data-callout=error], .callout[data-callout=bug],
.callout[data-callout=failure], .callout[data-callout=fail], .callout[data-callout=missing] { --callout-color: var(--ctp-red); }
.callout[data-callout=note], .callout[data-callout=info] { --callout-color: var(--ctp-sapphire); }
.callout[data-callout=tip], .callout[data-callout=hint] { --callout-color: var(--ctp-teal); }
.callout[data-callout=question], .callout[data-callout=help], .callout[data-callout=faq] { --callout-color: var(--ctp-yellow); }
.callout[data-callout=example] { --callout-color: var(--ctp-lavender); }
.callout[data-callout=abstract], .callout[data-callout=summary], .callout[data-callout=tldr] { --callout-color: var(--ctp-sapphire); }

/* Markierung ==so== wie der Workbench-Textmarker */
.markdown-rendered mark, .cm-s-obsidian span.cm-highlight { color: var(--wb-fett); border-radius: 3px; }

/* Ordner der obersten Ebene: ruhige Fläche wie die Dateien im Wurzelordner, kein Regenbogen (09.10.2026) */
body.theme-dark { --wb-ordner-flaeche: #3a3634; }
body.theme-light { --wb-ordner-flaeche: #e2dbcf; }
body .nav-files-container > div > .nav-folder { background-color: var(--wb-ordner-flaeche); }
body .nav-files-container .nav-folder > .nav-folder-children { border-color: var(--background-modifier-border-hover); }
body.theme-dark .nav-files-container > div > .nav-folder .nav-folder-title,
body.theme-dark .nav-files-container > div > .nav-folder .nav-file-title,
body.theme-dark .nav-files-container > div > .nav-folder-children > .nav-file .nav-file-title,
body.theme-light .nav-files-container > div > .nav-folder .nav-folder-title,
body.theme-light .nav-files-container > div > .nav-folder .nav-file-title,
body.theme-light .nav-files-container > div > .nav-folder-children > .nav-file .nav-file-title {
  color: var(--wb-schrift);
}
body.theme-dark .nav-files-container .collapse-icon svg.svg-icon,
body.theme-light .nav-files-container .collapse-icon svg.svg-icon,
body.theme-dark .nav-files-container .nav-folder .nav-file-title,
body.theme-light .nav-files-container .nav-folder .nav-file-title {
  --icon-color: var(--wb-gedaempft);
}
body.theme-dark .nav-files-container .collapse-icon svg.svg-icon,
body.theme-light .nav-files-container .collapse-icon svg.svg-icon { color: var(--wb-gedaempft); }
body .nav-files-container .nav-file-title.is-active { background-color: var(--text-highlight-bg); color: var(--wb-fett); }

/* Hauptkategorien: Titelzeile in voller Farbe, Name dunkel bzw. hell (09.10.2026, Variante D) */
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="00 Home"])  { --wb-kat: var(--wb-kat-1); }
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="10 Inbox"])    { --wb-kat: var(--wb-kat-2); }
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="20 Projects"]) { --wb-kat: var(--wb-kat-3); }
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="30 Areas"]) { --wb-kat: var(--wb-kat-4); }
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="40 Resources"]) { --wb-kat: var(--wb-kat-5); }
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="00 Home"], > .nav-folder-title[data-path="10 Inbox"], > .nav-folder-title[data-path="20 Projects"], > .nav-folder-title[data-path="30 Areas"], > .nav-folder-title[data-path="40 Resources"]) > .nav-folder-title {
  background-color: var(--wb-kat) !important;
  color: var(--wb-on-akzent) !important;
  font-weight: 700;
  border-radius: 5px;
}
body .nav-files-container > div > .nav-folder:has(> .nav-folder-title[data-path="00 Home"], > .nav-folder-title[data-path="10 Inbox"], > .nav-folder-title[data-path="20 Projects"], > .nav-folder-title[data-path="30 Areas"], > .nav-folder-title[data-path="40 Resources"]) > .nav-folder-title * {
  color: var(--wb-on-akzent) !important;
  --icon-color: var(--wb-on-akzent) !important;
}

/* Rahmen („Colorful Frame“ von Soft Paper): Bernstein-Marker 25 % statt voller Fläche (09.10.2026, Variante C) */
body {
  --titlebar-background: var(--wb-rahmen);
  --titlebar-background-focused: var(--wb-rahmen);
  --colorful-frame-color: var(--wb-rahmen);
  --titlebar-text-color: var(--wb-bernstein);
  --titlebar-text-color-focused: var(--wb-bernstein);
  background-color: var(--wb-rahmen);
}
body .mod-left-split .workspace-tab-header-container,
body .mod-right-split .workspace-tab-header-container,
body .mod-root .workspace-tab-header-container,
body .mod-root .workspace-tabs.mod-top,
body .mod-left-split .workspace-tab-container,
body .mod-right-split .workspace-tab-container,
body .workspace-drawer-vault,
body .workspace-sidedock-vault-profile,
html body .workspace-split.mod-left-split .workspace-sidedock-vault-profile,
html body .workspace-split.mod-left-split .workspace-sidedock-vault-profile .workspace-drawer-vault-switcher,
body .sidebar-toggle-button { background-color: var(--wb-rahmen) !important; }
body .titlebar *, body .workspace-tab-header-container .clickable-icon, body .workspace-tab-header-container svg,
body .workspace-tab-header-container .workspace-tab-header-inner-icon,
body .workspace-tab-header-container-inner .workspace-tab-header:not(.is-active) .workspace-tab-header-inner-title,
body .sidebar-toggle-button, body .sidebar-toggle-button .clickable-icon,
body .workspace-sidedock-vault-profile, body .workspace-sidedock-vault-profile *,
body .workspace-drawer-vault, body .workspace-drawer-vault * { color: var(--wb-bernstein) !important; --icon-color: var(--wb-bernstein) !important; --icon-color-hover: var(--wb-fett) !important; }
/* Aktiver Seitenleisten-Reiter: dunkel wie der Inhalt, Symbol Bernstein */
body .mod-left-split .workspace-tab-header.is-active,
body .mod-right-split .workspace-tab-header.is-active,
body .mod-left-split .workspace-tab-header-status-icon.is-active,
body .mod-right-split .workspace-tab-header-status-icon.is-active { background-color: var(--wb-rahmen-aktiv) !important; }
body .mod-left-split .workspace-tab-header.is-active:hover,
body .mod-right-split .workspace-tab-header.is-active:hover,
body .mod-left-split .workspace-tab-header:not(.is-active):hover .workspace-tab-header-inner,
body .mod-right-split .workspace-tab-header:not(.is-active):hover .workspace-tab-header-inner { background-color: var(--wb-band-bernstein) !important; }

/* Kartenhintergrund (Soft Paper: volle Akzentfarbe) ebenfalls auf den Rahmenton */
body { --card-background-color: var(--wb-rahmen); }

/* Auswahl und Fokus */
body { --text-selection: rgba(var(--ctp-sapphire), 0.3); }

/*===============================================================
 * WORKBENCH — STATUSPILLE (Design System)
 * Rund, flach, 30 % Fläche (pille-*), Wort in status-*, Atkinson 700 in Versalien.
 * Tags tragen Bernstein, übrige Listenwerte in den Eigenschaften Stahl.
 *===============================================================*/
body.theme-dark {
  --wb-pille-bernstein: #4f3d2f; --wb-status-bernstein: #e0a87f;
  --wb-pille-stahl: #383f44;     --wb-status-stahl: #9ab2c4;
}
body.theme-light {
  --wb-pille-bernstein: #d5bfad; --wb-status-bernstein: #734528;
  --wb-pille-stahl: #bcc2c2;     --wb-status-stahl: #385262;
}
body.theme-dark, body.theme-light {
  --tag-background: var(--wb-pille-bernstein);
  --tag-background-hover: var(--wb-pille-bernstein);
  --tag-border-color: transparent;
  --tag-border-color-hover: transparent;
  --tag-border-width: 0px;
  --tag-color: var(--wb-status-bernstein);
  --tag-color-hover: var(--wb-status-bernstein);
  --tag-decoration: none;
  --tag-decoration-hover: none;
  --tag-radius: 999px;
  --tag-padding-x: 0.75em;
  --tag-padding-y: 0.25em;
  --tag-size: 0.72em;
  --tag-weight: 700;
  --pill-background: var(--wb-pille-stahl);
  --pill-background-hover: var(--wb-pille-stahl);
  --pill-border-color: transparent;
  --pill-border-color-hover: transparent;
  --pill-border-width: 0px;
  --pill-color: var(--wb-status-stahl);
  --pill-color-hover: var(--wb-status-stahl);
  --pill-color-remove: var(--wb-status-stahl);
  --pill-color-remove-hover: var(--wb-fett);
  --pill-radius: 999px;
  --pill-weight: 700;
}
body a.tag, body .cm-hashtag, body .multi-select-pill-content {
  font-family: var(--wb-sans);
  text-transform: uppercase;
  letter-spacing: 0.1em;
}
/* Tags in den Eigenschaften sehen aus wie Tags im Text */
body .metadata-property[data-property-key="tags"] .multi-select-pill {
  background-color: var(--wb-pille-bernstein);
  color: var(--wb-status-bernstein);
}
@media print {
  body a.tag, body .cm-hashtag { background-color: #d5bfad !important; color: #734528 !important; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
}
"""
css = css.rstrip() + TAIL

os.makedirs(DST_DIR, exist_ok=True)
io.open(os.path.join(DST_DIR, "theme.css"), "w", encoding="utf-8", newline="\n").write(css)
json.dump({"name": "Workbench", "version": "1.1.0", "minAppVersion": "1.0.0",
           "author": "faf-net (auf Basis von Soft Paper von Nick Milo)"},
          io.open(os.path.join(DST_DIR, "manifest.json"), "w", encoding="utf-8", newline="\n"),
          ensure_ascii=False, indent=2)
left = sorted(set(m.lower() for m in re.findall(r"#[0-9a-fA-F]{6}\b", css)))
print("ok", len(css), "Bytes · verbleibende Hexwerte:", left)
