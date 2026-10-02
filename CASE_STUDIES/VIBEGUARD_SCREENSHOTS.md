# VibeGuard — recommended portfolio evidence

VibeGuard has moved beyond the original Code Auditor / debug-marketplace prototype, so the screenshot set should show the **current ownership-control-plane workflow**.

Keep the public set small: **3 core images**, plus 1–2 optional ones.

---

## Core 1 — Projects / Founder capability confirmation

**Suggested filename:** vibeguard-founder-capabilities.png

Show:

- a real registered repository;
- GitHub App-backed project state;
- discovered or manually edited capabilities;
- impact rules / required skills;
- explicit Founder confirmation;
- no human Owner selector.

The point is to prove the product rule:

~~~text
Founder declares project responsibilities
VibeGuard resolves ownership
~~~

**Caption**

> Founder onboarding turns bounded repository evidence into editable capability suggestions. Suggestions are inert until explicit confirmation; Owner identity is not part of repository configuration.

---

## Core 2 — PR-aware Owner Inbox

**Suggested filename:** vibeguard-owner-inbox.png

Show one real pull request grouped as a review workspace with:

- repository + PR;
- impacted capability;
- why it was routed to this Owner;
- matched files / patch context;
- Approve / Request changes.

This should be the hero product screenshot.

**Caption**

> Owner review is capability-scoped and PR-aware: routing evidence, GitHub patches and the exact change under review stay together before the authenticated Owner decides.

---

## Core 3 — GitHub PR with VibeGuard evidence

**Suggested filename:** vibeguard-github-check.png

Show the GitHub side:

- a real PR;
- VibeGuard technical-ownership check;
- pending/success/failure state;
- capability/Owner context in the check or comment;
- the owner-required label when applicable.

This proves that VibeGuard is a control plane around the existing engineering workflow rather than a separate toy universe.

**Caption**

> GitHub remains the durable engineering substrate. VibeGuard writes ownership state back as normal repository evidence: checks, labels and comments bound to the current PR head.

---

## Optional 4 — Owner skill inference

**Suggested filename:** vibeguard-owner-profile.png

Show:

- authenticated GitHub identity;
- CV or connected-repository inference;
- structured skill suggestions;
- explicit review/edit/save boundary.

**Caption**

> CV and repository evidence can propose technical skills, but only the Owner's saved profile participates in deterministic capability matching.

---

## Optional 5 — module impact direction

The architecture diagram is already stored in the portfolio:

- assets/vibeguard/module-impact-signals.svg

Use it when explaining the next evolution beyond path-only impact.

Be explicit that routes, symbols, domain state, events and dependency signals are the **designed extension seam**, not all fully implemented detectors today.

---

## Screens to retire from the hero narrative

Do not lead with the older:

- Code Auditor;
- debug-ticket marketplace;
- Guardian/reviewer marketplace;
- generic PR review board;
- empty dashboard.

They are useful only if explaining the product pivot.

The new story is:

~~~text
project model
   ↓
capability ownership
   ↓
real PR impact
   ↓
Owner review
   ↓
durable GitHub decision
~~~

---

## Screenshot hygiene

Before capture:

- use repositories and PRs safe to show publicly;
- hide e-mail addresses, installation ids and private repository names where appropriate;
- never expose OAuth/App/OpenAI credentials;
- keep the same browser size across screenshots;
- prefer real state over mock metrics;
- show one coherent flow rather than many unrelated tabs.

Recommended desktop viewport: roughly 1440×900.

Store images under:

CASE_STUDIES/assets/vibeguard/
