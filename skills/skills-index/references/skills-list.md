# Available Skills (Agnostic-Skills catalog)

Skills in this repository are **stack-agnostic**. Integrate into a project by copying or symlinking `skills/` into your agent layout (commonly `.agents/skills/`) and wiring root `AGENTS.md` using `templates/AGENTS.template.md`.

## Governance & System Evaluation

| Skill Directory Name | Description | Related / Dependencies |
|----------------------|-------------|------------------------|
| `agent-system-technical-evaluation-sanity` | Non-mutating technical evaluation of the AI agent system (skills, workflows, routing, token efficiency, scalability). | `skill-authoring-governance`, `spec-driven-skill-change-review` |
| `ai-agent-onboarding-bootstrap` | Bootstrap AI assistant environments (MCP catalog, compatibility layers, preflight checks); no vendor-specific URLs in the skill body. | - |
| `skill-authoring-governance` | Governs creating or materially changing skills: overlap analysis, English-only, canonical contract. | `skills-index` |
| `skills-index` | Central index of skills; overlap analysis via `skills-list.md`. | - |
| `spec-driven-skill-change-review` | PR audit for skill changes; optional author skip list via `AGENTS.md`. | `skill-authoring-governance` |

## SDLC & Engineering Process

| Skill Directory Name | Description | Related / Dependencies |
|----------------------|-------------|------------------------|
| `design-patterns-decision-tree` | Choose design patterns from concrete code “pain points” using a structured tree. | - |

## Integrations & Automation

| Skill Directory Name | Description | Related / Dependencies |
|----------------------|-------------|------------------------|
| `nlm-skill` | NotebookLM CLI and MCP: notebooks, sources, Studio artifacts, research; see `references/`. | - |
