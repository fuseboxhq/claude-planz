#!/bin/bash
set -e

# claude-planz installer
# Usage: curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash

# Detect WSL and inform Windows users
if grep -qEi "(microsoft|wsl)" /proc/version 2>/dev/null; then
    echo "[INFO] WSL detected. This installer works in WSL."
    echo "       For native Windows (PowerShell), use:"
    echo "       irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.ps1 | iex"
    echo ""
fi

REPO_URL="${CLAUDE_PLANZ_REPO:-https://raw.githubusercontent.com/fuseboxhq/claude-planz/main}"
SKILLS_DIR="$HOME/.claude/skills/claude-planz"
COMMANDS_DIR="$HOME/.claude/commands/cp"
AGENTS_DIR="$HOME/.claude/agents"

echo "Installing claude-planz..."
echo ""

# Check for Beads CLI and install if missing
if command -v bd &> /dev/null; then
    echo "[OK] Beads CLI found: $(which bd)"
else
    echo "[INFO] Beads CLI not found. Installing..."
    curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
    echo ""
    if command -v bd &> /dev/null; then
        echo "[OK] Beads CLI installed: $(which bd)"
    else
        echo "[WARN] Beads CLI installation may require a shell restart."
        echo "       Run 'source ~/.bashrc' or 'source ~/.zshrc' after installation."
    fi
fi

# Create directories
echo "Creating directories..."
mkdir -p "$SKILLS_DIR"
mkdir -p "$COMMANDS_DIR"
mkdir -p "$AGENTS_DIR"

# Download skill file (background context)
echo "Downloading skill..."
curl -fsSL "$REPO_URL/skills/claude-planz/SKILL.md" -o "$SKILLS_DIR/SKILL.md"

# Download command files (user-invocable)
echo "Downloading commands..."
curl -fsSL "$REPO_URL/commands/cp/init.md" -o "$COMMANDS_DIR/init.md"
curl -fsSL "$REPO_URL/commands/cp/integrate.md" -o "$COMMANDS_DIR/integrate.md"
curl -fsSL "$REPO_URL/commands/cp/new-phase.md" -o "$COMMANDS_DIR/new-phase.md"
curl -fsSL "$REPO_URL/commands/cp/plan.md" -o "$COMMANDS_DIR/plan.md"
curl -fsSL "$REPO_URL/commands/cp/discuss-task.md" -o "$COMMANDS_DIR/discuss-task.md"
curl -fsSL "$REPO_URL/commands/cp/status.md" -o "$COMMANDS_DIR/status.md"
curl -fsSL "$REPO_URL/commands/cp/research.md" -o "$COMMANDS_DIR/research.md"
curl -fsSL "$REPO_URL/commands/cp/close-phase.md" -o "$COMMANDS_DIR/close-phase.md"
curl -fsSL "$REPO_URL/commands/cp/execute.md" -o "$COMMANDS_DIR/execute.md"
curl -fsSL "$REPO_URL/commands/cp/todo.md" -o "$COMMANDS_DIR/todo.md"
curl -fsSL "$REPO_URL/commands/cp/todos.md" -o "$COMMANDS_DIR/todos.md"
curl -fsSL "$REPO_URL/commands/cp/update.md" -o "$COMMANDS_DIR/update.md"

# Download agent
echo "Downloading agent..."
curl -fsSL "$REPO_URL/agents/cp-researcher.md" -o "$AGENTS_DIR/cp-researcher.md"

echo ""
echo "claude-planz installed successfully!"
echo ""
echo "Installed to:"
echo "  $SKILLS_DIR/SKILL.md (background context)"
echo "  $COMMANDS_DIR/ (commands)"
echo "  $AGENTS_DIR/cp-researcher.md (agent)"
echo ""
echo "Available commands:"
echo "  /cp:init                   Initialize Beads + claude-planz in a project"
echo "  /cp:integrate              Explore codebase and create CODEBASE.md"
echo "  /cp:new-phase <title>      Create a new phase"
echo "  /cp:plan PHASE-XX          Clarify, research, and plan a phase"
echo "  /cp:execute <id|PHASE-XX>  Execute a task or all tasks in a phase"
echo "  /cp:discuss-task <task-id> Clarify a task through discussion"
echo "  /cp:research <task-id>     Deep research on a specific task"
echo "  /cp:status                 Show phase progress and ready tasks"
echo "  /cp:close-phase PHASE-XX   Mark a phase complete"
echo "  /cp:todo <description>     Add item to todo list"
echo "  /cp:todos                  View and manage todo list"
echo "  /cp:update                 Update claude-planz to latest version"
echo ""
echo "To get started in a new project:"
echo "  1. cd your-project"
echo "  2. Open Claude Code"
echo "  3. Run /cp:init"
