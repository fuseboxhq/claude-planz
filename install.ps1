# claude-planz installer for Windows
# Usage: irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.ps1 | iex

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

Write-Host "Installing claude-planz..." -ForegroundColor White
Write-Host ""

# Check for Beads CLI
$beadsFound = $false
try {
    $bdPath = (Get-Command bd -ErrorAction SilentlyContinue).Source
    if ($bdPath) {
        Write-Status "Beads CLI found: $bdPath" "OK"
        $beadsFound = $true
    }
} catch {}

if (-not $beadsFound) {
    Write-Status "Beads CLI not found. Attempting to install..." "INFO"

    # Try npm first
    $npmInstalled = $false
    try {
        $npmPath = (Get-Command npm -ErrorAction SilentlyContinue).Source
        if ($npmPath) {
            Write-Status "Found npm, installing Beads via npm..." "INFO"
            npm install -g @anthropics/beads 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Status "Beads CLI installed via npm" "OK"
                $npmInstalled = $true
            }
        }
    } catch {}

    # Try go if npm failed
    if (-not $npmInstalled) {
        try {
            $goPath = (Get-Command go -ErrorAction SilentlyContinue).Source
            if ($goPath) {
                Write-Status "Found go, installing Beads via go..." "INFO"
                go install github.com/steveyegge/beads/cmd/bd@latest 2>$null
                if ($LASTEXITCODE -eq 0) {
                    Write-Status "Beads CLI installed via go" "OK"
                }
            }
        } catch {}
    }

    # Check if installation succeeded
    try {
        $bdPath = (Get-Command bd -ErrorAction SilentlyContinue).Source
        if ($bdPath) {
            Write-Status "Beads CLI now available: $bdPath" "OK"
        } else {
            Write-Status "Beads CLI not installed. Install manually with: npm install -g @anthropics/beads" "WARN"
            Write-Status "claude-planz will work without Beads, but task tracking won't be available." "WARN"
        }
    } catch {
        Write-Status "Beads CLI not installed. Install manually with: npm install -g @anthropics/beads" "WARN"
        Write-Status "claude-planz will work without Beads, but task tracking won't be available." "WARN"
    }
}

# Create directories
Write-Host "Creating directories..." -ForegroundColor White
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
New-Item -ItemType Directory -Force -Path $CommandsDir | Out-Null
New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null

# Download skill file
Write-Host "Downloading skill..." -ForegroundColor White
Download-File "$RepoUrl/skills/claude-planz/SKILL.md" (Join-Path $SkillsDir "SKILL.md")

# Download command files
Write-Host "Downloading commands..." -ForegroundColor White
$commands = @(
    "init", "integrate", "new-phase", "plan", "discuss-task",
    "status", "research", "close-phase", "execute",
    "todo", "todos", "update", "quick"
)
foreach ($cmd in $commands) {
    Download-File "$RepoUrl/commands/cp/$cmd.md" (Join-Path $CommandsDir "$cmd.md")
}

# Download agent
Write-Host "Downloading agent..." -ForegroundColor White
Download-File "$RepoUrl/agents/cp-researcher.md" (Join-Path $AgentsDir "cp-researcher.md")

Write-Host ""
Write-Host "claude-planz installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Installed to:" -ForegroundColor White
Write-Host "  $SkillsDir\SKILL.md (background context)"
Write-Host "  $CommandsDir\ (commands)"
Write-Host "  $AgentsDir\cp-researcher.md (agent)"
Write-Host ""
Write-Host "Available commands:" -ForegroundColor White
Write-Host "  /cp:init                   Initialize Beads + claude-planz in a project"
Write-Host "  /cp:integrate              Explore codebase and create CODEBASE.md"
Write-Host "  /cp:new-phase <title>      Create a new phase"
Write-Host "  /cp:plan PHASE-XX          Clarify, research, and plan a phase"
Write-Host "  /cp:execute <id|PHASE-XX>  Execute a task or all tasks in a phase"
Write-Host "  /cp:discuss-task <task-id> Clarify a task through discussion"
Write-Host "  /cp:research <task-id>     Deep research on a specific task"
Write-Host "  /cp:status                 Show phase progress and ready tasks"
Write-Host "  /cp:close-phase PHASE-XX   Mark a phase complete"
Write-Host "  /cp:todo <description>     Add item to todo list"
Write-Host "  /cp:todos                  View and manage todo list"
Write-Host "  /cp:update                 Update claude-planz to latest version"
Write-Host "  /cp:quick <description>   Quick task execution without planning"
Write-Host ""
Write-Host "To get started in a new project:" -ForegroundColor White
Write-Host "  1. cd your-project"
Write-Host "  2. Open Claude Code"
Write-Host "  3. Run /cp:init"
