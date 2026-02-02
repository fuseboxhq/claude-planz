---
name: cp:research
description: Research a Beads task with verified findings, confidence levels, and prescriptive recommendations
argument-hint: <task-id>
allowed-tools:
  - Bash
  - WebSearch
  - WebFetch
  - Read
  - Write
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
---

# Research Task: $ARGUMENTS

Research how to implement a Beads task well. Produce verified findings with actionable recommendations.

## Philosophy

**Your training is stale.** Your knowledge is 6-18 months old. Treat it as hypothesis, not fact.

- Verify before asserting — don't state library capabilities without checking
- Prefer current sources — Context7 and official docs trump your training
- Flag uncertainty — LOW confidence when only your memory supports a claim
- "I couldn't find X" is valuable — it's honest, not failure

**Be prescriptive, not exploratory.** Research that says "consider X or Y" is useless. Research that says "use X because..." is actionable.

## Steps

### 1. Get Task Context

Run `bd show $ARGUMENTS` to get the task title, description, and any existing notes.

If the task doesn't exist, inform the user and exit.

### 2. Identify Research Domains

What needs investigating?
- **Stack:** What libraries/tools?
- **Patterns:** How do experts structure this?
- **Pitfalls:** What do people get wrong?
- **Existing solutions:** What shouldn't be hand-rolled?

### 3. Research with Verification

**Context7 First (for libraries):**
```
1. mcp__context7__resolve-library-id
   libraryName: "[library name]"

2. mcp__context7__query-docs
   libraryId: [resolved ID]
   query: "[specific question]"
```

**Official Docs (when Context7 doesn't have it):**
- Use WebFetch on exact documentation URLs
- Check publication dates
- Prefer /docs/ over marketing pages

**WebSearch (for ecosystem discovery):**
- Include current year for freshness
- Use multiple query variations
- Cross-verify findings

**Verification Protocol:**
```
├─ Can verify with Context7? → HIGH confidence
├─ Can verify with official docs? → MEDIUM confidence
├─ Multiple sources agree? → Upgrade one level
└─ Single unverified source? → LOW confidence, flag it
```

### 4. Write Research Document

Create `.beads/research/$ARGUMENTS.md`:

```markdown
# Research: [Task Title]

**Task ID:** $ARGUMENTS
**Date:** [YYYY-MM-DD]
**Domain:** [primary technology area]
**Overall Confidence:** [HIGH/MEDIUM/LOW]

## TL;DR

[2-3 sentences. What's the answer? What should we use? What's the approach?]

## Recommended Stack

| Library | Version | Purpose | Confidence |
|---------|---------|---------|------------|
| [name] | [ver] | [why] | [H/M/L] |

**Install:**
```bash
[install command]
```

## Key Patterns

### [Pattern Name]
**Use when:** [condition]
```[language]
// Source: [where this came from]
[minimal example]
```

## Don't Hand-Roll

| Problem | Use Instead | Why |
|---------|-------------|-----|
| [thing that looks simple] | [existing solution] | [edge cases you'd miss] |

## Pitfalls

### [Pitfall Name]
**What happens:** [description]
**Avoid by:** [prevention]

## Open Questions

[Things that couldn't be resolved — be honest]

## Sources

**HIGH confidence:**
- [Context7 library ID or official docs URL]

**MEDIUM confidence:**
- [Verified WebSearch findings]

**LOW confidence (needs validation):**
- [Unverified findings]
```

### 5. Update Beads Task

Run `bd update $ARGUMENTS --note "Research complete: .beads/research/$ARGUMENTS.md"`

### 6. Return Summary

```markdown
## RESEARCH COMPLETE

**Task:** $ARGUMENTS - [title]
**Confidence:** [level]

### Recommendation
[1-2 sentence prescription]

### Key Findings
- [finding 1]
- [finding 2]
- [finding 3]

### Watch Out For
- [main pitfall]

### File
`.beads/research/$ARGUMENTS.md`
```

## Quality Checklist

Before finishing, verify:
- [ ] Recommendations are prescriptive ("use X") not exploratory ("consider X or Y")
- [ ] All library recommendations verified with Context7 or official docs
- [ ] Confidence levels are honest
- [ ] Pitfalls section exists (there are always pitfalls)
- [ ] "Don't hand-roll" section considered
- [ ] Open questions acknowledged (not hidden)
- [ ] Sources cited with confidence levels

## Good vs Bad Output

**Good:**
```markdown
## TL;DR
Use Bull for the job queue with Redis. It handles retries, rate limiting, and dead letter queues out of the box. Don't hand-roll retry logic.
```

**Bad:**
```markdown
## TL;DR
There are several options for job queues. You could use Bull, Bee-Queue, or Agenda. Each has tradeoffs. Consider your requirements carefully.
```

Pick one. Justify it. Move on.
