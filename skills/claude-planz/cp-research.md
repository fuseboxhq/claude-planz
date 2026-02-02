---
name: cp:research
description: Research a Beads task by searching web for best practices, patterns, and implementations
argument-hint: <task-id>
allowed-tools:
  - Bash
  - WebSearch
  - WebFetch
  - Read
  - Write
---

# Research Task: $ARGUMENTS

Research best practices, patterns, and implementation approaches for a specific Beads task.

## Steps

### 1. Get Task Details

Run `bd show $ARGUMENTS` to retrieve the task title, description, priority, and any existing notes.

If the task doesn't exist, inform the user and exit.

### 2. Extract Research Topics

From the task title and description, identify:
- The core technology or concept involved
- Specific implementation challenges mentioned
- Any constraints or requirements noted

### 3. Web Research

Using WebSearch, perform 3-5 searches based on the task. Example queries:
- "[technology] best practices 2025"
- "[task concept] implementation patterns"
- "[specific challenge] solutions"
- "[framework] [feature] example"

For each search, review the top results and identify the most relevant sources.

### 4. Deep Dive

For the 2-3 most promising results, use WebFetch to get detailed information:
- Official documentation
- Well-regarded tutorials
- Stack Overflow discussions with accepted answers
- GitHub repositories with good examples

### 5. Synthesize Findings

Analyze the research and identify:
- Common patterns and best practices
- Potential pitfalls to avoid
- Recommended libraries or tools
- Implementation approach that fits the task

### 6. Document Research

Write findings to `.beads/research/$ARGUMENTS.md`:

```markdown
# Research: [Task Title]

**Task ID:** $ARGUMENTS
**Date:** [YYYY-MM-DD]
**Status:** Complete

## Summary

[2-3 sentence overview of what was learned and the recommended approach]

## Best Practices

- **[Practice 1]**: [Brief explanation]
- **[Practice 2]**: [Brief explanation]
- **[Practice 3]**: [Brief explanation]

## Recommended Approach

[Paragraph describing the suggested implementation approach, including specific technologies, patterns, or libraries to use]

## Potential Pitfalls

- [Pitfall 1]: [How to avoid]
- [Pitfall 2]: [How to avoid]

## Key Resources

- [Resource Title](URL): [Why it's useful]
- [Resource Title](URL): [Why it's useful]
- [Resource Title](URL): [Why it's useful]

## Implementation Notes

[Any specific code snippets, configuration examples, or step-by-step guidance]
```

### 7. Update Task

Run `bd update $ARGUMENTS --note "Research completed. See .beads/research/$ARGUMENTS.md"`

### 8. Report to User

Summarize the key findings:
- Main recommendation
- Top 2-3 best practices
- Any critical decisions to make
- Link to the full research document
