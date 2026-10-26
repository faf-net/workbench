---
name: textgrafik
description: Textgrafik im Stil von Third Bloc bauen — Szenen, Logos oder Bilder als Raster aus Zeichen mit Fuge, wenigen Tönen und Bayer-Raster, Körnung und Leuchten. Nutzen bei jeder ASCII-, Textmodus- oder Third-Bloc-Grafik und wenn ein Bild „als Textgrafik“ erscheinen soll.
---

# Textgrafik wie Third Bloc

Gemeinsamer Baustein für alle Textgrafiken: `textgrafik.js` (neben dieser Datei, ohne Abhängigkeiten).
Vorbild ist das Spiel *Third Bloc*, dessen Bilder aus farbigen Zeichen auf dunklem Grund bestehen.
Ein lauffähiges Beispiel liegt in `beispiel/erdrand.html`.

## Die fünf Regeln

1. **Erst mit Licht malen, dann rastern.** Die Szene ist eine gewöhnliche Leinwand (`tg.szene`) mit
   Verläufen, Schatten, Glanz. Nie direkt im Raster mit Flachfarben zeichnen — so wirkt es wie eine
   grobe Bitmap mit ein paar Zeichen darin.
2. **Wenige Töne, geordnetes Raster.** Jeder Bildpunkt fällt auf den nächsten Ton der Palette; liegt er
   zwischen zwei Tönen, entscheidet ein 4×4-Bayer-Muster. Das ergibt die Schachbrett-Verläufe.
3. **Jeder Bildpunkt ein Zeichen mit Fuge.** Die letzte Gerätepixel-Zeile und -Spalte jeder Zelle ist Fuge.
4. **Dunkles wird Körnung** — auf dunklem Grund zwei helle Punkte statt einer matten Fläche.
5. **Licht als eigene Ebene** (`tg.licht`): was leuchtet, dort zusätzlich hineinmalen; der Baustein
   zeichnet es weich und additiv darüber. Für Bilder: `lichtAuto` (Schwelle, z. B. `.8`).

Dazu: **Schrift scharf über das Ergebnis**, nicht in die Szene. **Nie per CSS hochskalieren** — die
Leinwand ist genau `spalten × s` Gerätepixel breit; `Textgrafik.groesse()` liefert ein ganzzahliges `s`.
`s` mindestens 3, sonst frisst die Fuge das Bild.

## Gebrauch

```js
// Szene selbst malen
const tg = Textgrafik.erzeuge({ spalten: 320, zeilen: 200, palette: Textgrafik.PALETTEN.workbench, grund: '0d0c0b' });
tg.neu();                                      // Szene in Grundfarbe, Licht leer
const S = tg.szene.getContext('2d');           // Größe spalten*2 × zeilen*2 (aufloesung 2)
/* … malen; Leuchtendes zusätzlich auf tg.licht … */
tg.zeichne(canvas, Textgrafik.groesse(tg, verfuegbareBreiteCss));
// danach Schrift auf canvas, scharf

// Bild oder Logo
const tb = Textgrafik.ausBild(img, { spalten: 300, toene: 12, grund: null });   // grund null = durchsichtig
tb.zeichne(canvas, s, sekunden);               // mit Glanz alle 8 s (glanz: false schaltet ab)

// Palette aus der Szene: einmal nach dem ersten Malen
tg.palette(Textgrafik.paletteAusLeinwand(tg.szene, 16));
```

Optionen von `erzeuge`: `spalten`, `zeilen`, `palette` (Hex-Liste), `grund` (Hex oder `null`),
`aufloesung` (2), `fuge` (.35), `fugeArt` (`'grund'` auf dunklem, `'dunkel'` auf hellem Grund — wird
nach dem Grund gewählt), `koernung`, `dunkel` (80), `licht` (`{stark, weit}` oder `false`), `lichtAuto`.

## Paletten

- **Workbench** (`Textgrafik.PALETTEN.workbench`) ist Standard: Tonleitern für Grund, Bernstein, Salbei,
  Stahl, Gold, Rosé. Im Design System „Workbench“ stehen sie als Tokens `textgrafik-<leiter>-<stufe>`
  (dunkel → hell, Baustein „Textgrafik“); bei Abweichung gilt das Design System. Hat die Seite dessen
  `tokens.css` geladen, liefert `Textgrafik.paletteAusCss()` die Leitern von dort, sonst `null`:
  `palette: Textgrafik.paletteAusCss() || Textgrafik.PALETTEN.workbench`.
- **Aus Bild oder Szene** (`paletteAusLeinwand`, k-Means) für Logos und Bilder mit wenigen großen Farbflächen.
- **Tonleitern je Material** für gemalte Szenen: 5–6 Stufen je Material plus Himmel und Boden.
- **Originalfarben**, wenn das Vorbild sie verlangt (etwa ein nachgebautes Programm aus den Achtzigern).

## Fallen

- **Automatische Palette nur für Bilder mit wenigen großen Farbflächen.** In einer überwiegend dunklen
  Szene mit kleinen farbigen Dingen schluckt k-Means die Farben: Ein blauer Traktor, rote Felgen und ein
  grünes Denkmal wurden in einer Probe grau. Für Szenen deshalb Tonleitern je Material vorgeben.
- **Körnung nicht für Szenen in gedämpftem Dunkel.** Lebt eine Szene von dunklen Flächentönen, zerfällt
  sie mit Körnung. Dort `koernung: false`. Körnung passt zu Szenen mit Schwarz als Grund.
- **Heller Grund:** Fugen zum Grund hin machen auf Weiß alles blass. Auf hellem Grund die Fuge dunkler
  als das Zeichen (`fugeArt: 'dunkel'`, automatisch), helle Töne mit schwächerer Fuge.
- **Grund gehört in die Palette.** Fehlt er, fallen durchsichtige Stellen auf den nächsten Bildton und
  die ganze Fläche wird Körnung. `erzeuge` fügt ihn selbst hinzu.
- **Automatisches Leuchten nur über einer Schwelle** — sonst leuchtet die ganze Szene und verschwimmt.
- **Kugeln und Gelände:** Oberflächen mit räumlichem Rauschen (x, y, z auf der Kugel), nicht mit
  Winkelkoordinaten — sonst laufen Streifen auf den Horizont zu.
- **Seiten ohne fremde Dateien:** den Baustein inline einsetzen, nicht per `<script src>`.

## Prüfen — immer, bevor jemand es sieht

```bash
pruefen.sh seite.html bild.png [breite] [hoehe] [wartezeit_ms]   # kopfloser Chrome/Edge, Ziel muss .png heißen
```

Das Bild dann ansehen und **ehrlich** bewerten, am besten neben einer Vorlage.
