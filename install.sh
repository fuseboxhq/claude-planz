#!/bin/bash
set -e

# claude-planz installer
# Usage: curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash

REPO_URL="${CLAUDE_PLANZ_REPO:-https://raw.githubusercontent.com/fuseboxhq/claude-planz/main}"
SKILLS_DIR="$HOME/.claude/skills/claude-planz"
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
mkdir -p "$AGENTS_DIR"

# Download skill files
echo "Downloading skills..."
curl -fsSL "$REPO_URL/skills/claude-planz/SKILL.md" -o "$SKILLS_DIR/SKILL.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-init.md" -o "$SKILLS_DIR/cp-init.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-new-phase.md" -o "$SKILLS_DIR/cp-new-phase.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-plan.md" -o "$SKILLS_DIR/cp-plan.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-status.md" -o "$SKILLS_DIR/cp-status.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-research.md" -o "$SKILLS_DIR/cp-research.md"
curl -fsSL "$REPO_URL/skills/claude-planz/cp-close-phase.md" -o "$SKILLS_DIR/cp-close-phase.md"

# Download agent
echo "Downloading agent..."
curl -fsSL "$REPO_URL/agents/cp-researcher.md" -o "$AGENTS_DIR/cp-researcher.md"

echo ""
echo "claude-planz installed successfully!"
echo ""
echo "Installed to:"
echo "  $SKILLS_DIR/"
echo "  $AGENTS_DIR/cp-researcher.md"
echo ""
echo "Available commands:"
echo "  /cp:init                  Initialize Beads + claude-planz in a project"
echo "  /cp:new-phase <title>     Create a new phase"
echo "  /cp:plan PHASE-XX         Research and plan a phase"
echo "  /cp:status                Show phase progress and ready tasks"
echo "  /cp:research <task-id>    Deep research on a specific task"
echo "  /cp:close-phase PHASE-XX  Mark a phase complete"
echo ""
echo "To get started in a new project:"
echo "  1. cd your-project"
echo "  2. Open Claude Code"
echo "  3. Run /cp:init"
