# claude-planz updater for Windows
# Usage: irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/update.ps1 | iex
# This script is called by /cp:update on Windows

$ErrorActionPreference = "Stop"

# Ensure TLS 1.2 for older systems
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$RepoUrl = if ($env:CLAUDE_PLANZ_REPO) { $env:CLAUDE_PLANZ_REPO } else { "https://raw.githubusercontent.com/fuseboxhq/claude-planz/main" }
$SkillsDir = Join-Path $env:USERPROFILE ".claude\skills\claude-planz"
$CommandsDir = Join-Path $env:USERPROFILE ".claude\commands\cp"
$AgentsDir = Join-Path $env:USERPROFILE ".claude\agents"

function Write-Status {
    param([string]$Message, [string]$Type = "INFO")
    switch ($Type) {
        "OK"    { Write-Host "[OK] $Message" -ForegroundColor Green }
        "WARN"  { Write-Host "[WARN] $Message" -ForegroundColor Yellow }
        "ERROR" { Write-Host "[ERROR] $Message" -ForegroundColor Red }
        default { Write-Host "[INFO] $Message" -ForegroundColor Cyan }
    }
}

function Download-File {
    param([string]$Url, [string]$OutFile)
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
    } catch {
        throw "Failed to download $Url : $_"
    }
}

Write-Host "Updating claude-planz..." -ForegroundColor White
Write-Host ""

# Ensure directories exist
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
New-Item -ItemType Directory -Force -Path $CommandsDir | Out-Null
New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null

# Download skill file
Write-Host "Updating skill..." -ForegroundColor White
Download-File "$RepoUrl/skills/claude-planz/SKILL.md" (Join-Path $SkillsDir "SKILL.md")

# Download command files
Write-Host "Updating commands..." -ForegroundColor White
$commands = @(
    "init", "integrate", "new-phase", "plan", "discuss-task",
    "status", "research", "close-phase", "execute",
    "todo", "todos", "update"
)
foreach ($cmd in $commands) {
    Download-File "$RepoUrl/commands/cp/$cmd.md" (Join-Path $CommandsDir "$cmd.md")
}

# Download agent
Write-Host "Updating agent..." -ForegroundColor White
Download-File "$RepoUrl/agents/cp-researcher.md" (Join-Path $AgentsDir "cp-researcher.md")

Write-Host ""
Write-Host "claude-planz updated successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Updated files:" -ForegroundColor White
Write-Host "  $SkillsDir\SKILL.md"
Write-Host "  $CommandsDir\ (all commands)"
Write-Host "  $AgentsDir\cp-researcher.md"
Write-Host ""
Write-Host "You may need to restart Claude Code for changes to take full effect." -ForegroundColor Yellow
