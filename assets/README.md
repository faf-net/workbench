# Zeichen

Fassung 1.0 vom 14.10.2026. Das Monogramm „wb“ ist seit dem Entwurf vom 08.10.2026 unverändert, gezeichnet aus Linien mit runden Enden. Neu sind Lockup, App-Symbol, PNG-Größen und die Regeln.

| Datei | Was | Wofür |
|---|---|---|
| `wb-monogramm.svg` | Bernstein `#cc9166` auf `#1a1918`, 64 × 64, Ecke 6 | dunkle Flächen, Kacheln |
| `wb-monogramm-hell.svg` | Bernstein hell `#975b34` auf `#efeae1` | helle Flächen, Druck |
| `wb-lockup.svg` | Monogramm + Wortmarke „Workbench“ in `#f5f1eb`, 322 × 64 | Kopfzeilen, Titelseiten, dunkel |
| `wb-lockup-hell.svg` | dasselbe hell, Wort `#171512` | helle Flächen, Druck |
| `wb-favicon.svg` | vereinfachte Fassung, dickere Striche, Ecke 2 | Favicon, Tab-Symbol, 16 bis 23 px |
| `wb-favicon-32.png` | dasselbe als PNG, 32 × 32 | ältere Browser |
| `wb-app-symbol.svg` | vollflächig ohne Ecke, Inhalt auf 90 %, damit runde Masken nichts abschneiden | App- und Startbildschirm-Symbol |
| `wb-app-symbol-180.png` · `-192.png` · `-512.png` | dasselbe als PNG | iOS (`apple-touch-icon`), Android und Web-App-Manifest |

**Wortmarke:** Atkinson Hyperlegible Next ExtraBold, als Pfade gesetzt, damit sie ohne Webfont funktioniert. Ihre x-Höhe und Grundlinie sitzen auf der sichtbaren x-Höhe und Grundlinie des Monogramms, Abstand 16 nach dem 64er-Feld. Erzeugt mit einem Skript (HarfBuzz für Kerning, fontTools für die Pfade).

Die Farben stehen fest in den Dateien, weil ein Bild per `<img>` keine Farbe erbt. Regeln für Schutzraum, Mindestgröße und Verbote stehen in `components/README.md` unter „Zeichen“.
