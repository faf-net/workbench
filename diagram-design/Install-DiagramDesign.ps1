﻿# diagram-design mit Workbench-Profil einrichten — Windows (PowerShell 7 oder 5.1).
# Idempotent: darf nach jedem Plugin-Update erneut laufen.
$ErrorActionPreference = 'Stop'

$hier       = Split-Path -Parent $MyInvocation.MyCommand.Path
$profileDir = Join-Path $HOME '.diagram-design\profiles'
$quelle     = Join-Path $hier 'workbench.md'

if (Get-Command claude -ErrorAction SilentlyContinue) {
    claude plugin marketplace add cathrynlavery/diagram-design 2>&1 | Out-Null
    claude plugin install diagram-design@diagram-design 2>&1 | Out-Null
} else {
    Write-Warning 'claude nicht im PATH — Plugin in Claude Code von Hand installieren:'
    Write-Warning '  /plugin marketplace add cathrynlavery/diagram-design'
    Write-Warning '  /plugin install diagram-design@diagram-design'
}

# Neueste installierte Fassung finden
$cache = Join-Path $HOME '.claude\plugins\cache\diagram-design\diagram-design'
$sg = Get-ChildItem $cache -Directory -ErrorAction SilentlyContinue |
      Sort-Object { try { [version]$_.Name } catch { [version]'0.0' } } |
      Select-Object -Last 1 |
      ForEach-Object { Join-Path $_.FullName 'skills\diagram-design\references\style-guide.md' }
if (-not $sg -or -not (Test-Path $sg)) { throw 'Plugin nicht gefunden — erst installieren, dann erneut ausführen.' }

New-Item -ItemType Directory -Force -Path $profileDir | Out-Null

# Werksfassung sichern, solange die installierte Vorlage noch unverändert ist
$default = Join-Path $profileDir 'default.md'
$ersteZeile = Get-Content $sg -TotalCount 1 -Encoding UTF8
if (-not (Test-Path $default) -and $ersteZeile -notmatch 'diagram-design-profile') {
    $heute = Get-Date -Format 'yyyy-MM-dd'
    $kopf = "<!-- diagram-design-profile`nname: Default`nslug: default`nsource-url: none`ncreated: $heute`nupdated: $heute`nnotes: Pristine shipped style guide`n-->`n"
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [IO.File]::WriteAllText($default, $kopf + [IO.File]::ReadAllText($sg, $utf8), $utf8)
}

Copy-Item $quelle (Join-Path $profileDir 'workbench.md') -Force
Copy-Item $quelle $sg -Force
if ((Get-FileHash $quelle).Hash -eq (Get-FileHash $sg).Hash) {
    Write-Host "diagram-design: Profil workbench aktiv ($sg)"
}
