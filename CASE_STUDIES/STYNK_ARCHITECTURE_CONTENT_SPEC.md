# Stynk CRM — architecture content specification

This document is the narrative source of truth for the architecture slide set.

The portfolio story is intentionally **capability-first**. Each slide starts from something the system can do reliably or safely, then shows the architectural mechanism that makes it possible. Trade-offs still matter, but they are supporting context rather than the headline.

The private Stynk repository remains the implementation source of truth. This portfolio material avoids proprietary source code, credentials, customer data and private business configuration.

---

# 1. One coherent business core, modular by domain

## Core thesis

Contracts, Jobs, pricing, payments, planning, notifications and audit belong to one connected business workflow. Stynk keeps them inside one transactional application while making responsibility boundaries explicit in modules and services.

## What the slide should show

- Angular/REST at the edge.
- Thin API layer.
- Domain modules for contracts, jobs, pricing, payments, planning, materials/equipment, attachments, notifications and audit.
- Service layer orchestrating business workflows across modules.
- PostgreSQL as one business source of truth.
- Narrow seams to background execution, files and public integrations.

## Why this architecture is useful

A contract lifecycle transition can atomically update related business state instead of coordinating several remote services.

The codebase still has boundaries:
- views translate HTTP;
- services own workflows;
- models own durable domain state;
- selectors/read paths stay separate where useful;
- background/external work leaves through explicit seams.

This gives Stynk **transactional workflows without giving up modularity**.

## Portfolio message

The interesting choice is not “monolith instead of microservices”. It is that the deployable shape follows the shape of the business: tightly coupled lifecycle state stays local, while genuinely different responsibilities get clear seams.

## Diagram direction

Show a central “Business core” with domain modules around a service layer and one PostgreSQL source of truth. Around the outside show frontend/API, background execution, files and public integrations as explicit boundaries.

Bottom bar:

**What this buys us:** atomic lifecycle changes · one business truth · simple local debugging · clear extraction seams

---

# 2. Business state drives the workflow

## Core thesis

In Stynk, status changes are not cosmetic labels. Lifecycle transitions are orchestration points that update payments, planning, commissions, notifications and audit state.

## Concrete examples from the current domain

### Contract becomes BINDING

The lifecycle service:
- creates client payment obligations;
- creates sales-rep commission obligations;
- updates the contract state;
- emits notifications;
- records the transition.

### First Job actually starts

The system:
- moves the Contract execution phase forward;
- gives the client prepayment obligation its real due date;
- updates operational visibility;
- can emit urgent reminders if payment remains unresolved.

### Last Job completes + final payment settles

The system:
- completes the execution path;
- makes final-payment/commission consequences explicit;
- updates history and notifications.

## Architectural shape

Lifecycle services are the orchestration boundary. They own:
- transition validation;
- multi-model updates;
- transactional consistency;
- explicit side effects;
- audit/notification emission.

The UI does not independently recreate those rules.

## Portfolio message

This is the layer where a CRUD application becomes an operational system: **business events propagate through one controlled workflow instead of being reconstructed independently by screens, cron jobs and ad-hoc handlers.**

## Diagram direction

Use a horizontal Contract/Job state flow. Under selected transitions, fan out to Payments, Planning, Notifications, Materials/Equipment and Audit.

Bottom bar:

**Design principle:** one semantic transition → all related business effects

---

# 3. Durable automation that survives transport failure

## Core thesis

Background work is anchored in durable application state before it reaches the queue. Redis transports work; Celery executes it; PostgreSQL remembers that the work exists.

## Execution path

1. Business transaction updates domain state.
2. A durable `DomainWorkItem` is persisted with the transaction.
3. After commit, only the identifier is enqueued.
4. Redis transports the message.
5. The correct worker reloads durable state and executes.
6. Celery Beat reconciles pending work after delivery failures.

## Worker isolation

Normal application queues:
- default;
- notifications;
- maintenance.

Isolated heavy/external queues:
- OCR;
- AI.

This keeps document-processing latency and provider failure away from ordinary application work.

## Why this architecture is useful

