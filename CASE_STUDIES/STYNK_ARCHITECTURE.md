# Stynk CRM — architecture slides

These diagrams are a sanitized visual companion to the [Stynk CRM case study](STYNK_CRM.md).

> **Narrative source:** the next visual pass is driven by [STYNK_ARCHITECTURE_CONTENT_SPEC.md](STYNK_ARCHITECTURE_CONTENT_SPEC.md). That document captures the problem, decision, rejected alternatives, trade-off, risk controls and change trigger for each slide. The SVGs below are the current visual iteration and will be revised against that spec.

They are based on the current private-project architecture, but intentionally omit source code, credentials, client data and proprietary business configuration. The point is to show engineering decisions and failure boundaries rather than publish an implementation blueprint.


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

A deliberately modular monolith: Angular and Django/DRF share one main application boundary, while PostgreSQL remains the durable source of business state and asynchronous execution stays behind explicit worker/broker boundaries.

## 2. Inside the modular monolith

![Stynk CRM modular monolith](assets/stynk/architecture/02-modular-monolith.svg)

The current slide captures the topology; the content spec expands the actual decision: local consistency and one operational owner currently matter more than independent service deployment. A split becomes interesting only with evidence such as independent scaling, ownership/release cadence, hard isolation or a measured bottleneck.

## 3. Reliable background work

![Stynk CRM durable async architecture](assets/stynk/architecture/03-durable-async.svg)

Celery executes work; it does not define whether the work exists. Durable `DomainWorkItem` state lives in Django/PostgreSQL, identifiers are enqueued after commit, Redis is transport, and Celery Beat reconciles pending work after failures.

## 4. Studio to canonical runtime

![Stynk CRM Studio and canonical runtime](assets/stynk/architecture/04-studio-canonical-runtime.svg)

The current generalisation work separates a generic Platform language/runtime from Stynk-specific System definitions. The intent is not to make the whole CRM generic, but to model the part of the domain whose variability became structural.

## 5. Pricing without losing history

![Stynk CRM versioned pricing](assets/stynk/architecture/05-versioned-pricing.svg)

Published catalogs are immutable historical evidence. New Jobs pin concrete semantics and persist pricing snapshots; older catalogs remain readable through an explicit compatibility lane. Canonical pricing failure is not hidden by silently reverting to legacy semantics.

## 6. Production topology

![Stynk CRM production topology](assets/stynk/architecture/06-production-topology.svg)

Production intentionally fits on one Linux VPS. The architectural point is recoverability rather than pretending this is high availability: host-level supervision, backups, certificates and recovery remain outside the application queue so they survive application failure.

## 7. Evolution without a rewrite

![Stynk CRM architecture evolution](assets/stynk/architecture/07-evolution-path.svg)

The project is being generalized in place. New schema/runtime paths are additive, historical semantics remain readable, conversion is bounded and adoption creates an explicit no-downgrade point after which the system fixes forward.

---

The diagrams are intentionally simplified. The private repository remains the source of truth for exact implementation details and transition state.
