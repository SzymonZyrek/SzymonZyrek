# Stynk CRM — discovery, domain evolution and the path from form to platform

This companion to the main [Stynk CRM case study](STYNK_CRM.md) focuses on a part of the project that is easy to miss when looking only at the final architecture:

**there was no finished software specification waiting to be implemented.**

The requirements were discovered iteratively together with the company.

I organised working sessions and conversations with the owner and employees, examined how Office and Sales actually moved information between paper, spreadsheets, Google Drive, e-mail, WhatsApp and verbal hand-offs, translated observations into prototypes and domain rules, then used real feedback to revise the model.

The recurring development loop looked closer to this:

```text
messy real-world process
        ↓
observation / conversations
        ↓
working hypothesis
        ↓
domain model + UX
        ↓
implementation
        ↓
production use / feedback
        ↓
new exception or missing rule
        └──────────────────────→ observation
```

This distinction matters because many of the most important architectural changes in Stynk were not responses to a pre-written roadmap. They were responses to the previous model becoming too small for the business reality we had just learned.

---

## 1. The starting point was deliberately concrete

The first visible product direction was not a generic CRM platform.

It was much smaller:

> take a paper contract and make it possible to capture its data in the application.

An early repository milestone is literally titled **“Add contract capture mock view”**.

That was the right level of abstraction for the information available at the time. Before inventing a generalized workflow engine, the useful question was simply: *what does this paper document need to become on screen?*

The next iterations immediately exposed a larger process.

Office did not merely need a form. It needed a queue of contracts uploaded by Sales, a structured workspace for processing them, Jobs, materials, notes, validation and search. Repository requirements evolved into explicit user stories such as an **Office Intake Queue** and a **Contract Data Entry Workspace**.

The model had already moved:

```text
paper contract
    ↓
data-entry form
    ↓
Sales → Office hand-off
    ↓
queue + role-specific workflow
```

A feature request had turned into process modelling.

---

## 2. Requirements came from work, not from software vocabulary

The people using the system knew their work much better than they knew how to describe software.

That meant discovery usually did not start with questions like:

- what entities should exist?
- what state machine do you need?
- which permissions belong on this endpoint?

It started with questions closer to:

- What happens to this paper after the salesperson signs it?
- Who touches it next?
- What does Office need before they can continue?
- What do people currently message each other about?
- What gets forgotten?
- When does money become due?
- What changes when the client cancels?
- Who is allowed to overwrite this information?
- What is the exception everyone handles manually?
- Which fields exist because of one service rather than every service?

The engineering work was turning answers to those questions into explicit concepts.

That is why the resulting domain contains more than Client/Contract CRUD. It contains lifecycle transitions, Jobs, scheduling, subcontractor assignment, payments, commission obligations, attachments, audit history, notifications, pricing revisions and role-specific workflows.

The model accumulated because the business process was being made explicit.

---

## 3. The model repeatedly lost arguments with reality

A useful way to understand Stynk's evolution is through assumptions that were reasonable at one stage and later stopped being sufficient.

### “A Contract is a form”

The first useful abstraction was structured contract data.

Real use exposed a much richer object: a Contract moves between Sales, Office, legal/withdrawal stages, payments, execution, completion and cancellation. Some transitions create financial obligations; others affect Jobs, planning, notifications or commissions.

The answer was not a bigger HTML form.

It was a **Contract lifecycle** with controlled transitions and business effects.

---

### “One person edits a Contract”

That assumption works in a prototype.

It breaks when Office staff work concurrently on long-lived records.

The repository later gains explicit **contract edit locking**, including ownership/override behaviour rather than relying on accidental last-write-wins semantics.

That change is a good example of requirement discovery through organisational reality: the missing concept was not a database field but *edit ownership between people*.

---

### “An attachment is one file”

Paper does not care about database cardinality.

A physical contract or annex may arrive as several photographs or scans. The system therefore had to move from a simplistic file association to **multi-file contract attachments** while preserving the logical document/workflow around them.

Again, the data model changed because the physical process contradicted the original abstraction.

---

### “People will enter all of this manually”