- committed intent remains inspectable even if Redis is unavailable;
- request latency does not inherit OCR/SMTP/provider latency;
- retries operate against durable state;
- scheduled reconciliation can recover work after broker/process failure;
- queue payloads carry identifiers rather than sensitive business truth.

## Portfolio message

The strength is not “using Celery”. The strength is **separating durable responsibility from transport and execution**.

## Diagram direction

Main pipeline:

`Business transaction + DomainWorkItem → COMMIT → Redis → Worker → external effect`

Recovery loop:

`Beat / reconciler → pending DomainWorkItem → re-enqueue`

Second lane: normal workers vs isolated OCR/AI workers.

Bottom bar:

**Result:** responsive requests · recoverable async work · isolated heavy processing · inspectable retries

---

# 4. Generic model kernel, Stynk-specific system bindings

## Core thesis

The generalisation work extracts reusable modelling/runtime semantics without hiding the Stynk domain behind a universal framework.

## Generic Platform kernel

Reusable concepts include:
- typed values and TypeRefs;
- Composite and Variant definitions;
- identity and references;
- Interfaces, Functions and Methods;
- Events, Triggers and StateMachines;
- immutable ModelRevisions;
- ModelContext resolution;
- RuntimeObjects and callable execution.

## Stynk System layer

Stynk keeps domain-specific semantics where they belong:
- which Composite may act as a CRM Job;
- which Operations are allowed for that Job;
- Contract/VAT/pricing context;
- CRM lifecycle integration;
- application-specific authoring surfaces.

## Why this architecture is useful

The same runtime primitives can serve more than pricing or more than one domain, while the Platform core stays free of concepts such as “roof job”, “contract” or “subcontractor”.

At the same time Stynk remains readable as a business application rather than becoming a pile of generic metadata.

## Portfolio message

The reusable boundary is driven by **semantic reuse**: generic execution primitives go into the kernel; business roles stay in system bindings.

## Diagram direction

Two layers:

**Platform kernel**
Type system · identity · references · callable runtime · events/state machines · versioning

↓ generic runtime contracts

**Stynk System**
Job bindings · Operation bindings · pricing context · CRM lifecycle · UI adapters

Bottom bar:

**Extensibility without domain leakage:** generic runtime below, explicit business semantics above

---

# 5. Jobs are composed from reusable typed capabilities

## Core thesis

The target Job model replaces hard-coded Job/Operation type hierarchies with canonical Composites plus explicit Stynk bindings and reusable capabilities.

## Model

Any suitable canonical Composite can be bound as a Stynk Job.

Allowed Operations are relationships in the Stynk binding layer rather than special fields embedded into the generic type system.

An Operation can implement:

`stynk.interface.priced.price(...)`

The default Job pricing convention is then:

`self.operations → Operation.Priced.price() → aggregate PricingResults`

## Typed execution context

Operation pricing can use:
- its own canonical value;
- parent Job projection;
- catalog constants/rates;
- curated Contract/VAT data.

Those dependencies arrive through a typed `pricing_context` input.

The Operation receiver stays exactly the value declared by its Composite.

## Customisation

Default pricing is generated as a normal callable graph.

Choosing “customise” materialises that same logic into the existing graph editor, where the user can:
- filter Operations;
- add minima/discounts/transport;
- replace aggregation;
- completely replace the default pricing path.

There is no separate hidden pricing engine for custom logic.

## Why this architecture is useful

- new Job/Operation shapes are modeled instead of hard-coded;
- Operations carry reusable behavior through Interfaces;
- default conventions remain simple;
- advanced users can override the convention without changing runtime semantics;
- Studio and backend reason about the same typed method signatures.

## Portfolio message

This is the point where dynamic configuration becomes **polymorphic domain behaviour**, not just configurable fields.

## Diagram direction

`Composite → Stynk Job binding`

Job contains relational Operations.

Each Operation:

`canonical value + typed pricing_context → Priced.price()`

Then:

`map all Operations → aggregate → Job PricingResult`

Side branch:

`Default graph → Customise → same graph runtime`

Bottom bar:

**One model:** convention for the common case, graph composition for the exceptional case

---

# 6. Every price remains reproducible and explainable

## Core thesis

A configurable price is not just a number. Stynk preserves the published model, catalog semantics, result snapshot and execution explanation that produced it.

