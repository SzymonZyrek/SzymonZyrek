# Stynk CRM — architecture content specification

This document is the narrative source of truth for the architecture slide set.

The SVGs should be visual projections of this document, not the place where architectural reasoning is invented. Each slide should explain a real tension: what problem existed, where the boundary was placed, what alternatives were deliberately not chosen, what cost the decision creates, how risk is contained, and what evidence would justify changing the decision later.

The private Stynk repository remains the source of truth for implementation details. This portfolio document intentionally avoids proprietary source code, credentials, customer data and business-specific configuration.

## Evidence discipline

- **Repo fact** — directly reflected in current Stynk architecture/documentation.
- **Architectural interpretation** — the reasoning that best explains why those facts form a coherent architecture.
- **Industry framing** — established concepts used to sharpen the explanation, not to replace project evidence.

The slides themselves should not carry those labels; they are here to keep the content precise.

---

# 1. One coherent application. Boundaries only where responsibility or failure mode changes.

## Core thesis

Stynk is deliberately kept as one main application boundary because the difficult coupling is business consistency, not network scale. Separate runtime boundaries appear only where they provide a concrete benefit: durable state, transport, background execution, public exposure or external effects.

## On-slide narrative

- **Repo fact:** one Angular SPA and one Django/DRF application, backed by PostgreSQL and fronted by nginx.
- **Repo fact:** background execution is separated into broker/workers, while PostgreSQL remains the durable source of business state.
- **Repo fact:** the public website shares nginx infrastructure but exposes only an allowlisted API surface; private CRM attachments are not exposed through it.
- **Architectural interpretation:** boundaries are not drawn around technologies for their own sake. They are drawn where ownership of truth, security exposure or failure behaviour changes.

## WHY THIS DECISION

The original problem was operational fragmentation: contracts, planning, pricing, payments, files and hand-offs had to become one auditable workflow. Splitting that workflow into independent services would add network and consistency problems before there was evidence that independent deployment or scaling was the limiting factor.

The governing rule is: **keep tightly coupled business state inside one consistency boundary; push only genuinely different failure modes behind explicit seams.**

That is why PostgreSQL owns business truth, nginx owns the internet-facing boundary, Redis transports work rather than defining it, and Celery performs work that should not block the request lifecycle.

## ALTERNATIVES NOT CHOSEN

- **Everything synchronous:** simpler initially, but user requests would inherit latency and availability from SMTP, OCR and other external systems.
- **Service-per-domain decomposition:** visually clean, but would turn local transactions into distributed coordination without a demonstrated need for independent scaling or release cadence.
- **Queue as business state:** less application code, weaker recovery and audit semantics.

## TRADE-OFF / WHAT WE ACCEPT

The application and primary database remain shared failure and scaling boundaries. This is not high availability. The payoff is lower operational complexity, local transactions, reproducible development and a smaller number of things that can disagree about current business state.

## CHANGE TRIGGER

Revisit the application boundary when there is measured, sustained evidence for independent scaling, separate ownership/release cadence, hard isolation/compliance, repeated shared-deployment bottlenecks, or reliability requirements that cannot be met inside the current failure boundary.

## Diagram brief

Draw ownership of responsibility rather than a technology inventory:

`User surface → edge boundary → application consistency boundary → durable truth`

Then branch into:

`durable work → transport → execution → external effect`

The visual message: async execution leaves the request lifecycle **without leaving business truth behind**.

---

# 2. Modularity first. Network decomposition only after it earns its cost.

## Core thesis

The backend is intentionally a modular monolith: domain boundaries are explicit in code and service ownership, while shared transactions stay local. Microservices are not rejected in principle; they are deferred until the system develops a reason to pay their operational and consistency cost.

## On-slide narrative

- **Repo fact:** Django apps are organised around domain responsibilities and business workflows belong in service-layer code rather than endpoint handlers.
- **Repo fact:** production uses one PostgreSQL database.
- **Architectural interpretation:** current cross-domain workflows benefit from local ACID transactions more than from network isolation.
- **Architectural interpretation:** with one primary technical owner, independent services would create infrastructure autonomy without organisational autonomy.

## WHY THIS DECISION

The hard part of Stynk is not moving JSON between processes. It is keeping contracts, jobs, pricing, payments, audit and lifecycle effects mutually consistent.

