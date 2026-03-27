---
name: skill-authoring-governance
description: Governs the creation and material modification of repository skills by enforcing overlap analysis, English-only authoring, and a canonical skill contract with Trigger, Context/Knowledge, and How/Execution.
---

# Skill Authoring Governance

Use this skill whenever the request is to create, replace, split, consolidate, or materially modify a repository skill.

## When to Use
- The user asks for a new skill.
- The user asks to rewrite or substantially change an existing `SKILL.md`.
- The user believes a new skill is needed because an existing skill was not triggered or was unclear.
- The task is to standardize how repository skills are authored.

## Context/Knowledge
- This skill governs skills under the repository **agent skills directory** (this catalog: `skills/**`; integrated projects often use `.agents/skills/**`).
- The **primary writable source of truth** for skills is defined in the root `AGENTS.md` (or equivalent). Do not treat IDE mirrors as authoritative unless the project explicitly says so.
- Existing skill overlap must be evaluated before a new skill is proposed.
- New or modified skill-authoring content governed by this skill must be written in English.
- The preferred repository strategy is consolidation first, extension second, and new skill creation last.
- For index, routing, and growth rules, follow `templates/SKILL_GROWTH_AND_ROUTING.md` when present in the repository.

## Required Workflow
1. First, consult `skills/skills-index/SKILL.md` and `skills/skills-index/references/skills-list.md` to perform the overlap analysis in a token-efficient manner against all descriptions. **Remap paths** if your project stores skills under `.agents/skills/` instead of `skills/`.
2. Only if the index suggests a potential overlap, search and read the specific `SKILL.md` of the overlapping candidate(s).
3. Compare the request with existing skill trigger conditions, context boundary, and execution model.
4. If an existing skill already covers the intent, recommend improving that skill instead of creating a new one.
5. If an existing skill should have been used but was missed, propose routing, trigger, or scope improvements for that existing skill.
6. Only proceed with a new skill when the request has a materially different behavior, trigger, context boundary, or execution model.
7. Author or revise the governed skill in English.
8. Validate that the governed skill includes the canonical contract below.
9. Prompt the user to confirm which **Domain Category** the new or modified skill belongs to. Use neutral domains, for example:
   - **Governance & System Evaluation**
   - **SDLC & Engineering Process**
   - **Architecture & Tooling**
   - **Integrations & Automation**
   - **Domain Modules** (product- or bounded-context-specific)
10. Upon confirmation, update the central catalog (`skills/skills-index/references/skills-list.md` or your project's equivalent path) so the skill and its dependencies are categorized correctly.

## Canonical Skill Contract
Every governed skill must contain these sections:

### Trigger
- State what request patterns, conditions, or contexts must invoke the skill.
- Be specific enough to prevent overlap ambiguity.

### Context/Knowledge
- Define the exact domain boundary the skill covers.
- Name the systems, files, modules, or responsibilities that belong in scope.
- State what the skill does not cover when that boundary would otherwise be ambiguous.
- If the skill requires extensive knowledge lists, tables, or static reference data, extract them into a `references/` directory within the skill's package. The main `SKILL.md` should only reference those external files to keep the instruction file token-efficient and decoupled.

### Dependencies (Mandatory)
- List formal relationships with other repository skills to guide agent routing and context loading:
  - **Parent Skill**: If this skill is a specialized child of a broader skill.
  - **Companion Skills**: Other skills typically invoked or loaded alongside this one.
  - **Required References**: Mandatory external files in `references/` that must be loaded for the skill to operate correctly.

### How/Execution
- Describe how the skill is applied in practice.
- List the required workflow steps or operational checks.
- State the expected execution mode:
  - `Output-producing`: must declare the result, report, artifact, or decision the skill produces.
  - `Execution-only`: may declare that successful task execution is the expected outcome and that no standalone artifact is required.

## Mandatory Governance Fields
Before approving a new skill proposal, include:
- `Closest Existing Skill(s)`
- `Reuse/Extension Option`
- `Why A New Skill Is Necessary`
- `Behavior Difference`
- `Trigger Difference`
- `Context Boundary Difference`
- `Execution Difference`

## Output
Provide the governed proposal in English using this structure:
- `Closest Existing Skill(s)`
- `Reuse/Extension Option`
- `Why A New Skill Is Necessary`
- `Behavior Difference`
- `Trigger Difference`
- `Context Boundary Difference`
- `Execution Difference`
- `Skill Draft` with `Trigger`, `Context/Knowledge`, and `How/Execution`

If the correct outcome is to improve an existing skill instead of creating a new one, the output must say so explicitly and describe the recommended change to that existing skill.

## AI usage metrics (optional)
If the repository maintains a per-skill usage file, increment this skill's counter for the requesting developer after completing the workflow. Otherwise skip.
