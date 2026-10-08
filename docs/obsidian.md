# Obsidian-Theme

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
