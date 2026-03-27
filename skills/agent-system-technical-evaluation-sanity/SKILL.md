---
name: agent-system-technical-evaluation-sanity
description: Performs a non-mutating technical evaluation of the repository's AI agent system, including skills, workflows, prompts, orchestration logic, dependency shape, token-efficiency risks, and scalability concerns.
argument-hint: "[Pasted agent config content, repository target, or evaluation request]"
---

# Agent System Technical Evaluation Sanity

## Closest Existing Skill(s)
- `skill-authoring-governance`
- `spec-driven-skill-change-review`

## Reuse/Extension Option
Reusing or extending the closest existing skills is insufficient for this task.

- `skill-authoring-governance` governs creation and material change of repository skills, but it does not perform standalone architecture evaluation of the local agent system.
- `spec-driven-skill-change-review` audits skill-related changes inside pull request review flows, but it is diff-oriented and not designed for direct system evaluation outside PR context.

## Why A New Skill Is Necessary
This repository needs a dedicated evaluation skill for requests that ask for analysis-only feedback on the AI agent system itself. The requested behavior is repository-level architecture diagnosis, not governance enforcement, not PR scoring, and not skill-diff auditing.

## Behavior Difference
This skill diagnoses:
- architecture quality of the local agent system
- skill granularity and separation of concerns
- dependency relationships and overlap risks
- token-efficiency risks caused by repeated or nested instruction surfaces
- workflow orchestration quality, leakage, rigidity, and duplication
- scalability concerns as the skill/workflow inventory grows
- common agent-system anti-patterns

It also produces a corrective improvement plan, but it must not rewrite skills, workflows, prompts, or files unless the user later requests implementation.

## Trigger Difference
Use this skill when the user asks to:
- evaluate the AI agent system
- sanity-check the agent configuration layout (skills, workflows, routing)
- review the design of local skills, workflows, prompts, or orchestration
- analyze token efficiency or dependency structure of the local agent system
- assess architecture quality of the local agent framework

It also applies when the user pastes agent definition files and asks for technical feedback only.

## Context Boundary Difference
This skill covers:
- the repository **skills tree** (in this catalog: `skills/**`; in many projects: `.agents/skills/**`)
- **workflows** under the agent source tree when present (for example `.agents/workflows/**`)
- prompt, routing, and orchestration instructions that define agent behavior
- directly referenced local assets needed to understand effective agent behavior

This skill does not cover by default:
- modifying any repository file
- generating rewritten skills, workflows, or prompts
- evaluating unrelated app/product modules unless the local agent system explicitly references them and they are necessary to explain behavior
- IDE-specific mirrors (for example `.cursor/**`) unless the user explicitly requests a compatibility sync task

## Execution Difference
This skill is analysis-only and output-producing. Its expected outcome is a structured diagnosis plus an improvement plan. It must not perform implementation work during the evaluation itself.

## Trigger
- Requests to technically evaluate, audit, or sanity-check the repository's AI agent system
- Requests to assess skill/workflow architecture, orchestration quality, or token-cost risks
- Requests to review pasted agent definitions without changing them

## Context/Knowledge
- The system under evaluation is the repository's local AI agent framework (skills, optional workflows, routing).
- The evaluation may use pasted content, repository inspection, or a mixed mode combining both.
- The default scope is the minimum set of files and directly referenced local assets needed to explain the behavior being evaluated.
- Findings must stay architectural and operational. Do not claim behavior that cannot be supported by the provided snippets or inspected repository files.
- If the user provides only partial snippets, explicitly separate confirmed facts from inference.
- The skill must preserve the repository's thread-scope boundary and avoid unrelated repository exploration.

## How/Execution
1. Determine the input mode:
   - pasted content only
   - repository inspection only
   - mixed mode
2. Read only the minimum files and directly referenced local assets required for the requested evaluation.
3. Map the effective architecture:
   - skill boundaries
   - workflow boundaries
   - orchestration/routing surfaces
   - explicit and implicit dependencies
4. Evaluate architecture quality:
   - granularity
   - separation of concerns
   - modularity
   - reusability
5. Evaluate dependency quality:
   - unnecessary nesting
   - deep dependency chains
   - duplicated responsibilities
   - tight coupling
   - hidden dependencies
6. Evaluate token-efficiency risks:
   - large instruction blocks
   - repeated policy/context
   - nested skill expansion
   - duplicated trigger wording
   - duplicated output contracts
7. Evaluate workflow design:
   - whether workflows orchestrate skills correctly
   - whether workflow logic leaks into top-level routing or skill internals
   - whether workflow steps duplicate skill behavior
   - whether workflows are overly rigid or complex
8. Evaluate scalability:
   - impact of growing to 20-50+ skills
   - contribution risk with multiple engineers
   - maintenance risk as workflow graphs grow
9. Detect anti-patterns such as:
   - skill nesting explosion
   - prompt bloat
   - hidden dependencies
   - monolithic skills
   - duplicated context
   - tight coupling between skills
   - orchestration leakage
10. Produce only analysis and an improvement plan.

Hard rules:
- Do not modify, rewrite, or refactor skills, workflows, prompts, or files unless the user later asks for implementation.
- Do not output rewritten code or alternative implementations by default.
- Keep the improvement plan architectural and operational, not code-generating.

## Output
The standard response must contain exactly these sections in order:

1. `Overall Assessment (score 1-10)`
2. `Architectural Strengths`
3. `Architectural Weaknesses`
4. `Skill Dependency Observations`
5. `Token Efficiency Risks`
6. `Workflow Design Evaluation`
7. `Scalability Concerns`
8. `Detected Anti-Patterns`
9. `Final Evaluation`
10. `Improvement Plan`

The `Improvement Plan` section must stay non-mutating and use these buckets when relevant:
- `Consolidation`
- `Dependency Simplification`
- `Token Efficiency`
- `Workflow Hardening`
- `Scalability`

When evidence is incomplete, call that out explicitly instead of overstating certainty.

## AI usage metrics (optional)
If the repository maintains a per-skill usage file (for example `metrics/ai_agent_usage.json` or `.agents/metrics/ai_agent_usage.json`), increment this skill's counter for the requesting developer after completing the workflow. Otherwise skip.
