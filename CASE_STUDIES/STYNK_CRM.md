# Stynk CRM — from paper workflow to an executable business system

> **Source:** proprietary / private  
> **Role:** product engineer · system architect · end-to-end technical owner  
> **Domain:** construction services · field sales · contracts · jobs · pricing · operational planning

Stynk started with a deliberately small question: **how do we turn a paper contract signed in the field into usable structured data?**

Production use kept revealing the next missing concept. A form became a Sales → Office hand-off, then a lifecycle, planning and payments system, then configurable Jobs and pricing, and eventually a versioned model/runtime with a visual authoring environment.

## In 30 seconds

| | |
|---|---|
| **Problem** | Business state was split between paper, spreadsheets, Drive, e-mail, WhatsApp and people's memory. |
| **Product** | One role-aware CRM connects sales visits, Contracts, Jobs, scheduling, files, payments, commissions, notifications, audit and the public website. |
| **Architecture** | Angular + Django/DRF + PostgreSQL as one modular transactional core; durable async work through Celery/Redis; explicit public/private and external-service boundaries. |
| **Evolution** | Hard-coded service/pricing variants are being generalized into typed, versioned models, capabilities and executable graphs in Config Studio. |
| **Engineering model** | Requirements, documentation, tests, CI, browser evidence, deployment and production feedback are treated as one feedback system. |

**The recurring pattern:** start from a real operation, make it explicit, let production expose the missing concept, then generalize only when repetition earns the abstraction.

![Contract and Job lifecycle orchestration](assets/stynk/architecture/02-lifecycle-orchestration.svg)

## The story

### 1. From a form to an operating workflow

The initial useful slice was contract capture. The real process quickly showed that the important thing was not the form itself, but **who owns the information next and what business consequences follow from a state change**.

A Contract becoming binding creates financial obligations. A Job actually starting changes execution state and payment timing. Planning, subcontractor assignment, notifications and audit all follow the same domain events.

[Read the product & domain deep dive →](STYNK_PRODUCT_AND_DOMAIN.md)

### 2. One coherent business core, with explicit seams

Contracts, Jobs, pricing, payments, planning, notifications and audit share one transactional business model. Domain apps and services keep responsibilities explicit; slow/external work leaves through durable async boundaries.

![Stynk CRM business core](assets/stynk/architecture/01-business-core.svg)

Redis transports work; it does not decide whether work exists. Business-significant async intent is stored in PostgreSQL first, then executed by normal or isolated OCR/AI workers.

[Read the engineering system deep dive →](STYNK_ENGINEERING_SYSTEM.md)

### 3. The model eventually became the product surface

As service variants and pricing rules accumulated, the question changed from *“how do I add the next Job type?”* to *“why should changing the business offer require changing application code?”*

That led from configurable metadata to canonical typed models, Stynk bindings, reusable Interfaces/capabilities, versioned catalogs and graph-authored behavior.

![Capability-based Job and Operation pricing](assets/stynk/architecture/05-capability-pricing.svg)

The current Studio/runtime direction preserves one important rule: **visual authoring and backend execution must mean the same thing**. Published semantics are versioned so new pricing policy can evolve without rewriting historical Jobs.

[Read the model, Studio & runtime deep dive →](STYNK_MODEL_AND_RUNTIME.md)

### 4. The development system had to evolve too

Once the codebase and change rate grew, maintainability stopped being only a code-structure problem. Domain docs, migration notes, CI, browser acceptance, deployment tooling and issue/PR evidence became part of repository state.

Coding agents later joined that loop, but the useful abstraction stayed the same:

```text
authoritative state
      +
bounded change
      +
automated / browser evidence
      ↓
implementation
      ↓
observable result
      ↓
accept / repair / refine
```

The same feedback-loop idea appears at both levels: learn the business by running the product against reality; learn whether a code change is safe by running it against explicit evidence.

## Explore by depth

| If you have… | Read / view |
|---|---|
| **30 seconds** | This page: problem, product, architecture and evolution. |
| **5 minutes** | [Discovery & domain evolution](STYNK_DISCOVERY_AND_EVOLUTION.md) — how requirements and abstractions were actually discovered. |
| **5–10 minutes** | [Product & domain](STYNK_PRODUCT_AND_DOMAIN.md) — lifecycle, mobile/office UX, OCR, sales lead flow, permissions. |
| **5–10 minutes** | [Model, Studio & runtime](STYNK_MODEL_AND_RUNTIME.md) — typed model language, bindings, pricing capabilities and automation runtime. |
| **5–10 minutes** | [Engineering system](STYNK_ENGINEERING_SYSTEM.md) — architecture, durable async, deployment, CI/verification and agent-ready repository design. |
| **Visual tour** | [Architecture & engineering slides](STYNK_ARCHITECTURE.md). |

## What changed over the project

```text
paper contract capture
        ↓
Sales → Office workflow
        ↓
Contract / Job lifecycle
        ↓
planning + payments + notifications + audit
        ↓
configurable Jobs and pricing
        ↓
canonical typed model/runtime
        ↓
Config Studio + versioned executable policy

in parallel:

manual verification
        ↓
repository documentation + CI
        ↓
browser-level acceptance evidence
        ↓
agent-capable development workflow
```

The interesting part is not that the final system is more sophisticated than the first screen. It is that each layer appeared after the previous model met a real limitation.

## Source boundary

The implementation repository is private because it contains proprietary business logic and production-oriented code for a real company. This case study uses sanitized diagrams and screenshots instead of publishing a toy reconstruction that would no longer be the actual system.
