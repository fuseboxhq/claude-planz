---
name: cp:init
description: Initialize Beads CLI and claude-planz directories in the current project
allowed-tools:
  - Bash
  - Write
  - Read
---

# Initialize claude-planz

Set up Beads CLI and claude-planz directories for this project.

## Steps

### 1. Check Beads CLI Installation

Run `which bd` to check if Beads CLI is installed.

If not installed, inform the user:
```
Beads CLI not found. Install with one of:
  brew install steveyegge/beads/bd
  npm install -g @beads/bd
  go install github.com/steveyegge/beads/cmd/bd@latest
```

### 2. Initialize Beads

If Beads is installed, run:
```bash
bd init
```

This creates the `.beads/` directory with the SQLite database.

### 3. Create claude-planz Directories

Create the research and plans directories:
```bash
mkdir -p .beads/research .beads/plans
```

### 4. Create .gitignore (Optional)

If `.beads/.gitignore` doesn't exist, create it:
```
# Beads database (regenerated from issues.jsonl)
beads.db
beads.db-shm
beads.db-wal
```

### 5. Report Success

Display:
```
claude-planz initialized!

Created:
  .beads/           - Beads database directory
  .beads/research/  - Task research documents
  .beads/plans/     - Phase planning documents

Next steps:
  1. Create an epic/phase: bd create "Phase 1: Setup" -p 0
  2. Add tasks: bd create "Task description" --parent bd-xxxx
  3. Research a task: /cp:research bd-xxxx
  4. Plan a phase: /cp:plan bd-xxxx
  5. Check status: /cp:status
```