## Publication model

Draft configuration may change.

Published catalogs/model revisions are immutable.

A Job is evaluated against pinned semantics.

The persisted pricing result keeps the business outcome, while components/trace can explain how that outcome was calculated.

## Runtime evidence

A pricing result can expose:
- net/gross/VAT totals;
- components;
- rates/constants used;
- execution trace;
- model/catalog identity.

Simulation uses the real interpreter without writing a real Contract.

## Historical behavior

Later configuration changes create new revisions.

They do not silently reinterpret old Jobs.

Historical data remains readable against the semantics under which it was created.

## Why this architecture is useful

- pricing changes can be deployed without rewriting history;
- users can inspect how a result was produced;
- Studio simulation and production execution share semantics;
- audit/history remains meaningful after the model evolves.

## Portfolio message

Versioning is not administrative overhead here. It is what makes **executable business policy safe to change**.

## Diagram direction

Timeline:

`Draft → validate → Published Revision R17 → Job → price() → snapshot + components + trace`

Later:

`Revision R18` handles new work.

Old Job remains pinned to R17.

Bottom bar:

**Safe evolution:** new rules move forward; historical meaning stays reproducible

---

# 7. Public website and CRM share infrastructure, not trust

## Core thesis

Stynk keeps deployment simple while enforcing a strict boundary between public website traffic and authenticated CRM data.

## CRM side

- session authentication;
- CSRF protection;
- role/object-level authorization;
- private attachments delivered through permission-checked Django views;
- financial and role-specific data filtered at API level.

## Public side

The public website shares the nginx edge but receives only explicitly reviewed public surfaces.

Current examples include:
- contact / inquiry endpoints;
- sales-region/public configuration endpoints;
- reviewed public realizations;
- derived public media only.

Everything else under the CRM API is denied from the public host.

## Edge controls

nginx owns:
- hostname routing;
- TLS;
- security headers;
- upload limits;
- rate limiting on public forms;
- public API allowlisting.

Private CRM attachments are never exposed as generic static media.

## Why this architecture is useful

One deployment can host both the company website and the CRM without treating them as one trust zone.

The public site can reuse selected CRM-backed data while the default remains closed.

## Portfolio message

The architecture optimises for **explicit exposure**: public access is granted endpoint by endpoint and artifact by artifact, rather than by sharing the internal application surface.

## Diagram direction

One nginx edge, two host lanes:

**stynk.eu**
→ static site
→ allowlisted public APIs
→ derived public media

**CRM host**
→ authenticated Angular SPA
→ full DRF API subject to role/object permissions
→ protected attachments

Bottom bar:

**Shared infrastructure, separate trust:** public by explicit allowlist; private by default

---

# Cross-slide narrative

The architecture story should read as one coherent system:

1. **One business core** keeps connected domain state transactional.
2. **Lifecycle services** turn business transitions into coordinated system effects.
3. **Durable async** moves slow/external work out of the request path without losing intent.
4. **The Platform kernel** extracts only genuinely reusable semantics.
5. **Capabilities and bindings** let new Job/Operation models carry behavior without hard-coded class trees.
6. **Versioned execution** makes configurable pricing safe, explainable and historically reproducible.
7. **Trust boundaries** let public and internal products share infrastructure safely.

The recurring principle is positive:

> **Keep business semantics explicit, make execution deterministic, and introduce a boundary when it creates a concrete capability.**

# Rules for the next SVG pass

- Lead with what the architecture enables, not what it lacks.
- Prefer concrete system behavior over abstract architecture vocabulary.
- Use “why this is useful” framing rather than defensive comparison.
- Show one primary mechanism per slide.
- Use real Stynk concepts: Contract, Job, Operation, DomainWorkItem, ModelRevision, pricing trace, public API allowlist.
- Keep caveats in secondary copy unless they are the actual engineering insight.
- Match the visual tone of the wider portfolio: light surfaces, crisp cards, semantic accent colors, strong headings and bottom-line takeaways.
- Avoid a slide whose main thesis is infrastructure modesty (“one VPS”) or architectural non-choice (“not microservices”).
- Avoid generic component inventories that could describe any Django application.
