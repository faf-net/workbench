# Obsidian

die Vault läuft mit dem Theme **„Workbench“**. Es liegt unter `.obsidian/themes/Workbench/` und wird von `obsidian/obsidian_theme_bauen.py` aus **Soft Paper 1.2.1** von Nick Milo erzeugt. Soft Paper beruht auf AnuPpuccin, beide stehen unter GPL-3.0, das Theme damit auch. Layout, Abstände und Style-Settings-Schalter sind die von Soft Paper, Farben und Schriften kommen aus diesem System.

## Was das Theme setzt

| Element | Dunkel / Hell |
|---|---|
| Editor | `grund` |
| Seitenleisten | `rille`, hell `panel-2` |
| Akzent (Tags, Auswahl, Zitatbalken) | `bernstein` |
| Verweise | `stahl` |
| Überschriften | H1/H2 `bernstein` · H3/H4 `fett` · H5/H6 `gedaempft` |
| `==Markierung==` | `marker-bernstein` |
| Vault-Leiste unten links, aktiver Seitenleisten-Reiter, Sidebar-Knopf | Fläche `marker-bernstein`, Symbol `bernstein`, Name `fett` |
| Dateien im Wurzelordner, Ordner ab 50 ARCHIV | Fläche `linie` (hell `rille`), Schrift `schrift` |
| Geöffnete Datei im Dateibaum | `marker-bernstein`, Schrift `fett` |
| Schrift | Atkinson Hyperlegible Next, Code JetBrains Mono |

## Die fünf Hauptkategorien

Jeder Hauptordner trägt ein Band (33 %) in seinem Ton, Name `fett`:

| Ordner | Ton | Token |
|---|---|---|
| 00 KONTEXT | Bernstein | `band-bernstein` |
| 10 INBOX | Salbei | `band-salbei` |
| 20 PROJEKTE | Stahl | `band-stahl` |
| 30 WORKBENCH | Gold | `band-gold` |
| 40 RESOURCEN | Petrol | `band-petrol` |

Die Zuordnung hängt am Ordnernamen (`data-path`), nicht an der Position. Ein umbenannter Ordner verliert seine Farbe, bis das Skript angepasst ist.

## Callouts

Feste Zuordnung, damit die Bedeutung in allen Notizen gleich bleibt:

| Callout | Ton | Bedeutung |
|---|---|---|
| `[!success]` | Salbei | erledigt, bestätigt, gesichert |
| `[!important]` | Bernstein | das Wichtigste, Kernentscheidung |
| `[!warning]` | Gold | Achtung, offener Punkt |
| `[!danger]`, `[!failure]` | Rosé | kritisch, widerlegt, gefährlich |
| `[!note]`, `[!info]` | Stahl | Einordnung, Hintergrund |
| `[!tip]` | Petrol | Hinweis |

## Einstellungen, die das Theme übersteuern

In `.obsidian/appearance.json`: Eine feste Textschrift (`textFontFamily`) schlägt Atkinson, und `accentColor` färbt einzelne Stellen im Obsidian-Kern. Für das volle Bild die Textschrift leeren und den Akzent auf `#cc9166` setzen. Die Datei geht über Syncthing auf alle Geräte.
