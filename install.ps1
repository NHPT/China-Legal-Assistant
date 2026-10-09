$ErrorActionPreference = "Stop"

$packageRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$manifestPath = Join-Path $packageRoot "LOCAL_RUNTIME_MANIFEST.json"
$programPath = Join-Path $packageRoot "bin\china-legal-local.exe"
if (-not (Test-Path $manifestPath) -or -not (Test-Path $programPath)) {
  throw "This installer must be run from a complete platform release package."
}
$manifest = Get-Content -Raw $manifestPath | ConvertFrom-Json
if (-not $manifest.version -or -not $manifest.target) {
  throw "LOCAL_RUNTIME_MANIFEST.json is invalid."
}

$sourceSkill = Join-Path $packageRoot "skills\china-legal-assistant"
if (-not (Test-Path (Join-Path $sourceSkill "SKILL.md"))) {
  throw "The release package does not contain china-legal-assistant Skill."
}

$installBase = if ($env:CNLAW_LOCAL_INSTALL_DIR) {
  $env:CNLAW_LOCAL_INSTALL_DIR
} else {
  Join-Path $env:LOCALAPPDATA "ChinaLegalAssistant"
}
$binDirectory = if ($env:CNLAW_LOCAL_BIN_DIR) {
  $env:CNLAW_LOCAL_BIN_DIR
} else {
  Join-Path $env:LOCALAPPDATA "ChinaLegalAssistant\bin"
}
$installTarget = Join-Path $installBase "releases\v$($manifest.version)-$($manifest.target)"
$temporaryTarget = "$installTarget.tmp.$PID"

Remove-Item -Recurse -Force $temporaryTarget -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $temporaryTarget | Out-Null
Copy-Item (Join-Path $packageRoot "*") $temporaryTarget -Recurse -Force
Remove-Item -Recurse -Force $installTarget -ErrorAction SilentlyContinue
Move-Item $temporaryTarget $installTarget

New-Item -ItemType Directory -Force $binDirectory | Out-Null
$launcher = Join-Path $binDirectory "china-legal-local.cmd"
$executable = Join-Path $installTarget "bin\china-legal-local.exe"
Set-Content -Encoding Ascii $launcher "@echo off`r`n`"$executable`" %*`r`n"

$userHome = $env:USERPROFILE
foreach ($client in @(".trae", ".codex", ".claude", ".opencode")) {
  $clientRoot = Join-Path $userHome "$client\skills"
  $destination = Join-Path $clientRoot "china-legal-assistant"
  $skillTemporary = "$destination.tmp.$PID"
  Remove-Item -Recurse -Force $skillTemporary -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force $clientRoot | Out-Null
  Copy-Item $sourceSkill $skillTemporary -Recurse -Force
  Remove-Item -Recurse -Force $destination -ErrorAction SilentlyContinue
  Move-Item $skillTemporary $destination
}

Write-Output "Installed china-legal-local v$($manifest.version)."
Write-Output "Installed china-legal-assistant Skill for four supported clients."
Write-Output "Command: $launcher"
