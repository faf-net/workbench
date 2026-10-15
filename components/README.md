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

## Eingabefeld

Ein Eingabefeld nimmt einen Wert auf, mit Beschriftung darüber und Hilfe oder Fehler darunter.

**Was du lieferst:** Beschriftung, das Feld (`<input>`, `<select>`, `<textarea>`), optional einen Hilfetext und im Fehlerfall einen Satz, der sagt, wie es richtig geht.

```html
<label class="wb-feld">
  <span class="wb-feld__label">Aufbewahrung in Tagen</span>
  <input class="wb-feld__eingabe wb-feld__eingabe--zahl" value="30">
  <span class="wb-feld__hilfe">Ältere Sicherungen werden gelöscht.</span>
</label>
```

- Fläche `feld` (dunkel `rille`, hell `panel`), Rand `rand-bedien` (mindestens 3 : 1), Schrift `schrift`, Platzhalter `gedaempft`.
- Beschriftung im Stil `beschriftung`: JetBrains Mono 11 px, Versalien, `gedaempft`. Steht immer über dem Feld, nie nur als Platzhalter.
- Zahlen mit `--zahl`: JetBrains Mono, `tabular-nums`.
- **Fehler** `wb-feld--fehler`: Rand `rose`, Hilfetext in `rose` (4,9 bis 5,5 : 1). Der Satz sagt, was zu tun ist, nicht nur, dass etwas falsch ist.
- 32 px hoch, Ecke `ecke-marker`, höchstens 360 px breit. Fokus: Ring in `fokus`.

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

## Knopf

Ein Knopf löst eine Aktion aus, und seine Beschriftung sagt in einem Verb, was dann passiert.

**Was du lieferst:** ein `<button>` (oder `<a>` für einen Seitenwechsel) mit einer Beschriftung wie „Sicherung starten“, dazu die Art über die Klasse.

```html
<button class="wb-knopf wb-knopf--haupt">Sicherung starten</button>
<button class="wb-knopf">Protokoll öffnen</button>
<button class="wb-knopf wb-knopf--leise">Abbrechen</button>
<button class="wb-knopf wb-knopf--gefahr">Sicherung löschen</button>
```

- **Hauptknopf** `--haupt`: volle Fläche `bernstein`, Schrift `on-bernstein` (dunkel 6,5 : 1, hell 4,9 : 1), beim Überfahren `knopf-hover`. **Höchstens einer je Bereich**, sonst gibt es zwei laute Akzente.
- **Zweitknopf** ohne Zusatz: `panel-2` mit Rand `rand-bedien`, Schrift `schrift`. Der Normalfall.
- **Leiser Knopf** `--leise`: nur Schrift `bernstein`, beim Überfahren `dezent-bernstein` mit `status-bernstein`. Für Abbrechen, Zurück, Nebenaktionen.
- **Gefahr** `--gefahr`: Fläche `pille-rose`, Schrift `status-rose` (4,6 : 1). Nur für Unumkehrbares, und dann mit Nachfrage.
- **Klein** `--klein`: 24 px hoch, 13 px Schrift, für Tabellen und Meldungen. Sonst 32 px.
- **Deaktiviert** (`disabled`): Schrift `schwach`. Daneben steht immer, warum.
- Atkinson 700, 15 px (Textstil `knopf`), Ecke `ecke-marker`, keine Versalien. Fokus: Ring in `fokus`.

---

## Leerzustand

Ein Leerzustand füllt eine Fläche, auf der noch nichts steht, und sagt, was hier erscheinen wird und wie es dazu kommt.

**Was du lieferst:** eine kurze Beschriftung, einen Titel, einen Satz und höchstens eine Aktion.

```html
<div class="wb-leer">
  <span class="wb-leer__marke">noch keine Daten</span>
  <h3 class="wb-leer__titel">Noch keine Messwerte</h3>
  <p class="wb-leer__text">Sobald die erste Sicherung gelaufen ist, steht hier ihr Verlauf.</p>
  <button class="wb-knopf wb-knopf--haupt">Sicherung starten</button>
</div>
```

- Gestrichelter Rand `rand-bedien`, keine Fläche, Ecke `ecke-karte`. Linksbündig wie alles andere.
- Titel `fett` 19 px, Satz `gedaempft`, Beschriftung im Stil `beschriftung`.
- Kein Bild, keine Illustration, kein Monogramm. Der Satz erklärt, die Aktion löst.
- Der Satz sagt, wann sich die Fläche von selbst füllt. Ist das nie der Fall, steht dort die Aktion, die es ändert.

---

## Meldung

Eine Meldung bestätigt nach einer Aktion kurz, was passiert ist, und schwebt dabei über dem Inhalt.

**Was du lieferst:** eine Statuspille, einen Satz mit dem Ergebnis, optional eine Aktion.

