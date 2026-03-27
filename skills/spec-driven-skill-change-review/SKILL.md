---
name: spec-driven-skill-change-review
description: Reviews PR changes that add, modify, or remove repository skills. Use during PR review to explain the purpose of each skill change, its intended spec/workflow outcome, and contribution risk. Honors optional author-skip policy from AGENTS.md.
---

# Spec-Driven Skill Change Review

Use this skill during **pull request review** when the repository treats agent skills as spec-driven artifacts.

Its purpose is to audit changes to local agent skills. Skill contributions must be reviewed not only for correctness but also for intended purpose and process impact.

## Scope

Inspect the reviewed diff for any file under the repository **skills root** and optional **IDE mirror**, for example:
- `skills/**` (this catalog layout)
- `.agents/skills/**` (common integrated layout)
- `.cursor/skills/**` when it mirrors the canonical skills tree

Treat the following as skill changes:
- new skill folders or new `SKILL.md`
- modifications to any `SKILL.md`
- deletions of skills
- changes to bundled references/assets/scripts that alter a skill's effective behavior

For new or materially changed skills in the canonical tree, also review them against the repository skill-governance policy (`skill-authoring-governance`).

## Identity-based skip rule (configurable)

**Default:** apply the full audit to all authors.

**Optional:** root `AGENTS.md` may define a policy block, for example:

```markdown
## Policy
- **Skill change review skip authors:** `user1@example.com, user2@example.com`
```

When that list is present, do **not** apply the dedicated skill-purpose audit if the resolved author email of the skill-changing commits (prefer commit author; fallback PR author) matches any entry (case-insensitive).

Operational rule:
- Determine the author identity for the skill-changing commits whenever possible.
- Prefer commit author email for commits that touched skill paths in the reviewed range.
- If commit-level attribution is not practical, use the PR author identity as fallback.
- If a skip applies, state explicitly that the skill-purpose section was skipped by repository policy.

## Instructions

1. Detect whether the PR diff changes any skill-related path.
2. If there are no skill-related changes, do nothing further.
3. If there are skill-related changes, determine whether the skip rule applies.
4. If the skip rule does **not** apply, add a **dedicated review section** for skill changes.
5. The section must explain the **purpose** of the change, not just restate the diff.
6. For each changed skill, explain:
   - what behavior/spec/workflow the change is trying to achieve
   - why that change appears necessary in the context of the PR
   - what execution or review behavior will change after the contribution
   - whether the canonical source tree and any IDE mirror remain aligned
   - what risk exists if the purpose is unclear, incomplete, or contradictory
7. For new or materially changed skills, verify whether the contribution:
   - identifies the closest existing skill or skills
   - explains why reuse or extension is not enough
   - has a materially distinct trigger, context boundary, and execution contract
   - follows the required `Trigger`, `Context/Knowledge`, and `How/Execution` contract
   - is authored in English when it is part of a newly created or modified governed skill
8. When the change modifies review logic, call out whether it changes:
   - review scope
   - scoring/verdict policy
   - mandatory sections of the report
   - routing/trigger behavior
   - exceptions/skip rules
9. Report a review finding when a new skill appears duplicative, unjustified, structurally incomplete, or non-English under the governance policy.
10. When the purpose of the skill contribution is unclear, report it as a review finding instead of silently inferring benevolent intent.

## Output contract

When applicable, add a dedicated section to the PR review using this structure:

### Skill Change Purpose Review

For each skill changed:
- `Skill`: skill name/path
- `Intent`: what the contribution is trying to make the agent do differently
- `Spec Impact`: what workflow/spec/rule becomes stricter, looser, broader, or narrower
- `Contribution Risk`: what could go wrong if this purpose is misunderstood or partially implemented
- `Mirror Status`: whether canonical tree and IDE mirror remain synchronized, or what drift exists

When the changed skill is new or materially re-authored, also cover:
- `Overlap Review`: whether an existing skill should have been reused or improved instead
- `Contract Review`: whether `Trigger`, `Context/Knowledge`, and `How/Execution` are complete and specific
- `Language Review`: whether the governed authored content is in English
- `Index categorization`: whether the skill has been properly added to the central skills list with the correct domain and formal dependencies

If the skip rule applies, add instead:
- `Skill Change Purpose Review`: skipped per repository **Skill change review skip authors** policy

## Review standard

- Do not praise the contribution just because it touches agent infrastructure.
- Evaluate whether the change has a clear operational purpose.
- Prefer explaining intended behavior in concrete review terms over abstract meta-language.
- If a skill change silently broadens review authority, routing, or mandatory checks, call that out explicitly.
- If a new skill duplicates an existing skill without a strong boundary difference, call that out explicitly.
- If the skill contract is incomplete or weak, call that out explicitly.
- If a governed skill contribution is not written in English, call that out explicitly.

## AI usage metrics (optional)
If the repository maintains a per-skill usage file, increment this skill's counter for the requesting developer after completing the workflow. Otherwise skip.
