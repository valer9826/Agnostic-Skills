---
name: skills-index
description: Central directory and index of all repository skills. Use this to find existing capabilities before trying to create new ones or when a user asks about available skills.
---

# Skills Index

Use this skill whenever the user asks about the available skills in the project, wants to know if a skill exists for a specific task, or when `skill-authoring-governance` needs to evaluate existing skills.

## Trigger
- The user asks "what skills exist" or "do we have a skill for [X]?"
- A user wants to search for a specific capability in the repository's AI agents.
- `skill-authoring-governance` needs to perform an overlap analysis against existing skills.
- A new skill is created, requiring this index to be updated.

## Context/Knowledge
This skill maintains the centralized catalog for skills in this repository.

### Available Skills
The full list of available skills and their descriptions lives in:
`skills/skills-index/references/skills-list.md`

**Remap:** In projects that store skills under `.agents/skills/`, read `.agents/skills/skills-index/references/skills-list.md` instead.

## How/Execution
1. **Query**: If the user is asking about existing skills, read the skills list file above and summarize succinctly.
2. **Analysis for `skill-authoring-governance`**: Cross-reference the user's intent with the descriptions in `skills-list.md`. Provide the closest matches so governance can read specific `SKILL.md` files if necessary.
3. **Update Index**: If a new skill was successfully created, add a new row to the appropriate domain table in `skills-list.md` (skill directory name, description, related skills). Keep rows alphabetically ordered by directory name within each domain.

## AI usage metrics (optional)
If the repository maintains a per-skill usage file, increment this skill's counter for the requesting developer after completing the workflow. Otherwise skip.