```html
<div class="wb-meldung" role="status">
  <span class="wb-status wb-status--gut">gesichert</span>
  <p class="wb-meldung__text">Sicherung abgeschlossen, 1.740 Dateien.</p>
  <button class="wb-knopf wb-knopf--leise wb-knopf--klein">Protokoll</button>
  <button class="wb-meldung__zu" aria-label="Meldung schließen">✕</button>
</div>
```

- Fläche `panel`, Rand `linie`, Ecke `ecke-karte`, Schatten `schatten-schwebend`: eines der wenigen Elemente mit Schatten.
- Unten rechts, 24 px vom Rand, höchstens drei übereinander, die neueste unten.
- **Erfolg** (`role="status"`) verschwindet nach 5 Sekunden. **Fehler** (`role="alert"`, Pille `--kritisch`) bleibt, bis sie geschlossen wird.
- Der Satz nennt das Ergebnis mit Zahl, nicht nur „Erfolgreich“.
- Nicht für die Kernaussage einer Seite, dafür gibt es das Hinweisband.

---

## Messtabelle

Eine Tabelle mit Messwerten, in der jede Zahl ihre Herkunft trägt: gemessen oder geschätzt.

**Was du lieferst:** Zeilen mit Bezeichnung, Zahl und Herkunft.

- Zahlen in deutscher Notation (1.740, 4,5 : 1, 1.000,00 EUR), rechtsbündig, `tabular-nums`.
- Herkunft als kleines Etikett: `gemessen` auf `dezent-salbei`, `geschätzt` auf `dezent-gold`.
- Spaltenköpfe im Stil `beschriftung`, Farbe `gedaempft`.
- Eine Grafik wirkt präziser, als die Daten sind. Deshalb steht die Herkunft immer dabei.

---

## Reiter

Reiter teilen eine Fläche in Ansichten, von denen immer genau eine offen ist.

**Was du lieferst:** zwei bis sieben kurze Namen, welcher offen ist, optional eine Zahl je Reiter.

```html
<div class="wb-reiter" role="tablist">
  <button class="wb-reiter__tab" role="tab" aria-selected="true">Übersicht</button>
  <button class="wb-reiter__tab" role="tab" aria-selected="false">Meldungen<span class="wb-reiter__zahl">3</span></button>
</div>
```

- Offen: Schrift `fett`, darunter 2 px `bernstein`. Zu: `gedaempft`, beim Überfahren `schrift`. Alle in Atkinson 700, damit beim Wechsel nichts springt.
- Grundlinie 1 px `linie` über die ganze Breite.
- Zahl in JetBrains Mono, `gedaempft`, `tabular-nums`.
- Nicht für Abläufe in Schritten: Reiter sind gleichrangig.

---

## Schalter

Ein Schalter stellt eine Einstellung sofort an oder aus, und das Wort daneben sagt, welcher Zustand gilt.

**Was du lieferst:** einen `<button role="switch">` mit `aria-checked`, die Bezeichnung der Einstellung und das Zustandswort, das dein Skript mit umschaltet.

```html
<button class="wb-schalter" role="switch" aria-checked="true">
  <span class="wb-schalter__spur"></span>
  <span>Nachtsicherung</span>
  <span class="wb-schalter__zustand">an</span>
</button>
```

- Spur 36 × 20 px, rund (`ecke-rund`). Aus: Fläche `feld`, Rand `rand-bedien`, Knopf `gedaempft`. An: Fläche `bernstein`, Knopf `on-bernstein` rechts.
- **Farbe entscheidet nie allein:** Lage des Knopfs und das Wort `an`/`aus` tragen den Zustand.
- Wirkt sofort. Muss erst gespeichert werden, ist es kein Schalter, sondern ein Kontrollkästchen.
- Bewegung 150 ms, bei reduzierter Bewegung keine. Fokus: Ring in `fokus`.

---

## Schwebendes Element

Menüs, Dialoge und Aufklapper liegen über dem Inhalt und sind das Einzige mit Schatten.

**Was du lieferst:** den Inhalt (Links, Formular), Position übernimmt der Aufrufer.

- Tiefe entsteht sonst nur über die Flächen `grund` → `panel` → `panel-2` und die `linie`. Das funktioniert genauso im Terminal und auf dem Framebuffer.
- Schatten `schatten-schwebend`, Fläche `panel`, Rahmen `linie`, Ecke `ecke-karte`.
- Auswahl bzw. Hover: `marker-bernstein` mit Text `fett`. Fokus: `fokus`-Ring.

---

## Statuspille

Eine flache Pille mit Kantenleiste und Wort zeigt einen Zustand, und das Wort trägt die Bedeutung, nicht die Farbe.

