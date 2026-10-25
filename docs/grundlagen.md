# Grundlagen

Workbench ist ein persönlicher Hausstil für alles, was am Bildschirm erscheint: Terminals, HTML-Seiten, Dashboards, Diagramme, ein Statusdisplay. Der Name kommt vom Betriebssystem des Amiga 500, nicht von der Werkbank.

## Wann Workbench gilt und wann nicht

- **Gilt** für alles Private und die eigene Technik: Antworten mit Farbe, Artefakte, Notizen, Skripte, eigene Webseiten.
- **Gilt nicht** für Arbeit mit eigenem Corporate Design. Dort niemals Workbench-Töne mischen.

## Die drei Regeln

1. **Der Grund ist warm.** `grund` ist `#1a1918`, nie ein neutrales `#1e1e1e`. Ein reines Grau wirkt unbedacht.
2. **Ein lauter Akzent.** Nur `bernstein` darf laut sein: Cursor, Überschrift, das eine Wichtige. Alles andere tritt zurück.
3. **Eine Familie.** Alle Buntwerte sind gedämpft und erdig, wie eine alte Instrumententafel. Kein Neon, kein reines Rot, Grün oder Blau. Die einzige Ausnahme ist der gedämpfte Schein der Statuspille für kritisch und läuft, nur dunkel.

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
- **Farbe entscheidet nie allein.** Jede Statusfläche trägt ein Wort. In der Statuspille steht das Wort in `status-*` auf `pille-*` (30 %). Salbei und Rosé sind bei Deuteranopie kaum zu trennen (ΔE 3,0).
- Hell: `bernstein` (`#975b34`) und `gold` (`#7e6820`) erreichen 4,5 : 1 auf `grund` und `panel`, aber nicht auf `panel-2`. Dort sind sie als Text tabu.
- Text auf voller Bernstein-Fläche ist `on-bernstein`.

## Hervorhebung

Fünf Stufen, aufsteigend: `gedaempft` · `schrift` · `fett` · `bernstein` · Textmarker. **Höchstens zwei pro Bildschirm.**

- **Textmarker kräftig** `marker-*` (25 %): das Kernergebnis, Warnungen, FEHLER. Text `fett`.
- **Textmarker dezent** `dezent-*` (20 %): Einordnungen im Fließtext, INFO/OK, Diff-Zeilen. Text `schrift`.
- **Hinweisband** `band-*` (33 %): die eine Kernaussage, über die volle Breite.
- **Statuspille** `pille-*` (30 %): ein Zustand mit Wort, flach, links eine Kantenleiste 3 px im vollen Ton, rechts Ecken 3 px, Wort in Versalien. Im Terminal und auf Statusdisplays in der Konsolenform `[ GESICHERT ]`. Sie zählt nicht als Hervorhebungsstufe, sondern als Inhalt.
- **Statuspille mit Schein** `schein-*` (30 %): nur kritisch und läuft, nur dunkel und am Bildschirm. Ring 1 px, Innen- und Außenschein, leuchtendes Wort in `schein-wort-*`, läuft pulsiert. Sie **zählt als Hervorhebungsstufe**, höchstens eine je Bildschirm. Hell und im Druck die flache Form. Seit 25.10.2026, abgeleitet vom SOS-Knopf.
- Die Werte sind feste Hexwerte, kaufmännisch gerundet, und auf allen Trägern identisch.

## Schrift

Drei Schriften, jede mit einer Aufgabe:

- **Instrument Serif** (`serif`) für Seiten- und Abschnittstitel und kursiv für Anmerkungen. Sie gibt dem Titel einen eigenen Ton gegenüber dem Text. Nur Schnitt 400; Hervorhebung kommt aus Größe und `fett`, nicht aus Gewicht. Nie für Fließtext, Bedienelemente oder Zahlen. Seit 18.10.2026.
- **Atkinson Hyperlegible Next** (`sans`) für Unterüberschriften, Text, Namen und Bedienelemente. Gewählt für Lesbarkeit: I, l und 1 sind klar getrennt.
- **JetBrains Mono** (`mono`) für Code, Befehle, Pfade, Zahlen in Tabellen und alle Beschriftungen. Ziffern mit `tabular-nums`. Nur für Technisches, nie als Schrift für alles.
- Stile: Serif `anzeige` 40 · `titel` 28 · `anmerkung` 16 kursiv; Sans `abschnitt` 19 · `text` 15 · `klein` 13 · `pille` 12 in Versalien · `knopf` 15; Mono `mono-text` 13 · `beschriftung` 11 in Versalien mit 0,18em Sperrung · `zahl-gross` 34.
- Alle drei kommen von Google Fonts. Im Terminal gilt JetBrains Mono bzw. die Nerd-Font-Variante; dort gibt es keine Serife.
- Die Wortmarke im Lockup bleibt Atkinson ExtraBold.

