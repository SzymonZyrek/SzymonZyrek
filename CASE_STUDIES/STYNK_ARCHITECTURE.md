# Stynk CRM — architecture slides

These diagrams are a sanitized visual companion to the [Stynk CRM case study](STYNK_CRM.md).

They are based on the current private-project architecture, but intentionally omit source code, credentials, client data and proprietary business configuration. The point is to show the engineering decisions and boundaries rather than publish an implementation blueprint.


### Visual language

The color palette is semantic rather than decorative and stays consistent across the set:

- **cyan** — user/configuration/authoring surfaces;
- **purple** — application and model/runtime logic;
- **green** — durable state and historical truth;
- **amber** — asynchronous execution and operational boundaries;
- **blue** — transport/interface boundaries;
- **red** — legacy compatibility, risk or intentionally retained historical paths.

Each diagram also includes the architectural decision it is meant to explain: the constraint or force behind the choice and the consequence/trade-off of taking that path.

## 1. System at a glance

![Stynk CRM system overview](assets/stynk/architecture/01-system-overview.svg)

A deliberately modular monolith: Angular and Django/DRF share one deployable application boundary, while PostgreSQL remains the durable source of business state and asynchronous execution stays behind explicit worker/broker boundaries.

## 2. Inside the modular monolith

![Stynk CRM modular monolith](assets/stynk/architecture/02-modular-monolith.svg)

The slide makes the trade-off explicit: the system needs strong domain boundaries and shared transactions, but current scale, solo ownership and deployment constraints do not justify the operational tax of distributed services. It also records what would actually justify a later split: independent scaling, ownership/release cadence, hard isolation or a measured bottleneck.

## 3. Reliable background work

![Stynk CRM durable async architecture](assets/stynk/architecture/03-durable-async.svg)

Celery executes work; it does not define whether the work exists. Durable `DomainWorkItem` state lives in Django/PostgreSQL, identifiers are enqueued after commit, Redis is transport, and Celery Beat reconciles pending work after failures.

## 4. Studio to canonical runtime

![Stynk CRM Studio and canonical runtime](assets/stynk/architecture/04-studio-canonical-runtime.svg)

The current generalisation work separates a generic Platform language/runtime from Stynk-specific System definitions. Studio-authored models become versioned `ModelRevision` / `ModelContext` data that can drive typed runtime objects, references, callable behaviour and automation.

## 5. Pricing without losing history

![Stynk CRM versioned pricing](assets/stynk/architecture/05-versioned-pricing.svg)

Published catalogs are immutable historical evidence. New Jobs pin a concrete model/catalog revision and persist pricing snapshots; older catalogs continue through an explicit compatibility lane and historical Jobs are never silently re-priced.

## 6. Production topology

![Stynk CRM production topology](assets/stynk/architecture/06-production-topology.svg)

Production intentionally fits on one Linux VPS: nginx, Django, PostgreSQL, Redis, workers and Beat run in Docker Compose, while host-level supervision, backups, certificates and recovery remain outside the application queue so they survive application failure.

## 7. Evolution without a rewrite

![Stynk CRM architecture evolution](assets/stynk/architecture/07-evolution-path.svg)

The project is being generalized in place: hard-coded Job/pricing semantics first moved into configurable/versioned models, then toward a canonical type/runtime layer. The migration rule is additive — explicit adapters, pinned revisions and preserved historical semantics instead of a big-bang rewrite.

---

The diagrams are intentionally simplified. The private repository remains the source of truth for exact implementation details and transition state.
