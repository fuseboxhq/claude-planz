---
name: cp:plan
description: Plan all tasks in a Beads phase by researching approaches and creating implementation strategy
argument-hint: <phase-id>
allowed-tools:
  - Bash
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
---

# Plan Phase: $ARGUMENTS

Create a comprehensive implementation plan for all tasks in a Beads phase/epic.

## Steps

### 1. Get Phase Details

Run `bd show $ARGUMENTS` to get the phase/epic title and description.

If the phase doesn't exist, inform the user and exit.

### 2. List Phase Tasks

Run `bd list` and filter for tasks that are children of $ARGUMENTS (tasks with IDs like `$ARGUMENTS.1`, `$ARGUMENTS.2`, etc.).

If no child tasks exist, inform the user:
```
No tasks found under phase $ARGUMENTS.
Create tasks first: bd create "Task description" --parent $ARGUMENTS
```

### 3. Analyze Each Task

For each task in the phase:
1. Run `bd show <task-id>` to get full details
2. Check if research already exists in `.beads/research/<task-id>.md`
3. Identify the key implementation challenge
4. Note any dependencies on other tasks

### 4. Quick Research

For tasks without existing research, perform a quick web search (1-2 queries per task) to understand:
- Standard implementation approach
- Common libraries or tools used
- Estimated complexity

### 5. Determine Execution Order

Analyze task dependencies and determine the optimal order:
- Tasks with no dependencies come first
- Tasks that other tasks depend on come before dependents
- Independent tasks can be marked for parallel execution

### 6. Create Phase Plan

Write the plan to `.beads/plans/$ARGUMENTS.md`:

```markdown
# Phase Plan: [Phase Title]

**Phase ID:** $ARGUMENTS
**Date:** [YYYY-MM-DD]
**Tasks:** [N total]

## Overview

[2-3 sentences describing what this phase accomplishes and its role in the larger project]

## Prerequisites

- [Any setup, dependencies, or prior work needed before starting]

## Task Breakdown

### $ARGUMENTS.1 - [Task Title]

**Objective:** [What this task accomplishes]
**Approach:** [How to implement - specific technologies, patterns]
**Dependencies:** [Other task IDs this depends on, or "None"]
**Complexity:** [Low / Medium / High]
**Estimated effort:** [Quick / Standard / Extended]

**Key steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Verification:** [How to confirm this task is complete]

---

[Repeat for each task]

## Execution Order

Recommended sequence for implementing tasks:

1. **$ARGUMENTS.1** - [Brief reason, e.g., "Foundation for other tasks"]
2. **$ARGUMENTS.2** - [Brief reason]
3. **$ARGUMENTS.3** - [Can run parallel with 2]

## Technical Decisions

Decisions to make before or during implementation:

| Decision | Options | Recommendation | Rationale |
|----------|---------|----------------|-----------|
| [Decision 1] | A, B, C | B | [Why] |
| [Decision 2] | X, Y | X | [Why] |

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | Medium | High | [How to handle] |
| [Risk 2] | Low | Medium | [How to handle] |

## Success Criteria

Phase is complete when:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Related Research

- [.beads/research/task-id.md](link) - [Brief description]
```

### 7. Mark First Task Ready

Identify the first task with no blockers and note it as ready to start.

### 8. Report to User

Present a summary:
- Phase overview
- Number of tasks and estimated complexity
- Recommended starting point
- Any critical decisions needed before starting
- Link to the full plan document