A modular monolith gives both:

1. **strong internal boundaries** — domain modules, service ownership, explicit async seams;
2. **one transactional boundary** where workflows genuinely need atomic changes.

This avoids confusing architectural modularity with network topology.

## ALTERNATIVES NOT CHOSEN

- **Large unstructured monolith:** one deployment boundary is useful; unrestricted cross-module coupling is not.
- **Microservices by domain noun:** would introduce distributed transactions, API versioning, partial failure, contract testing and observability immediately.
- **Premature extraction for hypothetical scale:** spends complexity before a bottleneck exists and makes local reproduction harder.

## TRADE-OFF / WHAT WE ACCEPT

The process boundary does not physically enforce module discipline. Bad imports and leaky abstractions are still possible. The architecture therefore depends on code structure, service ownership, tests and review rather than pretending that network calls automatically create good boundaries.

## CHANGE TRIGGER

Consider extraction when multiple independent signals persist: a materially different scaling profile, separate ownership/release cadence, required physical isolation, the shared database becoming the limiting coupling, or shared deployment being measurably more expensive than the extracted boundary.

Do not invent numeric thresholds in the slide. The important point is that the decision is **falsifiable and evidence-driven**.

## Diagram brief

Use a balance diagram:

- left: forces keeping the boundary together — shared transactions, one operational owner, local reproducibility, one source of truth;
- centre: internal seams — API, service layer, domain modules, async/integration boundaries;
- right: forces that would justify extraction — independent scaling, ownership/release independence, hard isolation, measured bottleneck.

---

# 3. Durable intent first. Queue delivery second.

## Core thesis

Celery and Redis execute and transport work; they do not decide whether business work exists. That decision is persisted transactionally in PostgreSQL so a broker outage or process crash cannot erase committed intent.

## On-slide narrative

- **Repo fact:** durable Django models represent work state and generic `DomainWorkItem` records outbox-style work.
- **Repo fact:** identifiers are enqueued only after the business transaction commits.
- **Repo fact:** Redis is explicitly a broker, not a source of business truth.
- **Repo fact:** Celery Beat reconciles pending durable work after failures.
- **Repo fact:** the Celery result backend is disabled.
- **Architectural interpretation:** this is a deliberate answer to the database/broker dual-write problem.

## WHY THIS DECISION

Two failure windows matter:

- **publish before commit:** an external effect can happen for a transaction that later rolls back;
- **commit before publish:** the database can commit and the process can die before the broker receives the task.

`after_commit` solves only the first window. A durable work record solves the second: after commit, the system still has evidence that the work must happen even if enqueue fails.

The semantic guarantee is not exactly-once delivery. It is:

**committed work intent survives transport failure, and retries are designed not to create a second business effect.**

## WHAT THIS DOES NOT GUARANTEE

- arbitrary raw Celery messages without a durable outbox record are not magically recoverable;
- external effects still require idempotency or deduplication;
- Redis persistence improves operations but does not make Redis the source of record;
- at-least-once execution must not be presented as exactly-once business effects.

## TRADE-OFF / WHAT WE ACCEPT

The design adds durable work states, retries, reconciliation, idempotency and locking/lease logic. That is more machinery than `task.delay()`, but the extra state is what makes failures inspectable and recoverable.

## CHANGE TRIGGER

Revisit the mechanism if event volume makes reconciliation a bottleneck, ordering becomes stronger than the current work-item model, multiple independent consumers need a durable event log, or cross-system integration requires replayable domain events.

## Diagram brief

Make the failure gap visible:

`Business mutation + DomainWorkItem → COMMIT → enqueue ID → Redis → worker → external effect`

Add recovery:

`Beat/reconciler → pending DomainWorkItem → re-enqueue`

Visually emphasise that **PostgreSQL spans the failure gap; Redis does not**.

---

# 4. When variation became the domain, hard-coded types stopped being the right abstraction.

## Core thesis

Stynk is being generalised in place because service shapes and pricing behaviour accumulated enough variation that hard-coded enums, special cases and per-form logic stopped representing the business cleanly. The answer is a versioned model/runtime layer — but only for the part of the system that actually varies.

## On-slide narrative

