<#
.SYNOPSIS
Start the local frontend by serving the `site/` folder over HTTP.

.DESCRIPTION
This script launches a local HTTP server from the repository's `site/` directory.
It uses Python's stdlib `http.server`, which is available in all standard Python installs.

.PARAMETER Port
Port to serve on. Defaults to 8000.

.PARAMETER Open
If supplied, opens the default browser to the served URL after starting the server.
#>

param(
    [int]$Port = 8000,
    [switch]$Open
)

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$siteDir = Join-Path $repoRoot 'site'

if (-not (Test-Path $siteDir)) {
    Write-Error "Cannot find the 'site' folder at $siteDir. Run this script from the repo root."
    exit 1
}

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    $python = Get-Command py -ErrorAction SilentlyContinue
}

if (-not $python) {
    Write-Error "Python was not found in PATH. Install Python 3 and try again."
    exit 1
}

Write-Host "Serving frontend from: $siteDir"
Write-Host "Listening on: http://localhost:$Port"

Push-Location $siteDir
try {
    if ($Open) {
        Start-Process "http://localhost:$Port"
    }
    & $python.Source -m http.server $Port
}
finally {
    Pop-Location
}
