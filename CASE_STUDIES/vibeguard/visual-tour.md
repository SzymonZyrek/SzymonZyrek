# VibeGuard — visual tour

[← Case study overview](../VIBEGUARD.md) · [Evidence](evidence.md) · [Discovery](discovery.md) · [Tech Owner model](ownership-model.md) · [Business case](business-case.md) · [Prototype](prototype.md)

This is the shortest visual path through the idea.

VibeGuard is still R&D, so the strongest artifacts today are the **problem model, evidence, control loop and claim boundary** rather than polished product screenshots.

## 1. The responsibility gap

![The responsibility gap in AI-built software](../assets/vibeguard/diagrams/01-responsibility-gap.svg)

AI expands implementation bandwidth faster than it expands architecture judgement, continuity or accountability.

The product question is not whether an LLM can write code.

It is:

> **Who owns the technical system when implementation itself is increasingly delegated?**

---

## 2. The engineering model

![From coding agents to a new engineering model](../assets/vibeguard/diagrams/07-engineering-model.svg)

Models, skills and plugins improve local implementation capability.

The harder layer is keeping an AI-heavy system coherent through changing requirements, large refactors, migrations, security decisions and another year of product history.

That is the layer VibeGuard is aimed at.

---

## 3. External evidence: the premise is real

![Evidence landscape](../assets/vibeguard/diagrams/08-evidence-landscape.svg)

The research pass does **not** validate VibeGuard demand.

It does support the premise:

- AI-assisted development is already mainstream;
- AI-native repository/tooling activity is growing quickly;
- overall software-change volume is rising;
- trust drops sharply around consequential work;
- AI-agent skills are appearing in labor-market demand.

[Research snapshot & sources →](evidence.md)

---

## 4. The proposed delegation boundary

![Delegation boundary](../assets/vibeguard/diagrams/09-delegation-boundary.svg)

This slide is explicitly an inference, not a survey result.

The proposed split is:

~~~text
reversible + mechanically verifiable
        → automate aggressively

material architecture / security / semantics
        → package evidence and escalate

irreversible / accepted risk / policy change
        → explicit human authority
~~~

The goal is not "human approval everywhere".

It is **human judgement where the meaning of the system changes**.

---

## 5. How the idea evolved

![From AI rescue to persistent technical ownership](../assets/vibeguard/diagrams/02-discovery-evolution.svg)

The product question moved upward:

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

The useful result is the sequence of assumptions that became too small.

[Discovery & evolution →](discovery.md)

---

## 6. The Tech Owner control loop

![Tech Owner control loop](../assets/vibeguard/diagrams/03-tech-owner-control-loop.svg)

Agents execute inside known boundaries.

Tests, CI, scanners and automated review absorb mechanical verification.

Only material uncertainty reaches the Tech Owner.

### Evidence before judgement

![Evidence first, judgement where evidence ends](../assets/vibeguard/diagrams/04-evidence-decision-boundary.svg)

The human should receive a compressed decision packet:

- what materially changed;
- which boundary was crossed;
- what is already verified;
- which previous decision matters;
- what uncertainty remains;
- what authority is requested.

[Tech Owner model →](ownership-model.md)

---

## 7. Why this can matter commercially

![Business case for reorganizing agentic engineering](../assets/vibeguard/diagrams/06-business-case.svg)

If implementation becomes cheaper, more real-world software becomes worth building.

But if every generated change still requires traditional senior review, judgement becomes the new throughput ceiling.

The business hypothesis is therefore:

> **use automation to scale execution, and experienced engineers to scale technical ownership.**

The stakeholder-facing version is simpler:

> **There is a pilot in this plane.**

[Business case →](business-case.md)

---

## 8. What is actually built

![Prototype evidence vs product direction](../assets/vibeguard/diagrams/05-prototype-product-boundary.svg)

The private prototype already contains real repository inspection, AI audit, structured findings, diffs, debug/PR flows and guardrail experiments.

The newer Tech Owner slice is deliberately smaller:

~~~text
Project Policy
      ↓
Owner Inbox
      ↓
Decision Workspace
~~~

Its decision packets are simulated. Durable policy, decision memory, event ingestion, authorization and auditability remain product work.

[Prototype & claim boundary →](prototype.md)

---

## 9. The whole thesis in one loop

~~~text
business intent
      ↓
coding agents
      ↓
implementation
      ↓
automated evidence + policy
      ↓
material uncertainty only
      ↓
Tech Owner
      ↓
decision / rationale / exception / policy change
      └────────────→ future agent context
~~~

Success is not "maximum autonomy" and not "maximum review".

It is:

> **more useful software per unit of scarce senior attention without losing technical accountability.**

[Back to case-study overview →](../VIBEGUARD.md)