- **Repo fact:** Platform work defines a generic language for types, values, references, interfaces, behaviour, revisions and runtime resolution.
- **Repo fact:** Stynk is intended to become one System defined and executed through that Platform.
- **Repo fact:** this is foundation/transition work, not a claim that the whole CRM has already been replaced.
- **Repo fact:** Job/Operation integration remains Stynk-owned binding logic rather than a primitive in the generic kernel.

## WHY THIS DECISION

There is a threshold where another enum, another conditional, another custom form and another pricing branch stops being simple. The problem becomes the existence of many legitimate variants.

At that point variation deserves first-class representation: types, fields, references, interfaces, executable behaviour, versioned revisions and deterministic runtime resolution.

But stable Stynk workflows still belong in application code. Making everything generic would trade scattered special cases for a universal meta-framework.

## ALTERNATIVES NOT CHOSEN

- **Continue hard-coding variants:** low immediate cost, rising change cost and duplicated domain knowledge.
- **Loose JSON/form builder:** useful for forms, too weak once identity, references, behaviour and versioned execution matter.
- **Turn the entire CRM into a workflow engine:** maximum flexibility, maximum cognitive cost, and no reason to generalise stable logic.

## TRADE-OFF / WHAT WE ACCEPT

A model language is infrastructure. It introduces revision lifecycle, validation, diagnostics, identity semantics, type resolution, publishing rules, runtime execution and authoring UX.

Complexity has not disappeared. It has moved from **many scattered special cases** into **one explicit modelling subsystem**.

## CHANGE TRIGGER

The Platform boundary should expand only when another domain problem demonstrates the same reusable semantics. If a behaviour exists only for Stynk and has no credible generic use, it should remain a Stynk binding.

The trigger is **repeated semantic reuse**, not architectural ambition.

## Diagram brief

Make the boundary itself the subject:

**Generic Platform:** TypeRef, Composite, Variant, Interface, Callable, Identity/References, Revision/ModelContext.

**Stynk System:** Job, Operation, contract/pricing context, CRM workflows.

Studio is an authoring surface feeding versioned definitions; it is not the Platform itself.

---

# 5. Pricing may evolve. A historical Job must not change meaning.

## Core thesis

Once pricing becomes configurable executable policy, versioning is not optional. Every priced Job must retain the semantic context that produced its price, while new policy can evolve independently.

## On-slide narrative

- **Repo fact:** published catalogs are immutable.
- **Repo fact:** historical Jobs and pricing snapshots are not recalculated during migration.
- **Repo fact:** binding-enabled canonical pricing is selected explicitly; invalid canonical bindings fail rather than silently falling back to legacy pricing.
- **Repo fact:** default Job pricing and override pricing execute through the same graph runtime.
- **Repo fact:** Operation pricing uses a typed `pricing_context` input rather than injecting undeclared fields into the receiver.
- **Repo fact:** old runtime/catalog formats remain readable through explicit compatibility paths while history depends on them.

## WHY THIS DECISION

A pricing function is not just code returning a number. It is policy evaluated against a particular model, catalog/rate set, allowed operations, algorithm and contract/VAT context.

If historical data is later evaluated against whatever is current now, the system changes the meaning of the past.

Therefore preserve both:

1. **the produced business result** — persisted price snapshot;
2. **the semantic frame that produced it** — pinned model/catalog identity and compatibility path.

## THE MOST IMPORTANT DESIGN CHOICES

### Published means immutable

Later edits create a new revision rather than mutating historical evidence.

### Canonical failure is not a reason to try legacy logic

Once a Job is on the binding-enabled path, an invalid binding or graph is an error. This prevents a new runtime from silently producing an old-semantic price whenever the new path breaks.

### Default and custom pricing share one execution model

The default policy is conceptually `operations → Operation.Priced.price() → domain aggregation`. Customisation materialises that same logic into the graph editor. There is no separate Python truth for defaults and graph truth for overrides.

### Runtime values must not lie about their declared type

Operation pricing needs parent Job, catalog constants and curated contract/VAT context. The design exposes this through a typed `pricing_context` input rather than secretly extending `self` with undeclared fields.

## ALTERNATIVES NOT CHOSEN

