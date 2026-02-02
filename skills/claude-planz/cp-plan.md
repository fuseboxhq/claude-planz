---
name: cp:plan
description: Research a phase, break it into tasks, and populate PHASE-XX.md with findings
argument-hint: <PHASE-XX>
allowed-tools:
  - Bash
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Edit
  - Glob
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
---

# Plan Phase: $ARGUMENTS

Research implementation approaches for a phase and break it down into executable tasks.

## Philosophy

**Your training is stale.** Verify before asserting. Use Context7 and official docs.

**Be prescriptive.** "Use X because..." not "consider X or Y..."

## Steps

### 1. Validate Phase Exists

Check that `.planning/$ARGUMENTS.md` exists.

If not found:
```
Phase $ARGUMENTS not found.
Create it first: /cp:new-phase [title]
```

### 2. Read Phase Context

Read `.planning/$ARGUMENTS.md` to get:
- Phase title
- Beads Epic ID
- Current status
- Any existing content

If status is `complete`, warn user and confirm they want to re-plan.

### 3. Research Phase Implementation

**Identify research domains:**
- What technologies/libraries are needed?
- What patterns do experts use?
- What are common pitfalls?
- What shouldn't be hand-rolled?

**Context7 First (for libraries):**
```
1. mcp__context7__resolve-library-id
   libraryName: "[library name]"

2. mcp__context7__query-docs
   libraryId: [resolved ID]
   query: "[specific question]"
```

**WebSearch for ecosystem questions:**
- Include current year
- Cross-verify findings
- Assign confidence levels (HIGH/MEDIUM/LOW)

### 4. Define Tasks

Break the phase into 3-7 tasks. Each task should be:
- Completable in one focused session
- Have clear done criteria
- Be independently verifiable

For each task:
- Title (action-oriented)
- What it accomplishes
- Complexity (Low/Medium/High)
- Dependencies on other tasks

### 5. Create Beads Tasks

For each task, create in Beads under the phase epic:
```bash
bd create "[Task title]" --parent [epic-id]
```

If tasks have dependencies:
```bash
bd dep add [dependent-task] [dependency-task]
```

### 6. Update Phase File

Update `.planning/$ARGUMENTS.md` with full content:

```markdown
# Phase XX: [Title]

**Status:** in_progress
**Beads Epic:** [epic-id]
**Created:** [date]

## Objective

[2-3 sentences on what this phase accomplishes and why it matters]

## Research Summary

**Overall Confidence:** [HIGH/MEDIUM/LOW]

[TL;DR - 2-3 sentences on the recommended approach]

### Recommended Stack

| Library | Version | Purpose | Confidence |
|---------|---------|---------|------------|
| [name] | [ver] | [why] | [H/M/L] |

### Key Patterns

[Brief description of important patterns to follow]

### Don't Hand-Roll

| Problem | Use Instead | Why |
|---------|-------------|-----|
| [X] | [Y] | [edge cases] |

### Pitfalls

- **[Pitfall]**: [How to avoid]

## Tasks

| ID | Title | Status | Complexity | Dependencies |
|----|-------|--------|------------|--------------|
| [id] | [title] | open | [L/M/H] | [deps or -] |

## Technical Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| [What] | [Option] | [Why] |

## Completion Criteria

- [ ] [Observable criterion 1]
- [ ] [Observable criterion 2]
- [ ] [Observable criterion 3]

## Sources

**HIGH confidence:**
- [source]

**MEDIUM confidence:**
- [source]
```

### 7. Update STATE.md

Update `.planning/STATE.md`:
```markdown
**Current Phase:** $ARGUMENTS
**Last Updated:** [date]

## Active Work

$ARGUMENTS: [title] (in_progress) - [N] tasks
```

### 8. Report Summary

```markdown
## PHASE PLANNED

**Phase:** $ARGUMENTS - [title]
**Confidence:** [level]
**Tasks:** [N]

### Approach
[1-2 sentence summary]

### Tasks Created
1. [id]: [title] ([complexity])
2. [id]: [title] ([complexity])
...

### Key Decisions
- [decision 1]
- [decision 2]

### Watch Out For
- [main pitfall]

### Next Steps
1. Start with: [first task id] - [title]
2. Run: bd show [task-id] for details
3. Deep research if needed: /cp:research [task-id]
```
