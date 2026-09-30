# VibeGuard — human-in-the-loop reliability for AI-assisted software development

> **Source:** private repository / public sanitized case study  
> **Status:** active prototype / product R&D  
> **Role:** product concept, architecture, full-stack implementation and workflow design  
> **Focus:** AI-assisted code verification, debugging, review and human escalation

VibeGuard explores a problem that becomes more important as code generation gets cheaper:

**producing code is getting easier faster than trusting it is getting easier.**

The project is not an attempt to build another coding agent. It explores the layer around coding agents: repository inspection, structured audit, review, debugging, escalation and the hand-off from automated findings to a human engineer.

The current prototype combines:

- live repository inspection;
- AI-assisted source-file audit;
- structured findings attached to lines of code;
- interactive patch/diff review;
- debug-ticket and PR-review workflows;
- a human review/escalation concept.

The implementation is intentionally labelled as a prototype. It is useful as a concrete product and systems experiment, not as a claim that the marketplace, identity, persistence or billing parts are already production-ready.

See also: [recommended screenshots for this case study](VIBEGUARD_SCREENSHOTS.md).

---

## 1. The problem

AI-assisted development changes where engineering effort goes.

If a model can generate a plausible implementation in seconds, the bottleneck increasingly moves toward questions such as:

- Did the generated code actually match the repository and its APIs?
- Did it invent imports, parameters, contracts or assumptions?
- Did it introduce subtle logic or edge-case failures?
- Did it make the system harder to maintain while appearing locally correct?
- Is a suggested patch safe enough to accept automatically?
- When should automation stop and hand the problem to a human?
- How can the human receive enough context to avoid reconstructing the entire failure from scratch?

VibeGuard treats those as workflow questions rather than only prompt-engineering questions.

The product hypothesis is:

~~~text
AI-assisted implementation
        ↓
structured verification
        ↓
context-rich findings
        ↓
automated fix when confidence is sufficient
        ↓
human escalation when judgement is required
        ↓
patch / review / resolution
~~~

The interesting boundary is not “AI or human”.

It is deciding **which parts can be automated safely, which evidence should survive between steps, and what context a human needs when automation reaches its limit**.

---

## 2. Current prototype workflow

The current application has several connected surfaces.

### 2.1 Repository connection and source inspection

A repository can be selected and inspected through the application.

The code auditor can:

- load repository metadata;
- list branches;
- browse directories and files;
- open source files;
- select a range of lines;
- keep repository, branch and file context together.

The point is to audit code **inside actual repository context**, rather than pasting disconnected snippets into a chat window.

### 2.2 AI file audit

The selected source file can be sent to the server-side AI audit path.

The current audit returns structured data including:

- a drift/risk score;
- an overall summary;
- line-level annotations;
- annotation type;
- description;
- suggested fix.

The current annotation model includes categories such as:

- bug;
- hallucination;
- security;
- technical debt;
- overengineering;
- good practice.

That structure matters because the useful output is not just prose. The UI can associate a finding with a concrete location and then use the same context in later review or escalation steps.

A simplified flow is:

~~~text
repository / branch / file
        ↓
server-side source fetch
        ↓
AI code audit
        ↓
structured findings
        ↓
line annotations + suggested fixes
        ↓
developer review
~~~

### 2.3 Human escalation

From an audited file, the developer can create a debug request carrying forward:

- repository identity;
- branch;
- file path;
- source code;
- selected line range;
- AI findings;
- problem description.

That is the key product idea: **escalation should not throw away the evidence already collected by automation**.

The request becomes a debug ticket that can be claimed by a human reviewer.

### 2.4 Debug workspace

The human debug workspace keeps the review loop in one place.

The current prototype supports:

- original source;
- editable patch;
- code / patch / diff views;
- generated unified diff;
- review discussion;
- ticket state;
- resolution flow;
- persisted local draft state for an active session.

The intended loop is:

~~~text
AI-assisted developer
        ↓
debug request
        ↓
AI findings + repository context
        ↓
human engineer claims work
        ↓
inspect / discuss / patch
        ↓
diff review
        ↓
resolution
~~~

This is deliberately different from “ask another model”.

The purpose of the human path is to introduce a qualitatively different review boundary when the remaining uncertainty is architectural, ambiguous or expensive enough to justify human judgement.

### 2.5 PR review workflow

The prototype also contains a PR review board.

The direction is to treat pull requests as another verification boundary:

~~~text
pull request
   ↓
automated inspection
   ↓
review context
   ↓
AI and/or human review
   ↓
approve / request changes / continue investigation
~~~

This is still product R&D, but it connects VibeGuard to the same repository-native lifecycle used by normal engineering teams rather than inventing a separate code-delivery universe.

### 2.6 Human reviewer network concept

The application includes an experimental reviewer/“Guardian” surface for routing difficult work toward experienced engineers.

The current UI explores:

- expertise/specialty filtering;
- availability;
- repository/codebase match;
- response-time and profile metadata;
- requesting review.

This is a product concept, not a production marketplace. The current implementation does not claim durable reputation, payments or production-grade identity.

---

## 3. Architecture

The current prototype is intentionally small.