- **Always recalculate with latest rules:** simple, historically wrong.
- **Store only the final total:** preserves the number but weakens provenance and explainability.
- **Silent canonical → legacy fallback:** improves superficial availability while destroying semantic certainty.
- **Separate implementation for default pricing:** creates two pricing languages that can drift.
- **Augment the receiver with undeclared context fields:** convenient, but makes runtime data violate its declared model.

## TRADE-OFF / WHAT WE ACCEPT

Compatibility code must live longer, multiple historical representations may coexist, and publishing/migration need stricter validation. The architecture intentionally pays that cost because **historical meaning is business data**.

## CHANGE TRIGGER

Compatibility code can be retired only when no persisted historical data requires its semantics. A future pricing runtime should replace this one only if it preserves deterministic revision resolution, historical readability, snapshot provenance, explicit failure semantics and equivalent-or-better authoring/validation guarantees.

## Diagram brief

Use a time-oriented diagram.

Top lane: `Published catalog + ModelRevision → New Job → canonical pricing → persisted snapshot`

Bottom lane: `Historical Job → pinned historical semantics → explicit compatibility reader`

Between them place the invariant:

**new code may evolve; old business meaning may not.**

Add one technical callout: `Operation self + typed pricing_context → Priced.price()`.

---

# 6. Keep production simple enough to operate; keep recovery outside the thing it must recover.

## Core thesis

The current production topology deliberately favours operational simplicity and recoverability over premature high availability. One VPS is a real availability constraint, but critical recovery mechanisms do not depend on the application components they are supposed to restore.

## On-slide narrative

- **Repo fact:** production runs on a single VPS/dedicated server with Docker Compose.
- **Repo fact:** nginx is internet-facing; Django, PostgreSQL, Redis, workers and Beat run behind it.
- **Repo fact:** host-level watchdogs, backups, certificate renewal and OS maintenance remain outside Django/Celery.
- **Repo fact:** an optional separate backup server exists and database backups use `pg_dump`.
- **Repo fact:** host mail remains outside the CRM Compose/service boundary.

## WHY THIS DECISION

A production platform is not free. Multi-node orchestration may reduce some availability risks, but it also adds networking, storage, observability, deployment and recovery systems that must be operated correctly.

For one primary technical owner, a topology that is easy to understand and rebuild has direct reliability value.

The key distinction is:

**high availability keeps serving through failure; recoverability restores service after failure.**

The current design prioritises recoverability.

## FAILURE-BOUNDARY LOGIC

- Django restart → business data remains in PostgreSQL.
- Redis outage → durable work intent remains in PostgreSQL.
- OCR/AI failure → isolated worker boundary protects the normal queue.
- application containers unhealthy → host-level supervision still exists.
- Celery/Beat down → host backups and certificate maintenance do not disappear.
- VPS lost → recovery depends on off-host backup and reproducible deployment, not on containers lost with the host.

## TRADE-OFF / WHAT WE ACCEPT

The VPS is a single online failure domain. There can be downtime while restoring or replacing the host. This is an explicit constraint, not something to hide behind the word production.

## CHANGE TRIGGER

Move toward stronger redundancy when required RTO/RPO cannot be met by tested recovery, host failures create unacceptable business impact, resource saturation is sustained, zero/near-zero downtime releases become a requirement, or independent database/worker nodes solve a measured problem.

Do not publish invented SLA numbers. Add measured RTO/RPO only after restore drills provide them.

## Diagram brief

Make blast radius explicit.

Inside one VPS boundary: nginx, Django, PostgreSQL, Redis, normal worker, OCR/AI worker, Beat.

Outside the application failure boundary: systemd/watchdog, backups, certificate maintenance, host mail boundary, off-site backup box.

The slide should answer: **what still exists when the app is broken?**

---

# 7. Prove the replacement path before deleting the old one.

## Core thesis

Stynk is being generalised in place, not rewritten. New model/runtime paths are introduced additively, historical semantics remain readable, adoption is explicit, and there is a deliberate point after which rollback changes from downgrade to fix-forward.

## On-slide narrative

- **Repo fact:** new binding schema and runtime paths are introduced additively.
- **Repo fact:** published historical catalogs are never rewritten in place.
- **Repo fact:** dynamic-v1 and earlier canonical representations remain readable while persisted data depends on them.
- **Repo fact:** conversion is designed to be all-or-nothing and idempotent.
- **Repo fact:** semantic identity/slot is preserved during conversion where applicable.
- **Repo fact:** first activation of a binding-bearing catalog is an explicit no-downgrade boundary.