## Raster, Ecken, Tiefe

- 4er-Raster: `abstand-1` 4 · `abstand-2` 8 · `abstand-3` 12 · `abstand-4` 16 · `abstand-6` 24 · `abstand-8` 32 · `abstand-12` 48.
- Ecken: `ecke-karte` 6 px für Karten und Tafeln, `ecke-marker` 3 px für Marker und Knöpfe, `ecke-pille` 3 px rechts an der Statuspille, `ecke-rund` nur für die Schalterspur.
- Tiefe kommt aus den Flächen-Ebenen und der Linie. `schatten-schwebend` nur für Menüs und Dialoge, die über dem Inhalt liegen. Karten haben keinen Schatten.
- Fokus: 2 px durchgehender Ring in `fokus` (Stahl), 2 px Abstand, auf allen Flächen ≥ 3 : 1.

## Druck

- Papier ist hell: gedruckt wird immer mit den Werten des hellen Themas, auch wenn der Bildschirm dunkel ist.
- Getönte Flächen (Pille, Marker, Band) brauchen `print-color-adjust: exact`, sonst lässt der Browser sie weg.
- Schatten, Schein und Animation gibt es auf Papier nicht. Was gedruckt werden soll, braucht keins davon.
- Auf Schwarz-Weiß-Druckern fallen die Töne zusammen. Deshalb gilt die Regel „Farbe entscheidet nie allein“ auf Papier erst recht.

## Diagramme

- Eine Reihe: `diagramm-reihe` (Stahl), der hervorgehobene Wert `diagramm-hervorhebung` (Bernstein).
- Mehrere Reihen: `diagramm-1` bis `diagramm-4` (Bernstein · Stahl · Petrol · Gold), höchstens vier, Beschriftung direkt an der Reihe statt Legende.
- Dauerbildschirme zeigen Fluss und Verlauf, nicht Zustand. Zustand meldet schon das Handy.
- Schaubilder (Architektur, Abläufe, Zeitleisten) zeichnet das Claude-Code-Plugin diagram-design mit dem Profil `workbench`: Titel in `serif`, Namen in `sans`, Beschriftungen in `mono`, Bernstein nur für den Fokus. In Artefakten folgen die Diagrammfarben über CSS-Variablen dem Thema.

## Bedienelemente

- **Knopf** in vier Arten: Haupt (`bernstein`, höchstens einer je Bereich), Zweit (Normalfall), Leise, Gefahr. 32 px hoch, klein 24 px. Die Beschriftung ist ein Verb, das sagt, was passiert.
- **Eingabefeld** mit Beschriftung darüber und Hilfe oder Fehler darunter. Ein Fehlertext sagt, wie es richtig geht.
- **Schalter** für Einstellungen, die sofort wirken, immer mit dem Wort `an` oder `aus`.
- **Reiter** für gleichrangige Ansichten, **Meldung** als schwebende Rückmeldung nach einer Aktion, **Leerzustand** für Flächen ohne Inhalt.
- Rahmen von Bedienelementen in `rand-bedien` (mindestens 3 : 1 auf allen Flächen), Feldflächen in `feld`. Zustände: Überfahren, Fokusring in `fokus`, deaktiviert in `schwach` mit Begründung daneben.

## Zeichen

- Das Monogramm **wb** in Bernstein auf `grund`, aus Linien mit runden Enden gezeichnet (`wb-monogramm.svg`, hell `wb-monogramm-hell.svg`).
- Der **Lockup** setzt die Wortmarke „Workbench“ in Atkinson Hyperlegible Next ExtraBold neben das Monogramm, als Pfade (`wb-lockup.svg`, `wb-lockup-hell.svg`). Die Wortmarke gibt es nur im Lockup.
- In 16 bis 23 px gilt die Favicon-Fassung, für Startbildschirme das vollflächige App-Symbol in 180, 192 und 512 px.
- Schutzraum ein Viertel der Kantenlänge des Monogramms, Mindestgröße 24 px bzw. 8 mm. Nie verzerren, umfärben oder mit Effekten versehen. Fassung 1.0 vom 14.10.2026, Einzelheiten im Baustein **Zeichen**.
