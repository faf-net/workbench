# Bausteine

Alle Klassen stehen in `workbench-components.css`, Beispiele in [`examples/bausteine.html`](../examples/bausteine.html).

## Segmentierter Balken

Ein Balken aus 20 Segmenten zeigt eine Auslastung, und die Zahl steht immer daneben.

**Was du lieferst:** Bezeichnung, Prozentwert, Anzahl der gefüllten Segmente (Prozent ÷ 5, gerundet) und einen `aria-label`.

- Leere Segmente `rille`, gefüllte `salbei`; ab Grenzwert `--achtung` (Gold), darüber `--kritisch` (Rosé). Die Grenzwerte legt der jeweilige Bildschirm fest.
- Zahl in `fett`, JetBrains Mono mit `tabular-nums`. Der Balken allein reicht nie.
- Im Terminal: dieselbe Logik mit `█` und `░`.

---

## Diagramm

Zwei Regeln für Datenreihen, beide geprüft auf Rot-Grün-Schwäche (ΔE 2000, Machado-Modell).

**Eine Reihe:** alle Werte in `diagramm-reihe` (Stahl), der eine Wert, auf den es ankommt, in `diagramm-hervorhebung` (Bernstein), beschriftet.

**Mehrere Reihen:** `diagramm-1` bis `diagramm-4` = Bernstein · Stahl · Petrol · Gold, in dieser Reihenfolge, **höchstens vier**. Jede Reihe trägt ihre Beschriftung direkt am Linienende, keine Legende. Das schwächste Paar der Gruppe (Bernstein/Gold) liegt bei Deuteranopie nur bei ΔE 5,9.

- Mehr als vier Reihen: aufteilen oder als Messtabelle zeigen.
- **Malve und Petrol nie zusammen** (Deuteranopie ΔE 2,0).
- Salbei, Gold und Rosé bleiben Statusfarben. Gold als vierte Reihe nur, wenn im selben Bild kein Status vorkommt.
- Achsen und Raster in `schwach`, Beschriftung in `gedaempft` oder in der Reihenfarbe, Werte in `fett`.
- Bei Dauerbildschirmen zählt Verlauf, nicht Zustand: Kurven statt Ampeln.

---

## Hinweisband

Ein Band über die volle Breite trägt die eine Kernaussage eines Ergebnisses, vor allem anderen Text.

**Was du lieferst:** einen kurzen Satz (eine Zeile), dazu den Ton über die Klasse.

```html
<div class="wb-band">Kernaussage</div>
<div class="wb-band wb-band--salbei">in Ordnung</div>
```

- Ton nach Bedeutung: `bernstein` (Standard) für die Kernaussage, `--salbei` in Ordnung, `--gold` Vorbehalt, `--rose` Problem, `--stahl` neutral.
- Fläche `band-*` (33 %), Kante 3 px im vollen Akzent, Text `fett`.
- Höchstens ein Band pro Bildschirm, höchstens zwei Hervorhebungsstufen insgesamt.
- Im Terminal: `wb.sh band <ton> <text>` (Bash) bzw. `wb.ps1 band` (PowerShell).
- Nicht für Fließtext oder Listen, dafür gibt es den Textmarker.

---

## Host-Karte

Eine Karte pro Maschine: Name und Rolle im Kopf, Dienste und Zustand darunter.

**Was du lieferst:** Name, Rolle (ein paar Wörter), Inhalt als kurze Zeilen, optional eine Statuspille.

```html
<div class="wb-host">
  <div class="wb-host__kopf"><span class="wb-host__name">nas-01</span><span class="wb-host__rolle">Haupt-NAS</span></div>
  <div class="wb-host__rumpf"><span>Dateiablage</span></div>
</div>
```

- Fläche `panel`, Kopf `panel-2`, Rahmen `linie`, Ecke `ecke-karte`. Kein Schatten, die Karte liegt nicht über anderem Inhalt.
- Name in Atkinson 19 px fett, Rolle und Inhalt in JetBrains Mono.
- IP-Adressen und Hostnamen nur in privaten Ausgaben, nie in externen.

---

## Messtabelle

Eine Tabelle mit Messwerten, in der jede Zahl ihre Herkunft trägt: gemessen oder geschätzt.

**Was du lieferst:** Zeilen mit Bezeichnung, Zahl und Herkunft.

