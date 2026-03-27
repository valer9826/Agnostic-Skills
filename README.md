# Agnostic-Skills

Portable **AI agent skills** (and templates) that are **not tied to Android** or any single framework. Use them as a starter pack or submodule, then add your stack-specific skills in your own repository.

## Contents

| Path | Purpose |
|------|---------|
| `skills/` | Skill packages (`SKILL.md` + optional `references/`). |
| `skills/skills-index/references/skills-list.md` | Catalog table for this pack. |
| `templates/AGENTS.template.md` | Root router template: copy → `AGENTS.md` and replace `{{SKILLS_ROOT}}`. |
| `templates/skills-list.template.md` | Empty domain tables for new projects. |
| `templates/SKILL_GROWTH_AND_ROUTING.md` | How to index skills, control growth, and wire routing. |

## Included skills

- **Governance & sanity:** `agent-system-technical-evaluation-sanity`, `skill-authoring-governance`, `spec-driven-skill-change-review`, `skills-index`, `ai-agent-onboarding-bootstrap`
- **Engineering:** `design-patterns-decision-tree`
- **Automation:** `nlm-skill` (NotebookLM CLI / MCP)

Confluence-specific skills are intentionally **not** included.

## Use in another repository

1. Copy or symlink `skills/` into your tree, e.g. `.agents/skills/`.
2. Copy `templates/AGENTS.template.md` to **`AGENTS.md`** at the repo root.
3. Set `{{SKILLS_ROOT}}` to your path (e.g. `.agents/skills`).
4. Merge rows from this pack’s `skills-list.md` into your catalog (or start from `skills-list.template.md`).
5. Point your IDE (Cursor, Claude Code, etc.) at root `AGENTS.md` per product docs.
6. Read `templates/SKILL_GROWTH_AND_ROUTING.md` before adding many new skills.

## Metrics

Skills use **optional** local usage metrics. If you do not maintain `metrics/ai_agent_usage.json` (or similar), ignore those paragraphs.

## License

See [LICENSE](LICENSE). Skills derived from internal engineering playbooks retain their original spirit; adapt attribution if you redistribute.

## Origin

Skills were generalized from the Belcorp **Somos Consultoras** Android replatform agent system; org-specific URLs, Confluence paths, and Android-only reviewers were removed or parameterized.
