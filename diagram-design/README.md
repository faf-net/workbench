# Diagramme mit diagram-design

Schaubilder (Architektur, Abläufe, Sequenzen, Zeitleisten und rund 40 weitere Typen) zeichne ich mit dem Claude-Code-Plugin [diagram-design](https://github.com/cathrynlavery/diagram-design) von Cathryn Lavery (MIT). Es erzeugt eine eigenständige HTML-Datei mit eingebettetem SVG und holt Farben und Schriften aus einem austauschbaren Profil. Das Profil `workbench.md` in diesem Ordner gibt ihm die Workbench-Farben und -Schriften. Ich nutze es auf allen Rechnern, auf denen Claude Code läuft.

## Einrichten

```
bash diagram-design/install.sh                          # Linux, macOS, Git Bash
pwsh -File diagram-design/Install-DiagramDesign.ps1     # Windows
```

Beide Skripte installieren das Plugin über die Kommandozeile von Claude Code (`claude plugin install`), sichern die Werksfassung als `~/.diagram-design/profiles/default.md` und setzen `workbench` als Profil und als Standard der Installation. Danach in Claude Code `/reload-plugins` eingeben. **Nach jedem Update des Plugins erneut ausführen**, weil das Update die mitgelieferte Stilvorlage ersetzt.

Statt des Skripts geht es auch von Hand:

```
/plugin marketplace add cathrynlavery/diagram-design
/plugin install diagram-design@diagram-design
```

und danach `workbench.md` nach `~/.diagram-design/profiles/workbench.md` kopieren. Eine Datei `.diagram-design` mit der Zeile `profile: workbench` im Projektordner wählt das Profil für dieses Projekt.

## Was das Profil festlegt

| Rolle im Plugin | Workbench | dunkel / hell |
|---|---|---|
| paper · paper-2 | grund · panel | `#1a1918` `#232120` / `#efeae1` `#f7f3ec` |
| ink · muted | schrift · gedämpft | `#e9e3d8` `#a49c90` / `#2a2724` `#6a6258` |
| accent · accent-tint | Bernstein · dezent | `#cc9166` `#3e3128` / `#975b34` `#ddcdbe` |
| link | Stahl | `#7d97ab` / `#456579` |
| Reihen | Stahl · Petrol · Gold | höchstens vier zusammen mit Bernstein |
| Schrift | Instrument Serif · Atkinson Hyperlegible Next · JetBrains Mono | Titel · Namen · Technisches |

Dunkel ist das Hauptthema, gedruckt wird hell. Bernstein steht nur auf ein bis zwei Elementen, dem Fokus. Ein Abschnitt „Workbench overrides“ am Anfang des Profils ersetzt Geist durch Atkinson und Geist Mono durch JetBrains Mono. Die Checkliste des Plugins verbietet JetBrains Mono, weil generische Diagramme sie für alles verwenden. Hier steht sie nur bei Technischem, also dort, wo das Plugin Monospace vorsieht.

## Was ich beim Testen gelernt habe

- **Masken auf Zonen:** Die Masken hinter Beschriftungen brauchen die Farbe der Zonenfläche (`#1e1d1c` dunkel, `#ebe6dd` hell), sonst stehen dunkle Flecken im Bild. Steht im Profil.
- **Kontrast:** Die Kontrastprüfung des Plugins (`verify-contrast.py`) meldet einen Befund: Helle Schrift auf halbdurchsichtigem Bernstein erreicht im hellen Modus 3,77 : 1. Deshalb sind Bernsteinflächen mit Text im hellen Modus deckend (4,92 : 1).
- **Für Seiten mit Hell und Dunkel** (eingebettet in eine Webseite oder ein Artefakt) laufen die Farben im SVG über CSS-Variablen statt fester Werte. Ports und Adressen bleiben in solchen Ausgaben draußen.