Once the intake process was understood and stable enough, the repetitive part became obvious.

That created a sensible boundary for OCR: automate extraction, but do not let OCR silently become authoritative business state.

The resulting architecture is review-first:

```text
scan
  ↓
extract
  ↓
normalize + confidence
  ↓
human review
  ↓
explicit application
```

The important product decision is not “use AI”. It is **where AI authority stops**.

---

### “A Job type can be represented in code”

For a while this is perfectly reasonable.

Then the number of service-specific fields, Operations and pricing rules grows, services change, pricing evolves and historical contracts still need to retain their original meaning.

At that point another hard-coded model class or enum does not solve the underlying problem.

The question changes from:

> How do I add the next Job type?

to:

> Why should changing the business offer require changing application code at all?

That led to configurable Job/Operation metadata, dynamic pricing rules, versioned catalogs and migration seams from legacy Jobs.

This was the first major jump from **implementing business variants** to **modelling business variants**.

---

### “Dynamic JSON is enough”

Making fields configurable solves one class of change, but creates another.

If backend validation, frontend rendering, pricing, Studio authoring and runtime execution each interpret dynamic structures differently, configuration becomes another source of drift.

That drove a deeper generalisation: a canonical type/model layer with concepts such as typed references, Composites, Variants, identity, value paths, references and runtime objects.

The problem was no longer just configurable forms.

It was making different parts of the system share **one executable meaning** of the model.

---

### “Configuration can live in a settings screen”

Eventually the model became too expressive for ordinary CRUD administration.

Once users can define typed models, bindings and executable pricing behaviour, the configuration surface is effectively a small modelling environment.

That is why Config Studio evolved toward a workspace with an explorer, editor, inspector, diagnostics and graph-based callable authoring.

The UI changed because the underlying abstraction had changed category.

---

## 4. Generalisation happened after evidence, not before it

One of the aspects I value most in this project is what I did **not** build at the beginning.

The initial problem was not answered with a generic enterprise metadata platform.

It was answered with a contract capture view.

Only after repeated concrete pressure did the abstraction move upward:

```text
contract capture
      ↓
role-specific workflow
      ↓
business lifecycle
      ↓
configurable Jobs
      ↓
configurable pricing
      ↓
canonical model/runtime
      ↓
Config Studio
```

This is the opposite of starting from a framework and looking for a problem to justify it.

The reusable layer emerged after enough domain-specific implementation existed to show which concepts were actually repeated and which ones belonged specifically to Stynk.

That distinction remains explicit in the current architecture:

```text
generic Platform semantics
        ↓
Stynk application bindings
        ↓
Contract / Job / Operation / pricing workflows
```

The generic layer does not need to know what a roof, subcontractor or construction Contract is.

Stynk does.

---

## 5. Pricing is the clearest example of progressive discovery

Pricing started as ordinary business logic attached to known service types.

It became progressively more demanding because several concerns intersect:

- different services expose different parameters;
- Operations can contribute independently to a Job;
- rates and rules change over time;
- already-created Jobs must retain historical meaning;
- users need to understand how a price was produced;
- new services should not require a deployment;
- default pricing should be simple while exceptional logic remains expressible.

That is how a “price calculator” problem eventually produced:

- configurable Job and Operation definitions;
- catalog/version concepts;
- immutable published semantics;
- typed execution context;
- capability-based pricing behaviour;
- graph execution for custom logic;
- persisted price snapshots/components;
- migration and compatibility paths for legacy data.

The interesting part is not the number of mechanisms.

It is that each mechanism answers a failure mode discovered in the previous level of the model.

---

## 6. UX was part of domain discovery

Frontend work was not separate from requirements engineering.

A screen often exposed whether the domain model made sense.

Field Sales naturally uses phones away from a desk. Office users process dense information. Subcontractors care about a different projection of the same Job. Long Contract forms make concurrent editing visible. Scans need to remain next to normalized data because the source evidence still matters.

This led to product decisions such as:

