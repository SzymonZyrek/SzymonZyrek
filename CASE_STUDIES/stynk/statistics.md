# Stynk CRM — scale & production facts

[← Case study overview](../STYNK_CRM.md) · [Discovery & evolution](discovery.md) · [Product & domain](product-domain.md) · [Model & runtime](model-runtime.md) · [Engineering system](engineering-system.md)

This page is the deliberately quantitative companion to the Stynk CRM case study.

The rest of the case study explains *why* the system evolved the way it did. This page answers a simpler question:

> **How large and real is the thing?**

The numbers below intentionally distinguish **repository-derived measurements** from **operator-verified production facts**. The implementation repository is private, so the public case study cannot link directly to proprietary source, but the figures can be demonstrated from the repository and production environment during an interview.

## At a glance

| | |
|---|---|
| **Human technical ownership** | **1** technical owner across discovery, architecture, UX, implementation, deployment and production support |
| **Production status** | Live production system used in day-to-day company operations |
| **Operational users** | Approximately **20+** business users across Office, Sales and field/subcontractor workflows |
| **Primary application roles** | **4** — Admin, Office, Sales Rep, Subcontractor |
| **Repository history** | **2,069** commits reachable from the measured `develop` snapshot |
| **Pull requests** | **334** total / **263 merged** at the time of measurement |
| **Tracked files** | **2,118** |
| **Source-like files** | **1,732** Python / TypeScript / HTML / SCSS / JS / shell files |
| **Test/spec/E2E-like files** | **450** |
| **Backend application packages** | **18** Django domain/support apps |
| **Database migrations** | **114** |
| **Documentation** | **309** tracked files under `doc/`; **275** Markdown files repository-wide |
| **Curated Browser E2E catalog** | **41** product-capability targets; **35** mapped to **8** active browser modules |
| **Deployment shape** | Angular + Django/DRF + PostgreSQL + Redis/Celery + nginx, deployed with Docker Compose on Linux |

These are deliberately not presented as productivity KPIs. Commit counts, file counts and test counts do not measure software quality. They are useful here only to establish the scale of the system behind the architectural story.

---

## Repository snapshot

The repository-derived figures on this page were measured against:

```text
private repository: stynk_crm
branch:             develop
source snapshot:    b15c8eb12053fc0bb4b887bbc38bac01f66f06f5
snapshot date:      2026-09-24
statistics review:  2026-09-30
repository init:    2025-11-30
```

The Git tree for that snapshot is complete rather than truncated by the GitHub API.

### Code / file shape

| Surface | Snapshot count |
|---|---:|
| Tracked files | 2,118 |
| Source-like files | 1,732 |
| Python files under backend | 603 |
| TypeScript files under CRM frontend | 702 |
| HTML files | 196 |
| SCSS files | 170 |
| Markdown files | 275 |
| Files under `doc/` | 309 |
| Django migrations | 114 |

"Source-like" here means tracked files ending in `.py`, `.ts`, `.html`, `.scss`, `.js`, `.mjs` or `.sh`. It is a reproducible file-shape metric, not an inflated "lines of code" estimate.

The public `stynk.eu` website is pinned from the CRM repository as a separate Git repository, so its source is **not** included in the counts above.

### Backend shape

The measured backend contains 18 first-level Django application packages:

```text
analytics       attachments      authentication   background
blog            clients          common           contractors
contracts       core             datastores       hello
inquiries       notifications    ocr              pricing
public_content  sales
```

They are not eighteen independently deployed services. The architecture intentionally keeps business transactions inside one modular Django/PostgreSQL core while slow or external work leaves through explicit asynchronous boundaries.

### Change history

At the measured `develop` snapshot:

- **2,069 commits** are reachable from `develop`;
- history runs back to repository initialization on **30 November 2025**;
- repository-wide GitHub activity contained **334 pull requests**;
- **263 pull requests** had been merged;
- **6 pull requests** were open at the statistics-review point;
- the issue tracker contained **84 issues**, of which **72** were closed and **12** open.

The high PR/commit volume is partly a consequence of deliberately making engineering work observable in GitHub. Human work and coding-agent work both flow through branches, PRs, checks and review evidence rather than being hidden in one local working tree.

---

## Verification surface

Counting test cases across Python parametrization, Angular/Vitest specs and generated cases is surprisingly easy to make misleading, so this page uses the more stable repository-level measure:

> **450 tracked files are test-, spec- or E2E-shaped in the measured snapshot.**

