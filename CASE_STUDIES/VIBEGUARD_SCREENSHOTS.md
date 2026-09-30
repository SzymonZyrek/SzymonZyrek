# VibeGuard — recommended portfolio screenshots

The repository is private, so screenshots are the fastest way to prove that VibeGuard is a real working prototype rather than only a product idea.

I would keep the public set small: **3 core screenshots**, plus 1–2 optional ones.

The goal is to show the workflow, not every tab.

---

## Core screenshot 1 — Code Auditor with real findings

**Suggested filename:** vibeguard-code-auditor.png

**What to show**

- a real public/sample repository selected;
- branch selector visible;
- repository tree visible;
- one non-trivial source file open;
- AI audit result visible;
- several line annotations visible;
- drift/risk score and summary visible;
- “request human debug” / escalation action visible if possible.

**Why this should be the hero image**

This single screen communicates almost the entire product hypothesis:

~~~text
real repository
    +
real source
    +
AI verification
    +
structured findings
    +
human escalation
~~~

It is much stronger than a landing page or dashboard.

**Good demo setup**

Use a small repository/file containing 2–4 intentionally understandable issues:

- wrong API usage;
- missing edge case;
- weak error handling;
- invented parameter/import;
- obvious security smell.

Avoid a huge production file where the reviewer cannot visually understand what the annotations refer to.

**Caption**

> Live repository inspection with structured AI findings attached to source lines. Findings remain reviewable evidence and can be escalated into a human debugging workflow.

---

## Core screenshot 2 — Human Debug Workspace in diff mode

**Suggested filename:** vibeguard-human-debug-diff.png

**What to show**

- ticket title and repository/file context;
- original vs proposed patch;
- diff tab active;
- meaningful code change;
- at least one review comment or explanation;
- ticket status / assigned human visible if the layout permits.

**Why it matters**

This is the screenshot that proves VibeGuard is not merely “LLM comments on code”.

It shows the second half of the idea:

~~~text
automation reaches uncertainty
        ↓
context survives escalation
        ↓
human engineer works on the same evidence
        ↓
reviewable patch
~~~

**Caption**

> Human escalation preserves repository, file, audit and ticket context, then turns the investigation into a reviewable patch/diff rather than another disconnected chat.

---

## Core screenshot 3 — PR Review Board

**Suggested filename:** vibeguard-pr-review-board.png

**What to show**

- a pull request with repository/branch context;
- diff summary;
- review status;
- AI audit summary if available;
- human-review action/state.

**Why it matters**

This places the idea inside a normal engineering lifecycle.

A recruiter working on DevTools, CI, testing or AI reliability immediately sees how the concept could live next to GitHub rather than requiring teams to abandon their existing workflow.

**Caption**

> PR-level review concept: automated inspection and human review operate around the same repository-native delivery boundary.

---

## Optional screenshot 4 — Debug Requests board

**Suggested filename:** vibeguard-debug-board.png

Show several tickets with different status/urgency and one claimed/in-progress request.

This is useful if the board looks visually strong because it explains that escalation is a workflow with ownership and state, not just a modal.

**Caption**

> Debug requests are explicit work items with repository context, state and ownership instead of ephemeral messages.

---

## Optional screenshot 5 — Repository connection / file explorer

**Suggested filename:** vibeguard-repository-inspection.png

Use this only if the UI looks especially good.

The important thing to capture is that the application works against repository/branch/file context rather than pasted snippets.

This should not replace the Code Auditor screenshot; it is supporting evidence.

---

## Optional screenshot 6 — Guardian / human reviewer routing concept

**Suggested filename:** vibeguard-reviewer-routing.png

This can be visually attractive, but it needs a very explicit caption:

> Experimental reviewer-routing UI. Marketplace, reputation and billing are product concepts rather than production subsystems.

I would **not** use this as one of the first three screenshots because the human-review marketplace is more speculative than the code-audit/debug workflow.

---

## Screens I would avoid

Do not spend portfolio space on:

- login/auth modal;
- empty states;
- generic navigation;
- configuration screens;
- mock-heavy marketplace screens without a prototype disclaimer;
- screenshots dominated by placeholder profiles or fake metrics;
- a screen where the AI result is only a block of prose.

Those screens prove very little.

---

## Recommended order in the case study

If using three screenshots:

1. **Code Auditor** — “Here is the problem being inspected.”
2. **Human Debug Diff** — “Here is the escalation and resolution loop.”
3. **PR Review Board** — “Here is how the idea connects back to normal software delivery.”

That creates a coherent story:

~~~text
inspect
  ↓
verify
  ↓
escalate
  ↓
patch/review
  ↓
delivery boundary
~~~

---

## Screenshot hygiene

Before capturing:

- use a public/sample repository or code you are comfortable publishing;
- remove GitHub tokens, e-mails and private repository names;
- make sure no browser password-manager overlays are visible;
- avoid exposing Gemini/API configuration;
- use one consistent browser size for all desktop screenshots;
- crop out irrelevant browser chrome when possible;
- do not fake production claims — if a surface is conceptual, label it as conceptual.

A 1440×900-ish desktop viewport should work well for the current layout.

---

## Portfolio image paths

When the screenshots are ready, store them under:

CASE_STUDIES/assets/vibeguard/

with:

- vibeguard-code-auditor.png
- vibeguard-human-debug-diff.png
- vibeguard-pr-review-board.png
- optional vibeguard-debug-board.png
- optional vibeguard-reviewer-routing.png

Then embed only the three strongest images in VIBEGUARD.md; leave the rest available for application-specific links or later portfolio expansion.
