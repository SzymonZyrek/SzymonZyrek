# Commercial engineering history

Most of the systems described below were developed in employer-owned repositories, so this page focuses on products, engineering scope and architectural responsibility rather than source code.

The common thread is not one framework or language. It is the progression from working inside individual components to understanding how products, integration boundaries, deployment environments and operational feedback fit together.

## Misys / Finastra — financial platforms, modernization and integration

This was the period where I moved from fixing unfamiliar enterprise systems to owning substantial cross-product pieces.

I worked across a family of financial/risk products and services including **TopOffice, KGR, CMR, ALM and UserManagement**, plus the integration and dashboard layer around them.

### TopOffice

TopOffice was one of my first large commercial codebases: a heterogeneous C++ / Java EE system with enough history that debugging often meant reconstructing intent from behavior rather than starting from clean abstractions.

The useful lesson was not merely learning another enterprise stack. It was learning to work productively in a system I did not fully understand yet: reproduce the problem, find the smallest suspicious boundary, understand why it behaved that way, fix it without destabilizing the rest of the product, and gradually build a reliable mental model of the architecture.

That experience is also the background behind many of my public “engineering archaeology” repositories: I kept rebuilding small versions of build systems, dependency resolution and Java/runtime machinery because I wanted to understand what the production abstractions were actually doing underneath.

### CMR — persistence modernization and product work at the same time

One substantial modernization effort was moving CMR persistence away from an obsolete, unsupported **DataXtend ORM** layer toward **JPA**.

This was not a clean-room rewrite. The challenge was to change a foundational persistence mechanism while the product still had to keep moving: functional features, bug fixes, integrations and existing behavior all continued to matter.

That taught me a pattern I have reused many times since: modernize legacy systems incrementally, preserve contracts at the edges, and avoid turning an infrastructure improvement into an excuse to freeze product development.

### UserManagement — my first independently owned corporate subsystem

**UserManagement** was the first substantial corporate component I remember as distinctly “mine”.

Its job was to reconcile identity and authorization across products that had not originally been designed as one coherent platform. It mapped a shared user model, OpenID Connect/OAuth identity and permissions across systems such as **KGR, ALM and CMR**, including synchronization and consistency between product-specific representations.

Alongside it I built a reusable authentication library for legacy cases that still needed the old resource-owner style flow. The interesting constraint was language diversity:

- the shared core was implemented in **C**;
- **C++** consumed the same implementation directly;
- **Java** used it through a **JNI wrapper**;
- **Objective-C on GNUstep** could use the same core so the Almonde/ARC side of the product family did not need a separate implementation.

The point was not language cleverness. It was to keep one security-sensitive implementation and one configuration model instead of duplicating protocol behavior, contracts and fixes across several stacks.

### From legacy products to the platform that became FusionFabric

Over time the work moved outward from individual engines and services toward a configurable product assembled from them.

Legacy capabilities from systems such as CMR, KGR and ALM were wrapped behind **OpenAPI/REST contracts** and run together as a composed environment. Shared pieces such as **UserManagement**, identity, configuration and operational plumbing made those previously separate products behave like parts of one platform rather than a collection of unrelated applications.

The internal MVP/interface for that idea was **MisysBoard**. In practical terms it was already a platform prototype: a configurable UI over a Docker Compose-based assembly of legacy services, normalized behind APIs and tied together through common identity and configuration.

That work later evolved into the product/platform sold under the **FusionFabric** name. I therefore treat MisysBoard not as a separate dashboard project, but as an internal MVP on the path from a portfolio of legacy financial products to a configurable, API-driven platform.

The architectural progression was roughly:

```text
legacy financial products
        ↓
capabilities wrapped behind OpenAPI
        ↓
shared identity + configuration
        ↓
Docker Compose-based integrated environment
        ↓
MisysBoard internal MVP / configurable UI
        ↓
commercialized FusionFabric platform
```

This was one of the first times I saw — and helped build — the pattern of turning heterogeneous legacy systems into reusable capabilities behind stable contracts, then composing them into a new product without first rewriting everything underneath.

By the end, I was no longer thinking primarily in terms of “the C++ product” or “the Java product”. I was thinking about heterogeneous systems as capabilities that could be normalized, secured and composed into something new.

### Infrastructure transition

This period also exposed me to the operational side of platform modernization: from older internally hosted environments, Solaris-era infrastructure and SSH-heavy environment work toward a more standardized cloud/platform model, including the move toward **Microsoft Azure**.