- Zahlen in deutscher Notation (1.740, 4,5 : 1, 1.000,00 EUR), rechtsbündig, `tabular-nums`.
- Herkunft als kleines Etikett: `gemessen` auf `dezent-salbei`, `geschätzt` auf `dezent-gold`.
- Spaltenköpfe im Stil `beschriftung`, Farbe `gedaempft`.
- Eine Grafik wirkt präziser, als die Daten sind. Deshalb steht die Herkunft immer dabei.

---

## Schwebendes Element

Menüs, Dialoge und Aufklapper liegen über dem Inhalt und sind das Einzige mit Schatten.

**Was du lieferst:** den Inhalt (Links, Formular), Position übernimmt der Aufrufer.

- Tiefe entsteht sonst nur über die Flächen `grund` → `panel` → `panel-2` und die `linie`. Das funktioniert genauso im Terminal und auf dem Framebuffer.
- Schatten `schatten-schwebend`, Fläche `panel`, Rahmen `linie`, Ecke `ecke-karte`.
- Auswahl bzw. Hover: `marker-bernstein` mit Text `fett`. Fokus: `fokus`-Ring.

---

## Statuspille

Eine runde Pille mit Wort zeigt einen Zustand, und das Wort trägt die Bedeutung, nicht die Farbe.

**Was du lieferst:** ein Wort (gesichert, läuft, eng, gesättigt, geplant …), dazu den Ton über die Klasse.

```html
<span class="wb-status wb-status--gut">gesichert</span>
```

- `--gut` Salbei · `--achtung` Gold · `--kritisch` Rosé · `--laeuft` Bernstein · ohne Zusatz Stahl.
- **Form:** runde Enden (`ecke-pille`), flach, kein Rahmen, kein Schein. Innenabstand `abstand-1` oben und unten, `abstand-3` links und rechts, 20 px hoch.
- **Fläche** `pille-*`: 30 % Ton auf `grund`, als fester Hexwert. **Wort** in `status-*`, Atkinson Hyperlegible Next 12 px, Gewicht 700, **immer Versalien**, Sperrung 0,1em (Textstil `pille`).
- **Kontrast**, berechnet nach WCAG: dunkel 4,6 bis 5,5 : 1, hell 4,5 bis 4,6 : 1. Damit das hell reicht, sind die hellen `status-*` am 14.10.2026 nachgedunkelt worden. Die Pille liegt als feste Fläche auf jedem Grund gleich.
- **Druck:** Papier ist hell. `bundle.css` druckt deshalb immer die hellen Werte und setzt `print-color-adjust: exact`, sonst lassen Browser die Fläche weg. Auf Schwarz-Weiß-Druckern werden alle fünf Töne zum selben Grau (L* 83 bis 84); dann trägt nur das Wort.
- **Immer mit Wort.** Salbei und Rosé sind bei Deuteranopie nur ΔE 3,0 voneinander entfernt, Bernstein und Salbei bei Protanopie 2,8.
- Ausgewählt am 14.10.2026 aus drei Runden mit 38 Varianten (Variante „4.4 Kräftig“, Stärke 30 %, flach). Vorgängerin: eckige Pille in JetBrains Mono auf `marker-*` (25 %).
- Im Einsatz auf dem Statusdisplay (WLAN-Kanäle: frei, eng, gesättigt), in Host-Karten und als Tags im Obsidian-Theme.

---

## Textmarker

Eine getönte Fläche hinter Text wirkt wie ein echter Textmarker und ist das wirksamste Mittel der Palette.

**Was du lieferst:** ein paar Wörter, nicht einen ganzen Satz.

```html
<span class="wb-mark">Kernergebnis</span>
<span class="wb-mark wb-mark--dezent wb-mark--stahl">Einordnung</span>
```

- **Kräftig (25 %)** `marker-*`, Text `fett`: Kernergebnis, Warnung, FEHLER, die Zahl zum Merken.
- **Dezent (14 %)** `dezent-*` mit `--dezent`, Text `schrift`: Einordnung im Fließtext, INFO/OK, Diff-Zeilen.
- Die Hexwerte sind fest, nicht per `color-mix` gerechnet, und kaufmännisch gerundet.
- Höchstens zwei Stufen pro Bildschirm. Eine getönte Fläche schlägt ein eingefärbtes Zeichen.
- Im Terminal: `wb.sh mark [--dezent] <ton> <text>`.
