# VibeGuard — visual tour

[← Case study overview](../VIBEGUARD.md) · [Discovery](discovery.md) · [Tech Owner model](ownership-model.md) · [Prototype & architecture](prototype.md) · [Visual tour](visual-tour.md)

This is the shortest visual path through VibeGuard for now.

The Stynk case study uses a mix of product screenshots and architecture diagrams because there is a production system to show. VibeGuard is at a different stage: the useful artifact today is the **product model**. The diagrams therefore carry the story first; screenshots can be added later without blocking the case study.

## Product thesis

### The responsibility gap in AI-built software

![The responsibility gap in AI-built software](../assets/vibeguard/diagrams/01-responsibility-gap.svg)

AI expands implementation bandwidth, iteration speed and access to software creation much faster than it expands architecture judgement, continuity or accountability.

The product hypothesis is the missing layer between those two curves: a persistent Tech Owner who remains responsible for the technical system while agents perform more of the implementation.

[Read discovery & evolution →](discovery.md)

---

## Discovery & evolution

### The product question moved upward

![From AI rescue to persistent technical ownership](../assets/vibeguard/diagrams/02-discovery-evolution.svg)

The project started with a tactical question:

> who helps when AI-generated code goes wrong?

The prototype then exposed progressively larger problems:

~~~text
AI Studio prototype
   ↓
human rescue marketplace
   ↓
AI audit + structured findings
   ↓
PR review + guardrails
   ↓
human attention becomes the bottleneck
   ↓
persistent Tech Owner
~~~

The useful result is not that every earlier feature should survive.

It is the sequence of assumptions that became too small.

[Read discovery & evolution →](discovery.md)

---

## Ownership model

### Selective human authority, not approval everywhere

![Tech Owner control loop](../assets/vibeguard/diagrams/03-tech-owner-control-loop.svg)

Agents should execute aggressively inside explicit project boundaries.

Routine changes should disappear into tests, CI, static/security checks and automated review. Human attention should be reserved for decisions that change architecture, security, irreversible data semantics, accepted debt or the policy itself.

### Evidence before judgement

![Evidence first, judgement where evidence ends](../assets/vibeguard/diagrams/04-evidence-decision-boundary.svg)

The Tech Owner should not receive a raw stream of PRs and telemetry.

The intended interface compresses implementation activity into a decision packet:

- what materially changed;
- which boundary was crossed;
- what has already been verified;
- which previous decision matters;
- what uncertainty remains;
- what authority is being requested.

[Read the Tech Owner model →](ownership-model.md)

---

## Prototype & architecture

### Keep implemented evidence separate from the product claim

![Prototype evidence vs product direction](../assets/vibeguard/diagrams/05-prototype-product-boundary.svg)

The private repository already implements real pieces of the earlier exploration:

- GitHub repository/branch/file inspection;
- server-side AI audit;
- structured findings;
- line annotations;
- diff/patch interaction;
- debug-ticket and PR-review flows;
- guardrail / agent-instruction experiments.

The newer Tech Owner slice is intentionally thinner and more conceptual. It uses mock decision packets and session state to test the interaction:

~~~text
Project Policy
      ↓
Owner Inbox
      ↓
Decision Workspace
~~~

A real product would need a fresh architecture around durable policy, evidence provenance, GitHub-native event ingestion, authorization, decision memory and auditability.

[Read prototype & claim boundary →](prototype.md)

---

## How the diagrams map to the story

| Diagram | Question it answers |
|---|---|
| **Responsibility gap** | Why does AI-assisted software creation create a new ownership problem? |
| **Discovery evolution** | How did the product move from rescue/debugging to ongoing ownership? |
| **Tech Owner control loop** | Where should agents remain autonomous and where should a human stay authoritative? |
| **Evidence / decision boundary** | How do we avoid turning the senior engineer into a manual PR queue? |
| **Prototype / product boundary** | What has actually been built, what is simulated, and what remains a future design? |

This structure intentionally mirrors the Stynk case study: overview first, then discovery, model, engineering/prototype boundary and a visual synthesis. The difference is that VibeGuard's strongest evidence today is conceptual evolution rather than production scale.

---

## Future screenshot pass

Screenshots are deferred, not required for the current story.

When there is a convenient desktop capture pass, the useful set remains small:

- **Project Policy** — where autonomy stops;
- **Owner Inbox** — which changes survived automated filtering;
- **Decision Workspace** — evidence, historical intent and explicit owner action;
- optional historical **AI Code Auditor / Human Debug Workspace** — to show the earlier rescue/review model.

Those screenshots should support the conceptual diagrams, not replace them.

---

## Closing synthesis

VibeGuard started as a small attempt to put a human back into AI-assisted debugging.

The stronger question appeared one abstraction level higher:

> **Who owns the technical system when implementation itself is increasingly delegated?**

The current answer being explored is:

~~~text
Founder / domain owner
        ↓
product intent
        ↓
AI / coding agents
        ↓
implementation
        ↓
automated evidence
        ↓
material uncertainty only
        ↓
Tech Owner
        ↓
decision / rationale / policy
        └──────────────→ future agent context
~~~

The product is still a PoC.

The ownership model is the artifact worth evaluating now.

[Back to the case-study overview →](../VIBEGUARD.md)
