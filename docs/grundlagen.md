# Grundlagen

Workbench ist ein persönlicher Hausstil für alles, was am Bildschirm erscheint: Terminals, HTML-Seiten, Dashboards, Diagramme, ein Statusdisplay. Der Name kommt vom Betriebssystem des Amiga 500, nicht von der Werkbank.

## Wann Workbench gilt und wann nicht

- **Gilt** für alles Private und alles Homelab: Antworten mit Farbe, Artefakte, Notizen, Skripte, eigene Webseiten.
- **Gilt nicht** für Arbeit mit eigenem Corporate Design. Dort niemals Workbench-Töne mischen.

## Die drei Regeln

1. **Der Grund ist warm.** `grund` ist `#1a1918`, nie ein neutrales `#1e1e1e`. Ein reines Grau wirkt unbedacht.
2. **Ein lauter Akzent.** Nur `bernstein` darf laut sein: Cursor, Überschrift, das eine Wichtige. Alles andere tritt zurück.
3. **Eine Familie.** Alle Buntwerte sind gedämpft und erdig, wie eine alte Instrumententafel. Kein Neon, kein reines Rot, Grün oder Blau.

## Sprache und Inhalt

- Deutsch mit echten Umlauten (ä ö ü ß), nie ae, oe, ue, ss.
- Zahlen deutsch: `1.740`, `4,5 : 1`, `1.000,00 EUR`, Datum `08.10.2026`.
- Kernaussage zuerst, dann die Struktur, dann Prosa. Nebenbefunde weglassen statt einzustreuen.
- Jede Zahl sagt, ob sie **gemessen** oder **geschätzt** ist. Eine Grafik wirkt präziser, als die Daten sind.
- Unsicheres kennzeichnen. „Ich weiß es nicht“ ist eine zulässige Antwort.
- Keine Emoji. Statuszeichen sind `● ✗ ▸ ⚠ ✔ ⏸ ◐`, Struktur kommt aus Box-Zeichen `╭─│└├╰` und Balken aus `█`.

## Farbe

- Flächen in drei Ebenen: `grund` → `panel` → `panel-2`, getrennt durch `linie`. `rille` ist der leere Teil von Balken.
- Text: `schrift` für Fließtext, `gedaempft` für Nebentext **und alle Beschriftungen**, `fett` für Fettes und für Text auf kräftigem Marker.
- `schwach` nur für Linien, Raster, Rahmen und Deaktiviertes. Als Text erreicht es nur 3,2 : 1.
- Bedeutung: `salbei` gut, `gold` Achtung oder geschätzt, `rose` kritisch (geschrieben „Rosé“), `stahl` neutral und Daten, `bernstein` läuft oder das Wichtigste.
- `malve` und `petrol` sind Nebentöne für Code-Hervorhebung. Im Diagramm nie zusammen.
- **Farbe entscheidet nie allein.** Jede Statusfläche trägt ein Wort. In der Statuspille steht das Wort in `status-*` auf `marker-*`. Salbei und Rosé sind bei Deuteranopie kaum zu trennen (ΔE 3,0).
- Hell: `bernstein` (`#975b34`) und `gold` (`#7e6820`) erreichen 4,5 : 1 auf `grund` und `panel`, aber nicht auf `panel-2`. Dort sind sie als Text tabu.
- Text auf voller Bernstein-Fläche ist `on-bernstein`.

## Hervorhebung

Fünf Stufen, aufsteigend: `gedaempft` · `schrift` · `fett` · `bernstein` · Textmarker. **Höchstens zwei pro Bildschirm.**

- **Textmarker kräftig** `marker-*` (25 %): das Kernergebnis, Warnungen, FEHLER. Text `fett`.
- **Textmarker dezent** `dezent-*` (14 %): Einordnungen im Fließtext, INFO/OK, Diff-Zeilen. Text `schrift`.
- **Hinweisband** `band-*` (33 %): die eine Kernaussage, über die volle Breite.
- Die Werte sind feste Hexwerte, kaufmännisch gerundet, und auf allen Trägern identisch.

## Schrift

- **Atkinson Hyperlegible Next** (`sans`) für Überschriften und Text. Gewählt für Lesbarkeit: I, l und 1 sind klar getrennt.
- **JetBrains Mono** (`mono`) für Code, Befehle, Pfade, Zahlen in Tabellen und alle Beschriftungen. Ziffern mit `tabular-nums`.
- Stile: `anzeige` 32 · `titel` 24 · `abschnitt` 19 · `text` 15 · `klein` 13; Mono: `mono-text` 13 · `beschriftung` 11 in Versalien mit 0,18em Sperrung · `zahl-gross` 34.
- Beide Schriften kommen von Google Fonts. Im Terminal gilt JetBrains Mono bzw. die Nerd-Font-Variante.

## Raster, Ecken, Tiefe

- 4er-Raster: `abstand-1` 4 · `abstand-2` 8 · `abstand-3` 12 · `abstand-4` 16 · `abstand-6` 24 · `abstand-8` 32 · `abstand-12` 48.
- Ecken: `ecke-karte` 6 px für Karten und Tafeln, `ecke-marker` 3 px für Marker, Pillen und Knöpfe.
- Tiefe kommt aus den Flächen-Ebenen und der Linie. `schatten-schwebend` nur für Menüs und Dialoge, die über dem Inhalt liegen. Karten haben keinen Schatten.
- Fokus: 2 px durchgehender Ring in `fokus` (Stahl), 2 px Abstand, auf allen Flächen ≥ 3 : 1.

## Diagramme

- Eine Reihe: `diagramm-reihe` (Stahl), der hervorgehobene Wert `diagramm-hervorhebung` (Bernstein).
- Mehrere Reihen: `diagramm-1` bis `diagramm-4` (Bernstein · Stahl · Petrol · Gold), höchstens vier, Beschriftung direkt an der Reihe statt Legende.
- Dauerbildschirme zeigen Fluss und Verlauf, nicht Zustand. Zustand meldet schon das Handy.

## Zeichen

- Das Monogramm **wb** in Bernstein auf `grund`, Ecke 6 px (`wb-monogramm.svg`), hell in Bernstein auf hellem Grund (`wb-monogramm-hell.svg`).
- In 16 px die vereinfachte Fassung `wb-favicon.svg`.
- Das Zeichen ist ein Entwurf vom 08.10.2026. Es ist aus Linien gezeichnet, nicht aus der Schrift gesetzt, damit es als Bild ohne Webfont funktioniert.
