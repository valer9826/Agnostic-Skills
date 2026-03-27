# Project Routing

Copy this file to the **repository root** as `AGENTS.md` and replace placeholders.

## Placeholders

| Token | Meaning | Example |
|-------|---------|---------|
| `{{SKILLS_ROOT}}` | Directory containing skill folders | `skills` (this catalog) or `.agents/skills` |
| `{{WORKFLOWS_ROOT}}` | Optional workflow markdown directory | `.agents/workflows` or leave unused |

## Source Of Truth

- **Skills:** `{{SKILLS_ROOT}}/*/SKILL.md`
- **Workflows (if used):** `{{WORKFLOWS_ROOT}}/*.md`
- **Skill catalog table:** `{{SKILLS_ROOT}}/skills-index/references/skills-list.md`

## Loading Policy

- Load only the **minimum** workflows and `SKILL.md` files needed for the current task.
- Do not restate full skill bodies in chat; follow each skill’s own contract.
- Prefer `.agents/**` (or your chosen root) as the single writable source of truth for agent assets unless you explicitly version IDE-only mirrors.

## Global Guardrails

- Stay within the user’s thread scope and explicit request.
- Do not read or modify unrelated systems, secrets, or external resources unless required for the task.
- Add project-specific guardrails below.

---

## Policy (optional)

- **Skill change review skip authors:** _(comma-separated emails, or remove this line)_  
  Example: `maintainer-bot@company.com`

---

## Trigger Routing

_Add one bullet per **class of request** that should load specific skills. Keep bullets short; point to paths, not prose duplicates._

- **Skill governance** (`create skill`, `modify skill`, split/merge skills): load `{{SKILLS_ROOT}}/skill-authoring-governance/SKILL.md` and consult `skills-list.md` for overlap.
- **Agent system evaluation** (architecture of skills/workflows/routing): load `{{SKILLS_ROOT}}/agent-system-technical-evaluation-sanity/SKILL.md`.
- **PR touches skills**: load `{{SKILLS_ROOT}}/spec-driven-skill-change-review/SKILL.md` when reviewing pull requests that change skill paths.
- **AI environment bootstrap** (MCP, IDE agent setup): load `{{SKILLS_ROOT}}/ai-agent-onboarding-bootstrap/SKILL.md`.
- **Design pattern choice** (pain-point-driven): load `{{SKILLS_ROOT}}/design-patterns-decision-tree/SKILL.md`.
- **NotebookLM / `nlm`**: load `{{SKILLS_ROOT}}/nlm-skill/SKILL.md`.

_(Add more lines for your stack: e.g. backend review, infra, security.)_

---

## Available Skills

The authoritative table is `{{SKILLS_ROOT}}/skills-index/references/skills-list.md`.  
For growth and routing rules, see `templates/SKILL_GROWTH_AND_ROUTING.md` in the Agnostic-Skills catalog (or copy it into your docs).

## Scalability

Group skills by **domain** in `skills-list.md` so the router stays small. Revisit domains when a section grows past ~10–15 skills.
