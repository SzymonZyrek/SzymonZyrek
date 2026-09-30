# Stynk CRM — architecture slides

These diagrams are a sanitized visual companion to the [Stynk CRM case study](STYNK_CRM.md).

> **Narrative source:** [STYNK_ARCHITECTURE_CONTENT_SPEC.md](STYNK_ARCHITECTURE_CONTENT_SPEC.md) is the content source of truth. The diagrams below are now rebuilt from that spec: each one focuses on an architectural tension, the chosen boundary, the trade-off and the condition that would justify changing the decision.

They are based on the current private-project architecture, but intentionally omit source code, credentials, client data and proprietary business configuration. The point is to show engineering decisions and failure boundaries rather than publish an implementation blueprint.

### Visual language

The palette is semantic rather than decorative:

- **cyan** — user/configuration/authoring surfaces;
- **purple** — application and model/runtime logic;
- **green** — durable state and historical truth;
- **amber** — asynchronous execution and operational boundaries;
- **blue** — transport/interface boundaries;
- **red** — legacy compatibility, risk or intentionally retained historical paths.

## 1. One coherent application

![Stynk CRM system overview](assets/stynk/architecture/01-system-overview.svg)

Boundaries appear where responsibility changes: internet exposure at nginx, transactional business consistency inside Django/PostgreSQL, and asynchronous execution behind a durable-work seam. The slide deliberately separates **truth ownership** from **execution location**.

## 2. Modularity before network decomposition

![Stynk CRM modular monolith](assets/stynk/architecture/02-modular-monolith.svg)

The decision is framed as a balance of forces rather than “monolith good / microservices bad”: shared transactions, one operational owner and local reproducibility currently favour one process boundary; independent scaling, ownership, physical isolation or a measured bottleneck would justify extraction later.

## 3. Durable intent before queue delivery

![Stynk CRM durable async architecture](assets/stynk/architecture/03-durable-async.svg)

The diagram exposes the database/broker failure window directly. PostgreSQL stores committed work intent, Redis transports identifiers, workers execute, and reconciliation repairs missed delivery. It also states what the design does **not** promise: exactly-once external effects.

## 4. Generalise recurring variability, not the whole CRM

![Stynk CRM Studio and canonical runtime](assets/stynk/architecture/04-studio-canonical-runtime.svg)

The generic Platform kernel contains reusable semantics such as types, identity, references, behaviour and revision resolution. Job/Operation bindings, pricing context and CRM workflows remain Stynk-owned. Promotion into the kernel is driven by repeated semantic reuse, not by a desire to make everything configurable.

## 5. Pricing as executable policy and historical evidence

![Stynk CRM versioned pricing](assets/stynk/architecture/05-versioned-pricing.svg)

New pricing policy may evolve, but historical Jobs must retain the meaning under which they were priced. Published catalogs stay immutable, snapshots are preserved, compatibility is explicit, canonical failure does not silently fall back to legacy logic, and runtime context stays typed rather than being injected magically.

## 6. Recovery before redundancy

![Stynk CRM production topology](assets/stynk/architecture/06-production-topology.svg)

The single VPS is shown honestly as one online failure domain. The architectural point is that watchdogs, backups, certificates and off-host recovery remain outside the application components they must recover. This is a recoverability-first topology, not a claim of high availability.

## 7. Prove the replacement path before deleting the old one

![Stynk CRM architecture evolution](assets/stynk/architecture/07-evolution-path.svg)

The migration is additive and gated: new structures arrive before old readers disappear; conversion is all-or-nothing and idempotent; semantic identity is preserved; unknown historical semantics are not guessed. Activating the first binding-bearing catalog is the explicit no-downgrade boundary after which rollback becomes fix-forward.

---

The diagrams are intentionally simplified. The private repository remains the source of truth for exact implementation details and transition state.
