# =====================================================================
#  PowerShell-Profil — Workbench-Erscheinungsbild, Windows
#  Maschinenneutral: enthaelt keinen Rechnernamen und keinen festen Pfad.
#  Workbench 1.0.
#
#  Traegt die Workbench-Hausfarben (Vault: "Farbpalette Workbench") in
#  die Shell: PSReadLine, PSStyle, Dateilisten, Prompt.
#  Gilt fuer alle pwsh-7-Hosts ($PROFILE.CurrentUserAllHosts) — Konsole,
#  Windows Terminal, VS Code, Claude Code.
#
#  Gibt bewusst NICHTS aus. Ein Profil, das schreibt, zerlegt jede
#  Ausgabe, die maschinell gelesen wird.
# =====================================================================

# --- Grundlagen ------------------------------------------------------
[Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8NoBOM'

if (Test-Path "$HOME\bin") {
    if ($env:PATH -notlike "*$HOME\bin*") { $env:PATH = "$HOME\bin;$env:PATH" }
}

# --- Startordner -----------------------------------------------------
# Eine interaktive Shell beginnt in ~\Workbench.
# Das Terminal setzt den Ordner selbst (startingDirectory); dies faengt den
# Rest ab — Startmenue, Win+X, conhost. Nur wenn die Shell im Benutzer- oder
# System32-Ordner aufgeht und kein Skript laeuft; Claude Code, VS Code und
# "Im Terminal oeffnen" behalten ihren Ordner.
if (-not $env:CLAUDECODE -and (Test-Path "$HOME\Workbench") -and
    -not ([Environment]::GetCommandLineArgs() -match '^-(c|command|f|file|e|ec|encodedcommand)$') -and
    ($PWD.Path -eq $HOME -or $PWD.Path -eq [Environment]::SystemDirectory)) {
    Set-Location "$HOME\Workbench"
}

# --- Die Palette -----------------------------------------------------
$e = [char]27
function script:Fg([string]$h) { "$e[38;2;$([Convert]::ToInt32($h.Substring(0,2),16));$([Convert]::ToInt32($h.Substring(2,2),16));$([Convert]::ToInt32($h.Substring(4,2),16))m" }
function script:Bg([string]$h) { "$e[48;2;$([Convert]::ToInt32($h.Substring(0,2),16));$([Convert]::ToInt32($h.Substring(2,2),16));$([Convert]::ToInt32($h.Substring(4,2),16))m" }

$WB = @{
    Grund    = '1a1918'; Panel = '232120'; Panel2 = '2b2827'; Linie = '3a3634'
    Ink      = 'e9e3d8'; Fett  = 'f5f1eb'; Dim    = 'a49c90'; Schwach = '6f6961'
    Amber    = 'cc9166'; Sage  = '93a373'; Steel  = '7d97ab'; Gold = 'c7a854'
    Rose     = 'c07f73'; Malve = 'b1899b'; Petrol = '7fa79f'
    MarkRose = '44322f'; MarkGold = '453d27'; MarkSteel = '33383d'
}
Set-Variable -Name WB -Scope Global -Value $WB -Force

# --- PSReadLine ------------------------------------------------------
# Semantik wie im Vault: Bernstein = das Wichtigste, Salbei = gut,
# Stahl = Daten/Verweise, Gold = Achtung, Rose = Fehler.
if (Get-Module PSReadLine -ListAvailable) {
    Set-PSReadLineOption -Colors @{
        Command                = (Fg $WB.Amber)
        Parameter              = (Fg $WB.Steel)
        Operator               = (Fg $WB.Dim)
        Variable               = (Fg $WB.Sage)
        String                 = (Fg $WB.Gold)
        Number                 = (Fg $WB.Petrol)
        Type                   = (Fg $WB.Malve)
        Comment                = (Fg $WB.Schwach)
        Keyword                = (Fg $WB.Malve)
        Member                 = (Fg $WB.Ink)
        Default                = (Fg $WB.Ink)
        Error                  = (Fg $WB.Rose)
        ContinuationPrompt     = (Fg $WB.Schwach)
        Emphasis               = "$(Bg $WB.MarkGold)$(Fg $WB.Fett)"
        Selection              = "$(Bg $WB.Amber)$(Fg $WB.Grund)"
        InlinePrediction       = (Fg $WB.Schwach)
        ListPrediction         = (Fg $WB.Schwach)
        ListPredictionSelected = "$(Bg $WB.Linie)$(Fg $WB.Fett)"
    }
    Set-PSReadLineOption -BellStyle None
}

# --- PSStyle: Formatierung, Fehler, Tabellen, Dateilisten -----------
if ($PSStyle) {
    $f = $PSStyle.Formatting
    $f.FormatAccent      = (Fg $WB.Amber)
    $f.TableHeader       = "$(Fg $WB.Amber)$($PSStyle.Bold)"
    $f.ErrorAccent       = (Fg $WB.Rose)
    $f.Error             = "$(Bg $WB.MarkRose)$(Fg $WB.Fett)"
    $f.Warning           = "$(Bg $WB.MarkGold)$(Fg $WB.Fett)"
    $f.Verbose           = (Fg $WB.Steel)
    $f.Debug             = (Fg $WB.Schwach)
    foreach ($p in 'CustomTableHeaderLabel', 'FeedbackName', 'FeedbackText', 'FeedbackAction') {
        if ($f.PSObject.Properties[$p]) {
            $f.$p = if ($p -eq 'FeedbackText') { Fg $WB.Dim } else { Fg $WB.Steel }
        }
    }

    $PSStyle.Progress.Style = "$(Bg $WB.MarkSteel)$(Fg $WB.Fett)"

    $fi = $PSStyle.FileInfo
    # Verzeichnisse in Bernstein — ohne getoente Flaeche: bei einem
    # Dutzend Ordnern wuerde die halbe Ausgabe zur Flaeche.
    $fi.Directory  = "$(Fg $WB.Amber)$($PSStyle.Bold)"
    $fi.SymbolicLink = (Fg $WB.Petrol)
    $fi.Executable = (Fg $WB.Sage)
    foreach ($x in '.zip', '.7z', '.tar', '.xz', '.gz', '.iso', '.msi') { $fi.Extension[$x] = Fg $WB.Malve }
    foreach ($x in '.ps1', '.psm1', '.psd1', '.cmd', '.bat', '.sh')     { $fi.Extension[$x] = Fg $WB.Sage }
    foreach ($x in '.md', '.txt', '.log')                               { $fi.Extension[$x] = Fg $WB.Dim }
    foreach ($x in '.json', '.yml', '.yaml', '.toml', '.ini', '.xml')   { $fi.Extension[$x] = Fg $WB.Gold }
    foreach ($x in '.png', '.jpg', '.jpeg', '.webp', '.svg', '.pdf')    { $fi.Extension[$x] = Fg $WB.Petrol }
}

# --- wb: Textmarker und Hinweisbaender ------------------------------
# Vorgabe aus der CLAUDE.md: Status, Messwerte, Inventar, Vergleiche
# bekommen mindestens einen Farbblock. Traeger ist dieses Skript.
if (Test-Path "$HOME\bin\wb.ps1") {
    function global:wb { & "$HOME\bin\wb.ps1" @args }
}

# --- md: Markdown lesen mit Glow ------------------------------------
# md zeigt Markdown an und legt keinen Ordner mehr an
# (eingebaut ist md = mkdir; Ordner jetzt mit mkdir). Nicht in Claude Code,
# dort koennte ein Befehl md noch als mkdir erwarten.
if (-not $env:CLAUDECODE -and (Get-Command glow -CommandType Application -ErrorAction Ignore)) {
    Remove-Alias md -Force -ErrorAction Ignore
    function global:md { glow @args }
}

# --- Prompt ----------------------------------------------------------
# Nerd-Font-Glyphen; ohne JetBrainsMono Nerd Font stehen dort Kaesten.
$script:HasGit = [bool](Get-Command git -ErrorAction Ignore)
$script:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
                  ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

function global:prompt {
    $rc = $?

    # Pfad, Home als Tilde
    $p = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($p.StartsWith($HOME, [StringComparison]::OrdinalIgnoreCase)) {
        $p = '~' + $p.Substring($HOME.Length)
    }

    $out  = "$e[0m"
    $out += "$(Fg $WB.Schwach)$([char]0xF07B) "                 # Ordner-Glyph
    $out += "$(Fg $WB.Steel)$p"

    if ($script:HasGit) {
        $branch = git branch --show-current 2>$null
        if ($branch) {
            $dirty = git status --porcelain 2>$null
            $col = if ($dirty) { $WB.Gold } else { $WB.Sage }
            $out += "$(Fg $WB.Schwach)  $([char]0xE725) $(Fg $col)$branch"
        }
    }

    if ($script:IsAdmin) { $out += "$(Fg $WB.Rose)  $([char]0xF0E7) admin" }

    $arrowColor = if ($rc) { $WB.Amber } else { $WB.Rose }
    $out += "`n$(Fg $arrowColor)$([char]0x276F)$e[0m "
    $out
}
