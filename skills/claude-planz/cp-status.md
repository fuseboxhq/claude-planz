---
name: cp:status
description: Show phase progress, ready tasks, and recent research/plan documents
allowed-tools:
  - Bash
  - Read
  - Glob
---

# Show Project Status

Display the current state of tasks, phases, and claude-planz documents.

## Steps

### 1. Get Ready Tasks

Run `bd ready` to get all tasks with no open blockers. These are the tasks that can be worked on now.

### 2. Get All Tasks

Run `bd list` to get all tasks with their status and parent relationships.

### 3. Group by Phase

Analyze the task list and group tasks by their parent ID (phase/epic). For each phase:
- Count total tasks
- Count completed tasks
- Calculate completion percentage
- List individual tasks with status

### 4. Find Recent Documents

Check for research and plan documents:
```bash
ls -lt .beads/research/*.md 2>/dev/null | head -5
ls -lt .beads/plans/*.md 2>/dev/null | head -5
```

### 5. Display Status

Format the output as:

```markdown
## Phase Progress

### bd-a3f8 - [Phase Title] [2/4 complete]
  - [x] bd-a3f8.1 Task one (done)
  - [x] bd-a3f8.2 Task two (done)
  - [ ] bd-a3f8.3 Task three (READY)
  - [ ] bd-a3f8.4 Task four (blocked by bd-a3f8.3)

### bd-b2c1 - [Phase Title] [0/3 complete]
  - [ ] bd-b2c1.1 First task (READY)
  - [ ] bd-b2c1.2 Second task
  - [ ] bd-b2c1.3 Third task

## Ready Tasks

Tasks with no blockers that can be started now:
- bd-a3f8.3: Task three
- bd-b2c1.1: First task

## Recent Documents

Research:
- .beads/research/bd-a3f8.2.md (2 days ago)
- .beads/research/bd-a3f8.1.md (3 days ago)

Plans:
- .beads/plans/bd-a3f8.md (3 days ago)

## Quick Actions

- Research a task: /cp:research <task-id>
- Plan a phase: /cp:plan <phase-id>
- See task details: bd show <task-id>
- Mark task done: bd update <task-id> --status done
```

If there are no tasks yet, display:
```
No tasks found. Get started:
  1. Create a phase: bd create "Phase 1: Setup" -p 0
  2. Add tasks: bd create "Task description" --parent bd-xxxx
  3. Run /cp:status again to see progress
```
