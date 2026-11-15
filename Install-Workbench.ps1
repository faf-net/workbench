# Workbench for Claude Code: design skill, text-graphics skill and the diagram-design profile in one go.
# Windows (PowerShell 7 or 5.1). Idempotent.
param(
    [switch]$NoDiagrams,
    [switch]$NoTextgrafik
)
$ErrorActionPreference = 'Stop'
$hier = Split-Path -Parent $MyInvocation.MyCommand.Path

# 1. Design skill, self-contained: the skill file plus the values it refers to
$ziel = Join-Path $HOME '.claude\skills\workbench-design'
New-Item -ItemType Directory -Force -Path $ziel | Out-Null
$dateien = @(
    @('workbench-design\SKILL.md', 'SKILL.md'),
    @('tokens\tokens.json', 'tokens.json'),
    @('css\workbench.css', 'workbench.css'),
    @('components\workbench-components.css', 'workbench-components.css'),
    @('components\README.md', 'components.md'),
    @('docs\grundlagen.md', 'grundlagen.md')
)
foreach ($d in $dateien) {
    Copy-Item -Force (Join-Path $hier $d[0]) (Join-Path $ziel $d[1])
}
Write-Host "workbench-design: skill installed ($ziel)"

# 2. Text graphics
if (-not $NoTextgrafik) {
    & (Join-Path $hier 'textgrafik\Install-Textgrafik.ps1')
}

# 3. Diagrams: profile for the third-party plugin diagram-design
if (-not $NoDiagrams) {
    try {
        & (Join-Path $hier 'diagram-design\Install-DiagramDesign.ps1')
    } catch {
        Write-Warning "diagram-design: not set up. Install the plugin, then run diagram-design\Install-DiagramDesign.ps1 again. ($($_.Exception.Message))"
    }
}