That includes backend test modules, frontend `.spec.ts` files and repository-defined E2E material.

The verification system is layered:

```text
domain/data invariants
        ↓
backend/API tests
        ↓
frontend component/service tests
        ↓
build / security / operations checks
        ↓
browser E2E capability evidence
        ↓
staging / production feedback
```

The main CI workflow publishes backend/frontend coverage artifacts and test-failure summaries into pull requests. A separate advisory workflow tracks browser-level capability coverage.

### Browser capability catalog

The repository contains an explicit product-capability denominator for browser E2E work:

| Measure | Snapshot |
|---|---:|
| Curated capability targets | 41 |
| Active browser modules | 8 |
| Capabilities mapped to active modules | 35 / 41 |
| Raw testable coverage | 85.4% |
| Weighted testable coverage | 85.0% |

This is intentionally **capability coverage**, not line coverage. Known gaps remain in the denominator instead of disappearing merely because no test currently covers them.

---

## Production reality

The repository statistics above are machine-derived.

The following are **operator-verified facts** from running the system in the company. They are included because the most important distinction in this project is not whether the repository is large; it is that the software is used for real operational work.

### One human technical owner

Stynk has had **one human technical owner** responsible for the software system end to end:

- requirements discovery with the company;
- product and UX design;
- domain modelling;
- architecture;
- backend and frontend implementation;
- infrastructure and deployment;
- database migrations and recovery planning;
- production debugging and support;
- engineering-process design and agent coordination.

This does **not** mean every current commit is manually typed by one person.

As the repository grew, coding agents became execution/review participants. They work inside the same documentation, issue, branch, PR, CI and browser-evidence system. Human technical ownership remains at the level that matters: deciding what the system means, accepting or rejecting changes, operating it and being responsible when it meets reality.

### Real users, not demo personas

The production system supports four primary application roles:

```text
Admin
Office
Sales Rep
Subcontractor
```

It is used by approximately **20+ business users**, including a field-sales group of roughly fifteen people, office users and a changing set of subcontractors/field users involved in daily execution.

The workflows described in the case study — contract intake, Jobs, scheduling, files, payments, commissions, notifications and audit — are therefore not synthetic portfolio scenarios. They are projections of work the company actually performs.

### Live production operation

The system is deployed and used in production rather than being a staged portfolio replica.

Operationally, the project has so far avoided the class of incidents that usually dominates small-business custom software:

- no known critical production incident to date;
- no known production data-loss event;
- no emergency architectural rewrite caused by an operational failure;
- deployments are performed with backups, staging/preflight checks and rollback paths;
- production issues found through use are fed back into the same requirements → implementation → verification loop described elsewhere in the case study.

Historically observed availability has been approximately **99.97%**. That is an operator-maintained figure rather than a number recomputed from an independent public monitoring service for this page, so it should be read as operational context rather than an externally audited SLA.

The more important claim is simpler and directly demonstrable:

> **The system is live, people rely on it for work, it is still evolving quickly, and one technical owner has been able to change it without destabilizing the business.**

---

## Why the numbers matter

The interesting number is not the commit count or the file count in isolation.

The combination is what gives the project context:

```text
one human technical owner
        +
real production users
        +
2k+ commits of accumulated change
        +
hundreds of PRs
        +
a four-role operational domain
        +
hundreds of test/spec/E2E files
        +
continuous architectural migration
        ↓
a system that can still be changed deliberately
without requiring the business to stop
```

That is the engineering problem Stynk eventually became.

The original request was effectively:

> make it possible to enter a paper contract into a computer.

The current system is much larger, but the production constraint never changed: **the abstractions are useful only if normal company work keeps functioning while the system evolves.**

---

## Measurement notes

These statistics are intentionally conservative.

- Repository counts come from the private CRM Git tree and GitHub history/search data.
- The website is a separate pinned repository and is excluded from CRM source-file counts.
- Generated dependencies such as `node_modules` or Python virtual environments are not part of the tracked-file counts.
- "Test/spec/E2E-like files" is a path/file-shape count, not a claim that every file represents one runtime test.
- Historical CI reports contain individual runtime test/coverage measurements, but those become stale quickly in an actively changing repository and are therefore not used as headline statistics here.
- Production/user/ownership facts are operational claims supplied by the system's technical owner and can be demonstrated/discussed in an interview; they are not inferred from commit authorship.
- Statistics will naturally drift as the active repository continues to change.

The purpose of this page is not to turn software engineering into numerology. It is to give the qualitative case study a measurable physical scale.