**Was du lieferst:** ein Wort (gesichert, läuft, eng, gesättigt, geplant …), dazu den Ton über die Klasse.

```html
<span class="wb-status wb-status--gut">gesichert</span>
<span class="wb-status wb-status--gut wb-status--konsole">gesichert</span>
```

- `--gut` Salbei · `--achtung` Gold · `--kritisch` Rosé · `--laeuft` Bernstein · ohne Zusatz Stahl.
- **Form:** links eine **Kantenleiste 3 px im vollen Ton** (`salbei`, `gold` …), wie beim Hinweisband; rechts Ecken `ecke-pille` 3 px; flach, kein Schein. Innenabstand `abstand-1` oben und unten, links 9 px (mit Leiste 12), rechts `abstand-3`, 20 px hoch.
- **Fläche** `pille-*`: 30 % Ton auf `grund`, als fester Hexwert. **Wort** in `status-*`, Atkinson Hyperlegible Next 12 px, Gewicht 700, **immer Versalien**, Sperrung 0,1em (Textstil `pille`).
- **Kontrast**, berechnet nach WCAG: dunkel 4,6 bis 5,5 : 1, hell 4,5 bis 4,6 : 1. Die Form hat daran nichts geändert.
- **Druck:** Papier ist hell. `bundle.css` druckt deshalb immer die hellen Werte, auch für die Kantenleiste, und setzt `print-color-adjust: exact`. Auf Schwarz-Weiß-Druckern werden alle fünf Töne zum selben Grau; dann tragen Wort und Leiste.
- **Immer mit Wort.** Salbei und Rosé sind bei Deuteranopie nur ΔE 3,0 voneinander entfernt, Bernstein und Salbei bei Protanopie 2,8.

## Konsole (N1): Terminal und Statusdisplays

Wo Mono gesetzt ist, also im Terminal, auf dem Statusdisplay und in der Agent' Konsole, gilt die Form vom Systemstart: `[ GESICHERT ]`.

- Klammern in `gedaempft`, Wort in `status-*`, JetBrains Mono 12 px, Gewicht 600, Versalien, Sperrung 0,04em, **keine Fläche**.
- Im HTML `wb-status--konsole` zusätzlich zur Tonklasse. Im Terminal `wb.sh status <ton> <wort>` bzw. `wb.ps1 status <ton> <wort>`.
- Nicht in Fließtext auf Seiten in Atkinson: dort die Pille mit Kantenleiste.

## Herkunft

- 14.10.2026: rund, flach, 30 % (Variante „4.4 Kräftig“ aus 38 Varianten in drei Runden). Vorgängerin: eckige Pille in JetBrains Mono auf `marker-*` (25 %).
- 16.10.2026: Die runde Pille wurde abgelöst. Aus 20 Alternativen (10 professionell, 10 nerdig) gewählt: **P3 Kantenleiste** allgemein, **N1 systemd** für Terminal und Statusdisplays.
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
- **Dezent (20 %)** `dezent-*` mit `--dezent`, Text `schrift`: Einordnung im Fließtext, INFO/OK, Diff-Zeilen.
- Die Hexwerte sind fest, nicht per `color-mix` gerechnet, und kaufmännisch gerundet.
- Höchstens zwei Stufen pro Bildschirm. Eine getönte Fläche schlägt ein eingefärbtes Zeichen.
- Im Terminal: `wb.sh mark [--dezent] <ton> <text>`.

---

## Zeichen

Das Monogramm „wb“ und die Wortmarke „Workbench“ kennzeichnen alles, was zu Workbench gehört, in festen Fassungen und Größen.

**Was du lieferst:** nichts. Die Dateien liegen unter Assets → Zeichen und werden unverändert eingebunden.

```html
<img src="wb-lockup.svg" alt="Workbench" height="32">
<link rel="icon" href="wb-favicon.svg" type="image/svg+xml">
<link rel="icon" href="wb-favicon-32.png" sizes="32x32">
<link rel="apple-touch-icon" href="wb-app-symbol-180.png">
```

- **Schutzraum:** rundum ein Viertel der Kantenlänge des Monogramms (16 bei 64). Gilt auch für den Lockup, gemessen am Monogramm.
- **Mindestgröße:** Monogramm 24 px bzw. 8 mm, darunter die Favicon-Fassung (16 bis 23 px). Lockup ab 24 px Höhe, darunter nur das Monogramm.
- **Fassungen:** dunkel (Bernstein auf `grund`, Wort `fett`) und hell (Bernstein hell auf `grund` hell, Wort `fett` hell). Keine weiteren.
- **Nie:** verzerren, drehen, umfärben, mit Schatten, Schein oder Kontur versehen, die Wortmarke allein oder in einer anderen Schrift setzen, den Abstand im Lockup ändern.
