<#
  wb.ps1 — Workbench-Farben fuer die PowerShell (Windows)
  Gegenstueck zu wb.sh (Bash).
  Quelle der Farbwerte: tokens/tokens.json.

  AUFRUFFORM — bewusst leicht anders als die Bash-Fassung, bitte lesen:

    wb.ps1 mark  [-Dezent] <ton> <text>   Textmarker; schliesst MIT Zeilenumbruch ab.
                                          --dezent (Bash-Schreibweise) geht ebenso.
                                          Fuer die Verwendung mitten im Satz: -NoNewline
    wb.ps1 band  <ton> <text>             Hinweisband ueber die volle Breite
    wb.ps1 swatch                         Palettenuebersicht zum Gegenchecken

    Toene: amber  sage  gold  rose  steel

  Unterschied zur Bash-Fassung: dort gibt `mark` nie einen Zeilenumbruch aus.
  Hier ist es umgekehrt, weil `mark` in der PowerShell meist allein aufgerufen wird.
  Byte-vs-Zeichen-Falle der Bash-Fassung entfaellt: .NET-Strings zaehlen Zeichen.
  Einzige Restfalle: Emoji ausserhalb der BMP zaehlen als 2 Zeichen und franst
  getoente Flaechen aus — in Baendern also keine Emoji.
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory)]
    [ValidateSet('mark', 'band', 'swatch')]
    [string]$Command,

    [Parameter(Position = 1)][string]$Tone,
    [Parameter(Position = 2)][string]$Text,
    [Parameter(ValueFromRemainingArguments)][string[]]$Rest = @(),

    [switch]$Dezent,
    [switch]$NoNewline,
    [int]$Width = 74
)

# Die Bash-Fassung schreibt `mark --dezent <ton> <text>`. PowerShell erkennt --dezent nicht
# als Schalter, sondern reicht es als Positionsargument durch: --dezent landet in $Tone, der
# Ton in $Text, und der Text findet keinen Platz mehr (Fehler vom 06.10.2026). Deshalb hier
# herausfischen — beide Schreibweisen, -Dezent und --dezent, fuehren zum selben Ergebnis.
$pos = @(@($Tone, $Text) + $Rest | Where-Object { $_ -ne '' })
if ($pos -contains '--dezent') {
    $Dezent = $true
    $pos = @($pos | Where-Object { $_ -ne '--dezent' })
}
if ($pos.Count -gt 2) {
    throw "Zu viele Argumente: $($pos -join ' | '). Text mit Leerzeichen in Anfuehrungszeichen setzen."
}
$Tone = if ($pos.Count -gt 0) { $pos[0] } else { '' }
$Text = if ($pos.Count -gt 1) { $pos[1] } else { '' }

$e = [char]27
$R = "$e[0m"; $B = "$e[1m"

function Fg([string]$hex) { "$e[38;2;$([Convert]::ToInt32($hex.Substring(0,2),16));$([Convert]::ToInt32($hex.Substring(2,2),16));$([Convert]::ToInt32($hex.Substring(4,2),16))m" }
function Bg([string]$hex) { "$e[48;2;$([Convert]::ToInt32($hex.Substring(0,2),16));$([Convert]::ToInt32($hex.Substring(2,2),16));$([Convert]::ToInt32($hex.Substring(4,2),16))m" }

$INK = 'e9e3d8'; $BOLD = 'f5f1eb'; $DIM = '6f6961'; $GROUND = '1a1918'; $LINE = '3a3634'

# Akzente
$A = @{ amber = 'cc9166'; sage = '93a373'; gold = 'c7a854'; rose = 'c07f73'; steel = '7d97ab' }
# Marker kraeftig 25 %
$M = @{ amber = '47372c'; sage = '383c2f'; gold = '453d27'; rose = '44322f'; steel = '33383d' }
# Marker dezent 14 %
$S = @{ amber = '332a23'; sage = '2b2c25'; gold = '322d20'; rose = '312725'; steel = '282b2d' }
# Band 33 % — leuchtender, nur fuer Baender
$D = @{ amber = '554132'; sage = '424736'; gold = '53482c'; rose = '513b36'; steel = '3b4349' }

function Assert-Tone([string]$t) {
    if (-not $t -or -not $A.ContainsKey($t)) {
        throw "Unbekannter Ton '$t'. Erlaubt: $($A.Keys -join ' ')"
    }
}

# Auf Zeichenbreite auffuellen (nicht auf Bytes — deshalb kein -f '%-*s')
function Pad([string]$t, [int]$w) {
    $n = $w - $t.Length
    if ($n -lt 0) { $n = 0 }
    $t + (' ' * $n)
}