That was an early lesson that architecture is not only code structure. Deployment topology, configuration, identity, environment parity and operational ownership shape what software can realistically become.

## Intel — hardware boundary, verification and internal tooling

At Intel I worked closer to the hardware/software boundary, around **NAND/storage-driver software** and automated verification.

A large part of the value for me was learning what production engineering looks like when software interacts with real hardware and timing/state assumptions cannot be hand-waved away. I also worked with internal test/tooling infrastructure and saw both sides of long-lived engineering platforms: how much leverage good internal tools create, and how expensive accumulated tooling debt becomes when many teams depend on it.

This period made lower-level failure modes much less abstract to me and reinforced the habit of treating test infrastructure as a product in its own right.

## Ciklum / EverC — MerchantView, production ownership and operations

At Ciklum / EverC I worked on **MerchantView**, part of a fraud/risk product environment, during a broader organizational transition from startup-style development toward a more structured corporate operating model.

The work mixed application development with stabilization and operational responsibility:

- product work in **Groovy/Grails**;
- production debugging and deep ownership rather than “throw it over the wall” delivery;
- **on-call** responsibility and direct babysitting of production when necessary;
- monitoring, **Grafana**, alerting and operational feedback loops;
- deployment/infrastructure work with **AWS, Terraform and Kubernetes**.

This was where “production is part of the system” became concrete. A feature was not done because the code compiled; it was done when it could be deployed, observed, diagnosed and kept healthy under real traffic and organizational change.

## Nordea — modular banking systems and organizational contracts

At Nordea I spent roughly a year on one concrete financing capability inside a much larger banking ecosystem, using **Java and Angular**.

The individual module was less important than the architecture and organizational model around it.

The system was assembled from many independently owned services and microfrontends. Teams did not need to share one implementation style everywhere; instead they needed explicit boundaries:

- clear contracts between modules;
- integration and quality gates;
- security and access boundaries;
- dependency coordination across teams;
- compatible release expectations;
- cross-team planning through a **Scrum-of-Scrums** style layer.

This was a useful counterweight to “standardize everything”. Large systems can scale organizationally when teams are allowed to differ internally but the boundaries between them are explicit and enforceable.

## Hapag-Lloyd — event-driven enterprise systems

At Hapag-Lloyd I worked on Java/Jakarta EE systems in the shipping/logistics domain, including event-driven integration and platform services around operational data.

The useful part of this period was seeing how asynchronous events, replicated/configuration state and independently evolving enterprise services behave in a large operational organization. It reinforced lessons from Nordea: distributed systems are as much about contracts, ownership and failure handling as they are about messaging technology.

## Południk — early web-product work

Earlier work at Południk included **PHP/web development**. I keep this part of the history short because the later systems are more representative of my current level, but it belongs in the timeline: it was part of the transition from smaller web applications into increasingly complex enterprise and systems work.

## Stynk — end-to-end product and system ownership

Stynk is where most of the earlier threads meet.

Instead of owning one bounded subsystem inside a large organization, I own the path from ambiguous business need to production behavior: requirements discovery, domain model, UX, architecture, Angular/Django implementation, testing, CI/CD, Linux/Docker infrastructure, deployment, support and product evolution.

See the dedicated **[Stynk CRM case study](CASE_STUDIES/STYNK_CRM.md)** for the detailed story.

## Cloud and platform progression

The cloud story is easier to understand as a progression across roles than as a keyword list:

```text
legacy on-prem / Solaris / SSH-managed environments
        ↓
Azure-era enterprise platform migration
        ↓
AWS + Terraform + Kubernetes + production observability
        ↓
current Docker/Linux operations + Google Cloud / AI platform experiments
```

Recent work includes Google Cloud services around document/AI experiments as well as local/self-hosted infrastructure for agentic workflows.

I do not treat “cloud” as a separate specialization detached from software design. What matters to me is the full boundary: application architecture, deployment model, identity, configuration, observability, failure recovery and the people who operate the result.

## What this progression taught me

The progression across these roles is roughly:

```text
fix a component
    ↓
own a subsystem
    ↓
modernize shared foundations
    ↓
integrate heterogeneous products
    ↓
operate production systems
    ↓
design around explicit team/system boundaries
    ↓
own product + architecture + implementation + operations end to end
```

That is the context behind my current interest in systems architecture and agentic engineering. The part I care about is not generating more code. It is making increasingly automated software delivery remain understandable, testable, operable and safe to evolve.
