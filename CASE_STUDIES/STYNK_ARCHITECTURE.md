# Stynk CRM — visual engineering tour

[← Case study overview](STYNK_CRM.md) · [Discovery & evolution](STYNK_DISCOVERY_AND_EVOLUTION.md) · [Product & domain](STYNK_PRODUCT_AND_DOMAIN.md) · [Model & runtime](STYNK_MODEL_AND_RUNTIME.md) · [Engineering system](STYNK_ENGINEERING_SYSTEM.md)

This page is the visual route through the project. The diagrams are sanitized projections of the private production codebase: enough detail to show the engineering decisions, without publishing client data, credentials or proprietary implementation.

The slides use one visual language:

- **blue — application / domain flow**
- **green — durable state / historical truth**
- **purple — model / runtime**
- **orange — asynchronous / external execution**
- **red — trust / security boundary**

---

## Product & domain

### Business state drives the workflow

![Contract and Job lifecycle orchestration](assets/stynk/architecture/02-lifecycle-orchestration.svg)

A Contract/Job state change is an orchestration point, not a decorative status. Payments, planning, commissions, notifications and audit all follow controlled lifecycle transitions.

[More product/domain detail →](STYNK_PRODUCT_AND_DOMAIN.md)

---

## Core system & reliability

### One coherent business core, modular by domain

![Stynk CRM business core](assets/stynk/architecture/01-business-core.svg)

Contracts, Jobs, pricing, payments, planning, notifications and audit remain inside one transactional business system. Slow/external work, files and public exposure leave through explicit seams.

### Durable automation outside the request path

![Stynk CRM durable async architecture](assets/stynk/architecture/03-durable-async.svg)

PostgreSQL stores the fact that work exists. Redis transports identifiers. Celery executes. Reconciliation can rediscover committed work after delivery failure, while OCR/AI queues stay isolated from routine application work.

### Public website and CRM share infrastructure, not trust

![Stynk CRM public/private security boundary](assets/stynk/architecture/07-public-private-boundary.svg)

The website and CRM can share an nginx edge without becoming one trust zone. Public application surfaces are allowlisted; CRM data and attachments remain identity-, role- and object-protected.

[More engineering detail →](STYNK_ENGINEERING_SYSTEM.md)

---

## Model, Studio & executable policy

### Reusable Platform kernel, explicit Stynk bindings

![Stynk CRM Platform and System boundary](assets/stynk/architecture/04-platform-system-boundary.svg)

The generic layer owns reusable semantics — types, references, callable execution, events/state machines and revision resolution. Job/Operation roles, pricing context and CRM lifecycle meaning remain explicit Stynk bindings.

### Jobs composed from reusable typed capabilities

![Stynk CRM capability-based pricing](assets/stynk/architecture/05-capability-pricing.svg)

Canonical Composites describe shape; Stynk bindings assign business roles; Operations implement capabilities such as `Priced.price()`. Default and customized pricing stay on the same typed execution model.

### Every price remains reproducible and explainable

![Stynk CRM versioned pricing](assets/stynk/architecture/06-versioned-pricing.svg)

Published semantics are immutable and Jobs remain pinned to the revision that priced them. Snapshots, components and execution trace preserve both the business result and the explanation behind it while new policy moves forward.

[More Studio/runtime detail →](STYNK_MODEL_AND_RUNTIME.md)

---

## How this architecture emerged

The final structure makes more sense when read alongside the history of failed assumptions that produced it: Contract-as-form, single-editor assumptions, hard-coded Job types, “dynamic JSON is enough”, and finally configuration becoming a modelling environment.

[Read discovery & domain evolution →](STYNK_DISCOVERY_AND_EVOLUTION.md)