~~~mermaid
flowchart LR
    U[Developer / Reviewer] --> R[React + TypeScript UI]
    R --> E[Express / TypeScript server]

    E --> G[GitHub REST API]
    E --> A[Google GenAI SDK]

    G --> E
    A --> E

    E --> S[Structured audit result]
    S --> R

    R --> T[Debug / review workflow]
    T --> D[Patch + diff + discussion]

    B[Browser local state] --> R
    M[Prototype in-memory server state] --> E
~~~

The core stack is:

- React 19 + TypeScript;
- Vite;
- Express / TypeScript;
- GitHub REST integration;
- Google GenAI SDK;
- Tailwind CSS;
- diff/patch UI;
- Docker / Docker Compose.

The prototype currently keeps some workflow state in memory and some client session/draft state in browser storage.

That is useful for iterating on the interaction model quickly, but it is intentionally not presented as the final architecture.

---

## 4. Trust boundary: AI findings are evidence, not truth

One of the design principles behind the project is that an AI audit result should be treated as **reviewable evidence**, not as an authoritative mutation.

The current flow separates:

~~~text
model observation
      ↓
structured finding
      ↓
UI annotation
      ↓
human interpretation
      ↓
optional patch / escalation
~~~

That separation is important because a model can be confidently wrong.

The product therefore favors:

- explicit findings over invisible automatic edits;
- line-level context over generic prose;
- diff review over opaque replacement;
- escalation over pretending uncertainty does not exist;
- preserving repository context across the hand-off.

The same principle shows up in the server boundary: model/API credentials stay on the server side rather than being exposed directly to the browser.

---

## 5. Why the human hand-off is a systems problem

A naive escalation feature is just a button saying “ask an expert”.

That loses most of the value already created by the automated steps.

The more interesting version preserves a chain of evidence:

~~~text
repo
 ↓
branch
 ↓
file
 ↓
selected lines
 ↓
AI findings
 ↓
developer notes
 ↓
debug ticket
 ↓
human patch
 ↓
diff
 ↓
discussion / resolution
~~~

The reviewer should arrive with enough state to start reasoning about the problem, not spend the first half of the session asking the developer to reconstruct it.

That is the systems aspect of VibeGuard that interests me most: **making uncertainty, evidence and escalation explicit parts of the workflow**.

---

## 6. Product shape: verification around agentic development

VibeGuard sits next to, rather than inside, my autonomous-agent experiments.

A useful way to think about the projects is:

~~~text
HackaTeam
“How much engineering work can an agentic loop execute autonomously?”
        ↓
VibeGuard
“How do we inspect, verify and escalate when autonomous or AI-assisted work should not simply be trusted?”
~~~

HackaTeam explores execution and autonomy.

VibeGuard explores review, trust, debugging and human intervention.

That distinction is deliberate. More autonomy creates more value only if verification and recovery improve with it.

---

## 7. Current limitations — deliberately visible

The repository is private while the product direction changes, but the public case study should be explicit about what the current prototype is **not**.

Today:

- ticket/review marketplace state is not backed by a durable production database;
- browser-local state is used for parts of auth/session/draft behavior;
- the human-review network is a concept/prototype, not a live commercial marketplace;
- billing and payouts are not implemented as a production subsystem;
- identity/reputation are not production-grade;
- some UI concepts are ahead of the backend architecture;
- the generated diff path is intentionally simple and would need stronger patch semantics before production use;
- the system does not claim to solve automated code correctness in general.

These are not hidden gaps.

They are the next engineering questions the prototype is meant to expose.

---

## 8. What I would harden next

If the product were moved from exploration toward a production beta, my next priorities would be:

### Durable workflow state

Replace in-memory ticket/review state with a real persistence model for:

- tickets;
- review sessions;
- assignments;
- comments;
- patch revisions;
- status transitions;
- audit history.

### Real authorization boundaries

Introduce production OAuth/session handling and explicit authorization for:

- repository access;
- source retrieval;
- creating review requests;
- reading private review context;
- applying or exporting patches.

### Better audit evaluation

The hardest AI problem is not calling a model.

It is measuring whether the audit is useful.

I would add a repeatable evaluation harness with seeded repositories/bugs and metrics around:

- true/false positive findings;
- severity quality;
- localization accuracy;
- suggested-fix usefulness;
- regression detection;
- reviewer agreement.

### Patch provenance

A production workflow should make it obvious:

- what code came from the repository;
- what finding came from the model;
- what change came from the human;
- what was ultimately accepted;
- what evidence supported the decision.

### Repository-native integration

The strongest direction is to keep GitHub/Git workflows as the durable engineering substrate:

- issues;
- pull requests;
- review comments;
- CI;
- commit history.

The product should add verification and escalation, not replace the ecosystem engineers already use.

---

## 9. Why this project matters to my portfolio

VibeGuard is useful to me as a portfolio project because it connects several parts of my background:

- production debugging;
- code review;
- Git/repository workflows;
- full-stack product implementation;
- AI-assisted software delivery;
- human-in-the-loop system design;
- evidence and reliability thinking.

The interesting claim is not “I built an AI code reviewer”.

It is:

> As implementation becomes increasingly automated, verification, context preservation and escalation become first-class software architecture problems.

VibeGuard is my attempt to make that idea concrete enough to interact with, break and improve.
