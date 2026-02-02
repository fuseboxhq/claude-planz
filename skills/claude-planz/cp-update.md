---
name: cp:update
description: Update claude-planz to the latest version
allowed-tools:
  - Bash
  - Read
  - WebFetch
---

# Update claude-planz

Update claude-planz to the latest version from GitHub.

## Steps

### 1. Check Current Version

Check if a version file exists:
```bash
cat ~/.claude/commands/claude-planz/.version 2>/dev/null || echo "unknown"
```

### 2. Fetch Latest Version Info

Fetch the latest commit info from GitHub:
```bash
curl -fsSL https://api.github.com/repos/fuseboxhq/claude-planz/commits/main 2>/dev/null | head -20
```

Or use WebFetch to get the README for changelog info.

### 3. Show What's New

If possible, show recent changes:
- Fetch latest commit messages
- Show brief summary of updates

### 4. Run Update

Execute the install script to update all files:
```bash
curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash
```

### 5. Save Version Info

Save the current commit SHA for future comparisons:
```bash
COMMIT=$(curl -fsSL https://api.github.com/repos/fuseboxhq/claude-planz/commits/main 2>/dev/null | grep '"sha"' | head -1 | cut -d'"' -f4)
echo "$COMMIT" > ~/.claude/commands/claude-planz/.version
```

### 6. Report Success

```markdown
## UPDATE COMPLETE

claude-planz has been updated to the latest version.

### Files Updated
- ~/.claude/skills/claude-planz/SKILL.md
- ~/.claude/commands/claude-planz/cp-*.md
- ~/.claude/agents/cp-researcher.md

### What's New
[Summary of recent changes if available]

You may need to restart Claude Code for changes to take full effect.
```

## Quick Update (One-liner)

For users who just want to update without details:
```bash
curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash
```
