---
name: cp:init
description: Initialize Beads CLI and claude-planz directories for phase-based planning
allowed-tools:
  - Bash
  - Write
  - Read
---

# Initialize claude-planz

Set up Beads CLI and the `.planning/` directory structure for this project.

## Steps

### 1. Check Beads CLI Installation

Run `which bd` to check if Beads CLI is installed.

If not installed, inform the user:
```
Beads CLI not found. Install with:
  curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
```

### 2. Initialize Beads

If Beads is installed and `.beads/` doesn't exist, run:
```bash
bd init
```

### 3. Create Planning Directory Structure

```bash
mkdir -p .planning/research
```

### 4. Create STATE.md

If `.planning/STATE.md` doesn't exist, create it:

```markdown
# Project State

**Current Phase:** None
**Last Updated:** [date]

## Active Work

No phases created yet. Run `/cp:new-phase [title]` to create your first phase.

## Quick Commands

- Create phase: `/cp:new-phase [title]`
- Plan phase: `/cp:plan PHASE-XX`
- Check status: `/cp:status`
- Research task: `/cp:research <task-id>`
```

### 5. Create .gitignore

If `.planning/.gitignore` doesn't exist:
```
# Keep research but ignore temp files
*.tmp
*.bak
```

### 6. Report Success

```
claude-planz initialized!

Created:
  .beads/              - Beads task database
  .planning/           - Phase planning documents
  .planning/research/  - Task research documents
  .planning/STATE.md   - Project state tracking

Next steps:
  1. Create your first phase: /cp:new-phase "Setup and Configuration"
  2. Plan the phase: /cp:plan PHASE-01
  3. Check status: /cp:status
```
