---
name: update
description: Update claude-planz to the latest version
allowed-tools:
  - Bash
  - Read
  - WebFetch
---

# Update claude-planz

Update claude-planz to the latest version from GitHub.

## Steps

### 1. Detect Platform

Determine if running on Windows (PowerShell) or Unix (bash).

Check the environment:
- If `$env:OS` contains "Windows" or `$PSVersionTable` exists → Windows
- Otherwise → Unix/macOS/Linux

### 2. Fetch Latest Version Info

Use WebFetch to get recent commits:
```
WebFetch: https://api.github.com/repos/fuseboxhq/claude-planz/commits?per_page=5
Prompt: Extract the commit messages and dates from the last 5 commits
```

### 3. Show What's New

Display recent changes to the user before updating.

### 4. Run Update

**For Unix/macOS/Linux/WSL:**
```bash
curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash
```

**For Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/update.ps1 | iex
```

Note: On Windows, use the Bash tool but execute PowerShell commands:
```bash
powershell -Command "irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/update.ps1 | iex"
```

### 5. Report Success

```markdown
## UPDATE COMPLETE

claude-planz has been updated to the latest version.

### Files Updated
- ~/.claude/skills/claude-planz/SKILL.md
- ~/.claude/commands/cp/*.md
- ~/.claude/agents/cp-researcher.md

### What's New
[Summary of recent changes from step 3]

You may need to restart Claude Code for changes to take full effect.
```

## Quick Update (One-liner)

**macOS/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/update.ps1 | iex
```
