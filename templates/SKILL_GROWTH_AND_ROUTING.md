# Skill growth, indexing, and routing

Use this document when adopting the [Agnostic-Skills](https://github.com/valer9826/Agnostic-Skills) catalog into any repository. It ties together the **skills list**, **authoring governance**, and **AGENTS.md** routing.

## 1. Canonical locations

| Artifact | This catalog repo | Typical integrated monorepo |
|----------|-------------------|------------------------------|
| Skill folders | `skills/<name>/SKILL.md` | `.agents/skills/<name>/SKILL.md` |
| Skills table | `skills/skills-index/references/skills-list.md` | `.agents/skills/skills-index/references/skills-list.md` |
| Workflows (optional) | — | `.agents/workflows/*.md` |
| Router | `AGENTS.md` (from template) | `AGENTS.md` at repo root |

## 2. Adding or changing a skill (growth control)

1. **Governance first:** Run the overlap workflow in `skill-authoring-governance` (read `skills-index` + `skills-list.md` before writing new `SKILL.md`).
2. **Prefer:** consolidate → extend existing skill → create new skill last.
3. **Contract:** New or materially changed skills must include `Trigger`, `Context/Knowledge`, `Dependencies`, and `How/Execution` (see governance skill).
4. **Index is mandatory:** Add or update one row per skill in the correct **domain** section of `skills-list.md` (alphabetical by directory name within the domain).
5. **Router is selective:** Update `AGENTS.md` **Trigger Routing** only when:
   - a new **class of user requests** appears that should load a fixed bundle of skills/workflows, or
   - discoverability would suffer without an explicit pointer.
   Do **not** duplicate full skill text in `AGENTS.md`; link paths and state triggers only.

## 3. Domains (keep the router small)

Use a small, stable set of domains in `skills-list.md`, for example:

- **Governance & System Evaluation**
- **SDLC & Engineering Process**
- **Architecture & Tooling**
- **Integrations & Automation**
- **Domain Modules** (product-specific; keep narrow)

If a domain grows large, split sub-areas inside the table or add a child domain section—avoid a flat list of dozens of top-level router bullets.

## 4. PR review for skills

When your team uses spec-driven agent behavior:

- Load `spec-driven-skill-change-review` for PRs that touch skill paths.
- Configure optional skip authors in `AGENTS.md` (see `templates/AGENTS.template.md`).

## 5. Periodic sanity

Use `agent-system-technical-evaluation-sanity` to review the whole agent layer for duplication, token bloat, and routing drift—especially after many skills land.

## 6. IDE mirrors

If you maintain `.cursor/skills/**` or similar as a mirror of canonical skills, document that in `AGENTS.md` and keep changes in sync; the spec-driven review skill treats mirror drift as a first-class review finding.