- dedicated phone-portrait behaviour rather than shrinking desktop layouts;
- workflow-specific screens instead of one universal entity editor;
- shared edit-lock patterns;
- map-assisted address entry;
- attachment galleries tied to business context;
- lifecycle-driven actions rather than arbitrary status dropdowns.

Small UX observations also mattered.

The repository preserves requirement notes as specific as phone-field focus/dropdown behaviour. That kind of detail is useful evidence that the system was iterated against actual interaction rather than designed only as backend entities.

---

## 7. Production changed the engineering process too

As the application grew, the problem was no longer only how to design Stynk.

It also became: **how do I keep changing it safely with one technical owner and a rapidly growing codebase?**

The answer evolved in the same evidence-driven way:

- domain and architecture documentation became part of repository state;
- CI became a continuous feedback mechanism rather than a final gate;
- migration/runbook documentation became necessary as historical data grew in value;
- browser-driven E2E checks were introduced for semantic workflows that unit tests alone could not prove;
- feature flags and compatibility seams allowed new runtime paths to coexist with legacy behaviour during migration;
- issues and PRs became explicit units of work and evidence.

Later, coding agents became participants in this loop.

The useful model was not “AI writes code”.

It became:

```text
authoritative docs
      +
bounded issue
      +
tests / CI / browser evidence
      ↓
coding / review agent
      ↓
PR + observable evidence
      ↓
accept / repair / refine model
```

That is an extension of the same pattern used for product discovery: make state explicit, run something against reality, observe the result, improve the model.

---

## 8. My role changed as the system changed

My contribution is better described as a sequence of overlapping responsibilities than as one job title.

### Product discovery

I organised the conversations and working sessions used to understand the process, asked the questions, observed how different roles actually worked and turned informal practice into candidate requirements.

### Product and UX design

I proposed workflows and interaction models, built prototypes, tested them against users and revised them when they did not match the work.

### Domain modelling

I translated operational rules into explicit concepts: Contract lifecycle, Jobs, Operations, payments, scheduling, attachments, pricing history, permissions, audit and later canonical modelling primitives.

### Architecture and implementation

I designed and implemented the application across Angular, Django/DRF, PostgreSQL, background work, deployment and integrations.

### Production ownership

I handled deployment, migration safety, backups, debugging, rollback paths and iterative support of the running system.

### Agentic engineering

As the repository and change rate grew, I increasingly designed the development system around the code as well: documentation, task boundaries, agent roles, CI feedback, browser evidence, issue/PR coordination and review.

These roles did not replace each other.

They accumulated.

---

## 9. What the Git history shows

The private repository provides a useful chronological trace because architectural changes are visible next to the requirements and tests that motivated them.

Representative milestones include:

- **“Add contract capture mock view”** — a concrete UI-first starting point;
- **Office Intake Queue / Contract Data Entry** — the form becomes a role-specific process;
- **contract edit locking** — concurrency becomes an organisational requirement;
- **multi-file contract attachments** — physical documents force a richer data model;
- **Celery and OCR initial implementation** — repetitive intake becomes an automation boundary;
- **configurable Job types metadata and pricing rules** — business variation begins moving out of code;
- **canonical modelling primitives / TypeRef / ValuePath** — dynamic configuration grows into a shared model language.

The repository also contains processed requirements, domain documentation, migration plans, E2E modules and architecture notes.

That makes the project useful as more than a before/after portfolio screenshot: it preserves much of the reasoning path between the two.

---

## 10. The pattern I would reuse elsewhere

The most transferable lesson from Stynk is not a Django or Angular technique.

It is this sequence:

1. start from a real operation, not an imagined abstraction;
2. make one useful slice explicit;
3. put it in front of the people doing the work;
4. treat exceptions as information about the model;
5. generalise only after repetition provides evidence;
6. preserve historical meaning when the model changes;
7. automate execution only after responsibility and authority are clear;
8. make documentation and verification part of the system once change itself becomes complex.

The current architecture is much more sophisticated than the first contract screen.

That sophistication is useful precisely because it was **earned by successive collisions with the real process**.

The project did not move from “simple” to “complex” because complexity was the goal.

It moved from **implicit business knowledge to an increasingly explicit executable model**.
