# Terminal und PowerShell

So sieht die Shell unter Windows aus. Die Dateien liegen in `terminal/`, die Einrichtung steht in der README. Die Farbwerte kommen aus diesem System.

## Vier Ebenen

| Ebene | Was | Wo |
|---|---|---|
| Schrift | **JetBrainsMono Nerd Font Mono**, vier Schnitte, benutzerweit | `%LOCALAPPDATA%\Microsoft\Windows\Fonts`. Ohne sie stehen im Prompt Kästchen statt Glyphen |
| Terminal | Farbschema und Fenster-Theme „Workbench“ | `settings.json` des Windows Terminals, eigene Profile bleiben unberührt |
| Profil | `profile.ps1` als AllHosts-Profil | gilt in Windows Terminal, VS Code und Claude Code. Gibt bewusst nichts aus |
| Helfer | `wb.ps1` (PowerShell), `wb.sh` (Bash, auch Git Bash) | `~/bin` |

## Windows Terminal

- Schrift JetBrainsMono Nerd Font Mono **11 pt**, Graustufen-Glättung, Cursor als gefüllter Block in `bernstein`.
- Innenabstand **12, 10, 12, 10**, Verlauf 32.767 Zeilen, kein Acryl, Deckkraft 100.
- `intenseTextStyle: all`: Fettes wird fett **und** hell (`fett` `#f5f1eb`), sonst wäre es nicht von normalem Text zu unterscheiden.
- Fenster-Theme: Tab aktiv `panel`, Tab inaktiv und Tableiste `grund` bzw. `rille`, App-Theme dunkel, kein Mica.

**Die 16 ANSI-Farben:**

| ANSI | normal | hell |
|---|---|---|
| schwarz | `#2b2827` `panel-2` | `#6f6961` `schwach` |
| rot | `#c07f73` `rose` | `#d69a8d` `ansi-hell-rose` |
| grün | `#93a373` `salbei` | `#adbb8e` `ansi-hell-salbei` |
| gelb | `#c7a854` `gold` | `#ddc274` `ansi-hell-gold` |
| blau | `#7d97ab` `stahl` | `#9ab2c4` `ansi-hell-stahl` |
| magenta | `#b1899b` `malve` | `#c9a3b4` `ansi-hell-malve` |
| cyan | `#7fa79f` `petrol` | `#9bc0b8` `ansi-hell-petrol` |
| weiß | `#a49c90` `gedaempft` | `#f5f1eb` `fett` |

Grund `#1a1918`, Vordergrund `#e9e3d8`, Cursor `#cc9166`, Auswahl `#3a3634`. Das Original liegt unter `terminal/` → `terminal-workbench.json`.

## PowerShell-Profil

**PSReadLine (Eingabezeile):**

| Element | Ton |
|---|---|
| Befehl | `bernstein` |
| Parameter | `stahl` |
| Operator | `gedaempft` |
| Variable | `salbei` |
| Zeichenkette | `gold` |
| Zahl | `petrol` |
| Typ, Schlüsselwort | `malve` |
| Kommentar, Vorhersage, Fortsetzung | `schwach` |
| Fehler | `rose` |
| Hervorhebung | `fett` auf `marker-gold` |
| Auswahl | `grund` auf `bernstein` |
| gewählte Vorhersage | `fett` auf `linie` |

**PSStyle (Ausgabe):** Tabellenkopf `bernstein` fett, Akzent `bernstein`, Fehler `fett` auf `marker-rose`, Warnung `fett` auf `marker-gold`, Verbose `stahl`, Debug `schwach`, Fortschrittsbalken `fett` auf `marker-stahl`.

**Dateilisten (`Get-ChildItem`):**

| Typ | Ton |
|---|---|
| Ordner | `bernstein` fett, ohne Fläche |
| Programme und Skripte (`.ps1 .psm1 .cmd .bat .sh`) | `salbei` |
| Archive (`.zip .7z .tar .gz .iso .msi`) | `malve` |
| Konfiguration (`.json .yml .yaml .toml .ini .xml`) | `gold` |
| Text (`.md .txt .log`) | `gedaempft` |
| Bilder und PDF, Verknüpfungen | `petrol` |

**Prompt, zweizeilig:** Ordner-Glyph in `schwach`, Pfad in `stahl` (Home als `~`), Git-Zweig in `salbei` (sauber) oder `gold` (Änderungen), `admin` in `rose`. Zweite Zeile `❯` in `bernstein`, nach einem Fehler in `rose`.

Ausgabe ist UTF-8 ohne BOM. Die Variable `$WB` hält die Palette für eigene Skripte.

## Farbhelfer

| | Bash | PowerShell |
|---|---|---|
| Datei | `~/bin/wb.sh` | `~/bin/wb.ps1` |
| Aufruf aus Claude Code | Bash-Werkzeug: `export LC_ALL=C.UTF-8; ~/bin/wb.sh …` | PowerShell-Werkzeug: `& "$HOME\bin\wb.ps1" …` |
| `mark` | ohne Zeilenumbruch | **mit** Zeilenumbruch (`-NoNewline` für mitten im Satz) |

Unterkommandos auf beiden: `band <ton> <text>` (Hinweisband, 33 %), `mark [--dezent] <ton> <text>` (Textmarker 25 % bzw. 14 %), `swatch` (Palette). Töne: `amber sage gold rose steel`.

## Fallen, die Zeit gekostet haben

- **Git Bash unter Windows:** `LANG` und `LC_ALL` sind leer, `${#text}` zählt dann Bytes. Ohne `export LC_ALL=C.UTF-8` werden Bänder mit Umlauten zu kurz.
- **`printf '%-*s'`** füllt nach Bytes, nicht nach Zeichen. Umlaute und Geviertstriche verschieben die Ausrichtung.
- **Windows PowerShell 5.1** liest Skripte ohne BOM als ANSI. Skripte mit Umlauten als UTF-8 **mit** BOM speichern.
- **`wb.ps1` aus der Git Bash** (`pwsh -File …`) verliert Umlaute über die ANSI-Codepage. Aus der PowerShell aufrufen.
- **PowerShell 7 muss Standardprofil** im Terminal sein. Unter 5.1 greifen Schema und Schrift, Prompt und Dateifarben nicht.
- **Die Schrift** erscheint erst nach einem Neustart des Terminals.
