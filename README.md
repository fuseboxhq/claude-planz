# claude-planz

A lightweight research and planning extension for Claude Code that integrates with [Beads CLI](https://github.com/steveyegge/beads) for task tracking.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/fuseboxhq/claude-planz/main/install.sh | bash
```

This installs skills to `~/.claude/skills/claude-planz/` and automatically installs Beads CLI if not present.

## Overview

claude-planz helps you break down projects into phases, research what you need, and track tasks—all within Claude Code.

**Philosophy:** Understand before building. Commands ask clarifying questions before diving into work.

### Directory Structure

```
your-project/
├── .planning/
│   ├── PHASE-01.md          # Phase definition + research + tasks
│   ├── PHASE-02.md
│   ├── research/            # Task-level deep dives
│   │   └── bd-xxxx.md
│   └── STATE.md             # Current project state
└── .beads/
    └── beads.db             # Beads task database
```

### Phase Lifecycle

```
new-phase → plan → execute tasks → close-phase
```

## Commands

| Command | Description |
|---------|-------------|
| `/cp:init` | Initialize Beads + `.planning/` directory |
| `/cp:new-phase <title>` | Create a new phase with Beads epic |
| `/cp:plan PHASE-XX` | Clarify requirements, research, create tasks |
| `/cp:discuss-task <task-id>` | Clarify a task through interactive discussion |
| `/cp:research <task-id>` | Deep research on a specific task |
| `/cp:status` | Show all phases and ready tasks |
| `/cp:close-phase PHASE-XX` | Mark a phase complete |

## Quick Start

1. Open your project in Claude Code
2. Run `/cp:init` to initialize
3. Run `/cp:new-phase "Your First Phase"` to create a phase
4. Run `/cp:plan PHASE-01` to research and create tasks
5. Work through tasks using `bd ready` and `bd update <id> --status done`
6. Run `/cp:close-phase PHASE-01` when complete

## Beads CLI Quick Reference

```bash
bd ready                         # List tasks with no blockers
bd show <id>                     # View task details
bd list                          # List all tasks
bd update <id> --status done     # Mark complete
```

## License

MIT
