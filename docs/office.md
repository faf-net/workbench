# Word, Excel, PowerPoint

> **Hinweis:** Die Werte sind festgelegt, Vorlagen-Dateien (`.dotx`, `.xltx`, `.potx`) gibt es noch nicht. Atkinson Hyperlegible Next muss installiert sein (statische TTF aus https://github.com/googlefonts/atkinson-hyperlegible-next), sonst ersetzt Office die Schrift. Die Werte gelten auch für OnlyOffice und LibreOffice.

## Designfarben „Workbench“ (für alle drei Programme)

Für Papier und helle Bildschirme gilt das **helle** Theme.

| Office-Platz | Wert | Token |
|---|---|---|
| Text/Hintergrund dunkel 1 | `#2A2724` | `schrift` hell |
| Text/Hintergrund hell 1 | `#F7F3EC` | `panel` hell |
| Text/Hintergrund dunkel 2 | `#171512` | `fett` hell |
| Text/Hintergrund hell 2 | `#EFEAE1` | `grund` hell |
| Akzent 1 | `#975B34` | Bernstein |
| Akzent 2 | `#456579` | Stahl |
| Akzent 3 | `#4E716A` | Petrol |
| Akzent 4 | `#7E6820` | Gold |
| Akzent 5 | `#5E7040` | Salbei |
| Akzent 6 | `#9C4D40` | Rosé |
| Link | `#456579` | Stahl |
| Besuchter Link | `#8C5C72` | Malve |

Die Reihenfolge Akzent 1 bis 4 entspricht der Diagrammregel. Diagramme mit mehreren Reihen bekommen damit automatisch Bernstein · Stahl · Petrol · Gold.

**Designschriften:** Überschriften und Text Atkinson Hyperlegible Next.

## Word

| Formatvorlage | Schrift | Größe / Schnitt | Farbe | Abstände |
|---|---|---|---|---|
| Standard | Atkinson Hyperlegible Next | 10,5 pt | `#2A2724` | Zeilenabstand 1,3 · nach 6 pt |
| Titel | Atkinson | 26 pt ExtraBold | `#171512` | nach 12 pt |
| Überschrift 1 | Atkinson | 18 pt Fett | `#975B34` | vor 18 pt · nach 6 pt |
| Überschrift 2 | Atkinson | 14 pt Fett | `#171512` | vor 12 pt · nach 4 pt |
| Überschrift 3 | Atkinson | 11 pt Fett | `#171512` | vor 10 pt · nach 2 pt |
| Beschriftung | JetBrains Mono | 8 pt, Versalien, 1,5 pt gesperrt | `#6A6258` | — |
| Code | JetBrains Mono | 9 pt | `#2A2724` auf `#ECE6DB` | Innenabstand 4 pt |
| Zitat | Atkinson kursiv | 10,5 pt | `#6A6258` | linker Rahmen 3 pt `#975B34` |

- **Seite:** weißes Papier, Ränder 2,5 cm. Die Wärme kommt aus der Textfarbe `#2A2724` statt Schwarz.
- **Fußzeile:** Seitenzahl in JetBrains Mono 8 pt `#6A6258`, rechts. Optional das Monogramm „wb“ klein links.
- **Hinweisband:** Absatz mit Schattierung `#D2BBA8` (Bernstein 33 %) und linkem Rahmen 3 pt `#975B34`, Text fett `#171512`. Für Vorbehalt Gold `#CABFA1` / `#7E6820`, für Problem Rosé `#D4B6AC` / `#9C4D40`.
- **Textmarker:** Zeichenschattierung (nicht die Word-Markerfarben): kräftig `#D9C6B6` mit Text `#171512` fett, dezent `#DDCDBE`.
- **Tabellen:** Kopfzeile Fläche `#ECE6DB`, Kopfschrift JetBrains Mono 8 pt Versalien `#6A6258`. Nur waagerechte Linien 0,5 pt `#D3CABB`. Zahlen rechtsbündig, deutsche Notation.

## Excel

- **Standardschrift** Atkinson Hyperlegible Next 10 pt, Farbe `#2A2724`. Gitternetzlinien ausblenden, Struktur über Linien.
- **Kopfzeile:** Füllung `#ECE6DB`, fett `#171512`, Linie unten 1 pt `#D3CABB`. Kopf fixieren.
- **Zahlen:** `#.##0` bzw. `#.##0,00`, Währung `#.##0,00 €`, Datum `TT.MM.JJJJ`, rechtsbündig.
- **Summenzeile:** fett `#171512`, Linie oben 1 pt `#975B34`.
- **Bedingte Formatierung (Status, immer mit Wort in einer Nachbarspalte):**

| Zustand | Füllung | Schrift |
|---|---|---|
| gut | `#CBCCB9` | `#4D5B34` |
| Achtung | `#D3CAB1` | `#66541A` |
| kritisch | `#DAC3B9` | `#834136` |
| läuft / wichtig | `#D9C6B6` | `#79492A` |
| neutral | `#C5C9C7` | `#3C5869` |

- **Diagramme:** Reihen in Akzent 1 bis 4, höchstens vier. Beschriftung direkt an der Reihe, Legende nur wenn nötig. Gitternetz 0,5 pt `#D3CABB`, Achsen `#8B8377`, Achsenbeschriftung `#6A6258`. Eine einzelne Reihe in Stahl `#456579`, den wichtigen Wert einzeln Bernstein `#975B34` färben.
- **Messwerte:** eine Spalte „Herkunft“ mit „gemessen“ oder „geschätzt“.

## PowerPoint

Zwei Designs: **Dunkel** für Bildschirm und Beamer, **Hell** für Druck und PDF.

| | Dunkel | Hell |
|---|---|---|
| Hintergrund | `#1A1918` | `#EFEAE1` |
| Titel | Atkinson 32 pt ExtraBold `#F5F1EB` | `#171512` |
| Text | Atkinson 18 pt `#E9E3D8` | `#2A2724` |
| Nebentext | `#A49C90` | `#6A6258` |
| Akzent | Bernstein `#CC9166` | `#975B34` |
| Karten / Flächen | `#232120`, Linie `#3A3634` | `#F7F3EC`, Linie `#D3CABB` |
| Diagrammreihen | `#CC9166` · `#7D97AB` · `#7FA79F` · `#C7A854` | Akzent 1 bis 4 |

- **Format** 16:9, Rand 1,27 cm (48 px), Raster 4er-Schritte.
- **Titel als Aussage:** Jede Folie hat einen Satz als Titel, der die Kernaussage nennt. Darüber eine Beschriftung in JetBrains Mono 11 pt Versalien in Bernstein (Kapitel oder Rubrik).
- **Ein Akzent je Folie:** höchstens ein Element in Bernstein (die eine Zahl, der eine Balken).
- **Fuß:** Foliennummer JetBrains Mono 10 pt `#A49C90` rechts, Monogramm „wb“ klein links.
- **Status** als Pille mit Wort, nie Farbe allein. **Keine Emoji**, keine Verläufe, keine Schatten auf Karten.