switch ($Command) {

    'mark' {
        Assert-Tone $Tone
        if ($Dezent) { $bgHex = $S[$Tone]; $fgHex = $INK;  $weight = '' }
        else         { $bgHex = $M[$Tone]; $fgHex = $BOLD; $weight = $B }
        $out = "$(Bg $bgHex)$(Fg $fgHex)$weight $Text $R"
        if ($NoNewline) { [Console]::Write($out) } else { [Console]::WriteLine($out) }
    }

    'band' {
        Assert-Tone $Tone
        $body = Pad $Text ($Width - 4)
        [Console]::WriteLine("$(Fg $A[$Tone])$([char]0x258C)$(Bg $D[$Tone])$(Fg $INK) $body $R")
    }

    'swatch' {
        $w = $Width
        [Console]::WriteLine("$(Fg $A.amber)$B$(Pad 'WORKBENCH — die Hausfarben' $w)$R")
        [Console]::WriteLine("$(Fg $DIM)$(Pad ('-' * $w) $w)$R")
        [Console]::WriteLine('')

        [Console]::WriteLine("$(Fg $DIM)  GRUNDWERTE$R")
        foreach ($g in @(
            @('Grund',            $GROUND), @('Panel',   '232120'), @('Panel 2', '2b2827'),
            @('Linie',            $LINE),   @('Rille',   '151413')
        )) {
            [Console]::WriteLine(("$(Bg $g[1])$(Fg $INK)      $R  $(Fg $INK)" + (Pad $g[0] 20) + "$(Fg $DIM)#$($g[1])$R"))
        }
        [Console]::WriteLine('')

        [Console]::WriteLine("$(Fg $DIM)  SCHRIFT$R")
        foreach ($g in @(@('Fettschrift', $BOLD), @('Schrift', $INK), @('gedaempft', 'a49c90'), @('schwach', $DIM))) {
            [Console]::WriteLine(("$(Fg $g[1])  " + (Pad ('Aa 0123 — ' + $g[0]) 32) + "$(Fg $DIM)#$($g[1])$R"))
        }
        [Console]::WriteLine('')

        [Console]::WriteLine("$(Fg $DIM)  AKZENT      MARKER 25 %        DEZENT 14 %        BAND 33 %$R")
        foreach ($k in 'amber', 'sage', 'gold', 'rose', 'steel') {
            $line  = "$(Bg $A[$k])$(Fg $GROUND)$B " + (Pad $k 10) + "$R  "
            $line += "$(Bg $M[$k])$(Fg $BOLD)$B " + (Pad "#$($M[$k])" 16) + "$R "
            $line += "$(Bg $S[$k])$(Fg $INK)"      + (Pad " #$($S[$k])" 17) + "$R "
            $line += "$(Bg $D[$k])$(Fg $INK)"      + (Pad " #$($D[$k])" 17) + "$R"
            [Console]::WriteLine($line)
        }
        [Console]::WriteLine('')

        [Console]::WriteLine("$(Fg $DIM)  ANSI 0-7 / 8-15$R")
        $lo = '2b2827', 'c07f73', '93a373', 'c7a854', '7d97ab', 'b1899b', '7fa79f', 'a49c90'
        $hi = '6f6961', 'd69a8d', 'adbb8e', 'ddc274', '9ab2c4', 'c9a3b4', '9bc0b8', 'e9e3d8'
        $l1 = '  '; foreach ($c in $lo) { $l1 += "$(Bg $c)     $R" }
        $l2 = '  '; foreach ($c in $hi) { $l2 += "$(Bg $c)     $R" }
        [Console]::WriteLine($l1); [Console]::WriteLine($l2)
        [Console]::WriteLine('')

        [Console]::WriteLine("$(Fg $DIM)  BEISPIELE$R")
        [Console]::WriteLine("$(Bg $M.amber)$(Fg $BOLD)$B Kernergebnis $R$(Fg $INK) — kraeftig, hoechstens zweimal pro Bildschirm$R")
        [Console]::WriteLine("$(Bg $S.steel)$(Fg $INK) Einordnung $R$(Fg $INK) — dezent, darf mehrfach vorkommen$R")
        [Console]::WriteLine("$(Fg $A.rose)$([char]0x258C)$(Bg $D.rose)$(Fg $INK) $(Pad 'Hinweisband — volle Breite, eigener Ton mit 33 %' ($w - 4)) $R")
    }
}
