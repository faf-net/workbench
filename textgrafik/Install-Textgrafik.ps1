# Skill „textgrafik“ für Claude Code einrichten — Windows (PowerShell 7 oder 5.1). Idempotent.
$ErrorActionPreference = 'Stop'
$hier = $PSScriptRoot
$ziel = Join-Path $HOME '.claude\skills\textgrafik'
New-Item -ItemType Directory -Force -Path (Join-Path $ziel 'beispiel') | Out-Null
Copy-Item (Join-Path $hier 'SKILL.md'), (Join-Path $hier 'textgrafik.js'), (Join-Path $hier 'pruefen.sh') $ziel -Force
Copy-Item (Join-Path $hier 'beispiel\erdrand.html'), (Join-Path $hier 'beispiel\erdrand.js') (Join-Path $ziel 'beispiel') -Force
if ((Get-FileHash (Join-Path $hier 'textgrafik.js')).Hash -eq (Get-FileHash (Join-Path $ziel 'textgrafik.js')).Hash) {
  Write-Host "textgrafik: Skill eingerichtet ($ziel)"
}