## WHY THIS DECISION

A rewrite would need to solve the new model, old-data migration, functional parity, pricing equivalence, deployment, rollback and historical semantics at once. That maximises blast radius precisely when the system already carries production history.

Instead, the migration follows an expand/adopt/contract shape:

- **expand:** add new schema/runtime without invalidating old reads;
- **adopt:** route new authoring and runtime through the canonical path;
- **observe and prove:** validate pricing, persistence and compatibility;
- **contract:** remove old creation/write paths only after the replacement is real;
- **retain:** keep historical readers while historical records still require them.

## IMPORTANT INVARIANTS

### Additive first

The first release carrying the new model does not delete old readers.

### Conversion fails as a unit

If conversion would leave unresolved references, incompatible rules or collisions, it reports blockers and writes nothing.

### Identity survives representation changes

Where a canonical resource changes representation, semantic identity is preserved rather than inventing a new conceptual object.

### Do not infer semantics that are not knowable

An arbitrary old Job pricing graph is not heuristically decomposed into Operation-level pricing. If meaning cannot be proven, preserve the old meaning rather than manufacturing a new one.

### Adoption creates a real compatibility boundary

Once a binding-bearing catalog is published or activated, code older than the first compatible reader is no longer a safe downgrade target.

Rollback becomes: stop further adoption, keep the compatibility reader, publish a later safe revision if necessary, and fix forward.

## ALTERNATIVES NOT CHOSEN

- **Big-bang rewrite:** cleaner target state, much wider failure surface.
- **Destructive migration in place:** simpler schema after migration, but risks rewriting historical meaning.
- **Silent fallback forever:** makes rollout look robust while obscuring which semantics produced a result.
- **Heuristic conversion of arbitrary logic:** false confidence when original intent cannot be reconstructed safely.

## TRADE-OFF / WHAT WE ACCEPT

For a period, several representations and readers coexist. That creates more code and more testing work. The key is that coexistence is **named, bounded and directional**.

## CHANGE TRIGGER

Delete compatibility paths only when no persisted history depends on them. Promote more business configuration into the canonical runtime only after the replacement path has been proven through real persisted Jobs and pricing snapshots.

Migration ends by **removing obsolete responsibilities**, not by achieving a cosmetically legacy-free codebase.

## Diagram brief

Use a migration timeline with gates:

`Hard-coded / dynamic-v1 → canonical model available → binding path proven → first binding catalog activated → fix-forward era`

Across the timeline show: immutable published history, pinned revisions, preserved snapshots and explicit compatibility readers.

Highlight the activation point as **NO-DOWNGRADE BOUNDARY**.

---

# Cross-slide narrative

The seven slides should feel like one argument:

1. **System boundary:** keep one coherent application until a responsibility or failure mode earns separation.
2. **Modular monolith:** preserve local consistency while enforcing internal domain seams.
3. **Durable async:** when execution leaves the request, durable responsibility stays in PostgreSQL.
4. **Canonical runtime:** generalise only the part of the domain whose variability has become structural.
5. **Versioned pricing:** once policy is executable configuration, historical semantics must be pinned.
6. **Production topology:** keep operations proportional to the system and put recovery outside the failure it must recover.
7. **Evolution:** introduce new semantics additively, prove them, then cross an explicit adoption boundary.

The recurring principle is:

> **Add complexity only when it creates a boundary with a clear semantic or operational purpose; once that boundary exists, make its failure behaviour explicit.**

# Rules for the next SVG pass

- one thesis per slide;
- one primary diagram;
- one decision/trade-off panel;
- one explicit change trigger;
- no generic technology inventory unless the technology itself explains a boundary;
- no decorative tags that do not carry semantic meaning;
- no invented scale, SLA, benchmark or migration-completeness claims;
- no suggestion that Platform has already replaced all production CRM paths;
- no implication that Redis/Celery provides exactly-once semantics;
- no framing of compatibility code as accidental debt while it still preserves historical meaning.

The strongest slides should read like compact Architecture Decision Records rather than component maps.