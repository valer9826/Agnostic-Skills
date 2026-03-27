---
name: design-patterns-decision-tree
description: Guide for selecting the most appropriate design pattern based on code "pain points" using a structured decision tree.
---

# Design Patterns Decision Tree

Use this skill when you need to decide which design pattern to apply during development or when reviewing code to identify over-engineering or pattern mismatches. Instead of memorizing patterns, this skill focuses on diagnosing the specific "friction" or "pain" in the code.

## Trigger
- "Which pattern should I use for X?"
- "Evaluate if this logic should use a design pattern."
- During a PR review: "This logic feels complex/over-engineered, suggest a pattern."
- "Refactor this if/else logic or complex construction."

## Context/Knowledge
This skill is based on the decision guide by Alina Kovtun: [Stop Memorizing Design Patterns: Use This Decision Tree Instead](https://medium.com/@akovtun/stop-memorizing-design-patterns-use-this-decision-tree-instead-e84f22fca9fa).

### Core Philosophy
Patterns earn their place when they reduce recurring costs:
- Changes touching too many files.
- Slow/brittle tests due to lack of seams.
- External APIs leaking into domain logic.
- Bloated constructors/initialization.
- Duplicated logic without a stable home.

### The Decision Tree

#### Branch 1: Is the pain about CREATING objects? (Creational)
1. **Truly need exactly one instance?**
   - YES: **Singleton** (Use only for effectively stateless or safe-to-share objects like loggers).
2. **Construction complex or easy to misuse? (Too many optional args)**
   - YES: **Builder** (Makes creation explicit and validates early).
3. **Choosing implementations based on context? (Config, flags, environment)**
   - Base class defines contract, subclasses decide? -> **Factory Method**.
   - Need a family of related/matching objects? -> **Abstract Factory**.
   - Cloning an existing object is cheaper/safer than rebuilding? -> **Prototype**.

#### Branch 2: Is the pain about how objects FIT TOGETHER? (Structural)
1. **Bridging incompatible interfaces? (API/Naming mismatch)**
   - YES: **Adapter** (Protects domain from vendor-specific shapes).
2. **Subsystem too complex to use correctly? (Multiple steps/Ordering)**
   - YES: **Facade** (Provides a simple entry point to a complex workflow).
3. **Optional features without subclass explosion? (Combinatorial mess of logic)**
   - YES: **Decorator** (Adds responsibilities dynamically via composition).
4. **Need a stand-in object? (Lazy loading, caching, access control)**
   - YES: **Proxy**.
5. **Tree/Hierarchical structure needing uniform treatment?**
   - YES: **Composite** (Treat leaf and folder the same).
6. **Paying memory cost for repeated shared state?**
   - YES: **Flyweight**.
7. **Vary abstraction and implementation independently?**
   - YES: **Bridge**.

#### Branch 3: Is the pain about BEHAVIOUR that changes? (Behavioural)
1. **Requests flow through a sequence of independent steps? (Pipeline)**
   - YES: **Chain of Responsibility** (Each step can stop or pass forward).
2. **Need to queue, log, retry, or undo actions? (Action-as-Object)**
   - YES: **Command**.
3. **Swap algorithms without changing the caller? (High-ROI branching)**
   - YES: **Strategy** (Ideal for "if plan is X do this, if Y do that").
4. **Behaviour driven by state/modes? (Connection lifecycles, approval flows)**
   - YES: **State**.
5. **One-to-many notifications? (Subscription updates)**
   - YES: **Observer**.
6. **Snapshots and restores? (Undo/Rollback without exposing internals)**
   - YES: **Memento**.
7. **Coordinator needed so objects don't depend on each other?**
   - YES: **Mediator**.
8. **New operations over a stable object structure?**
   - YES: **Visitor**.

## How/Execution
1. **Diagnose Friction**: Ask "Where is the pain coming from?" (Creation, Structure, or Behaviour).
2. **Consult the Tree**: Match the specific symptom to the pattern recommended in the branches above.
3. **Avoid Over-engineering**: If a simpler move (like a plain function or clear naming) would remove the friction, prefer that over a pattern.
4. **Propose and Review**: When suggesting a pattern, explain the specific "pain" it removes and how it improves maintainability or testability in the current context.

## AI usage metrics (optional)
If the repository maintains a per-skill usage file, increment this skill's counter for the requesting developer after completing the workflow. Otherwise skip.
