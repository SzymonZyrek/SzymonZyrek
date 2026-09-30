# Stynk CRM — visual tour

[← Case study overview](../STYNK_CRM.md) · [Discovery](discovery.md) · [Product & domain](product-domain.md) · [Model & runtime](model-runtime.md) · [Engineering system](engineering-system.md) · [Visual tour](visual-tour.md)

This is the shortest visual path through the project. The JPEG slides combine real/sanitized product screenshots with the system story; the SVG diagrams isolate architectural mechanisms.

## Product & domain

### From field work to production data

![From field work to production data](../assets/stynk/slides/product/01-field-work-to-production-data.jpg)

### Contract & Job lifecycle

![Contract & Job lifecycle](../assets/stynk/slides/product/02-contract-job-lifecycle.jpg)

### Notifications & role communication

![Notifications and role communication](../assets/stynk/slides/product/03-notifications-role-communication.jpg)

### Financial lifecycle

![Financial lifecycle](../assets/stynk/slides/product/04-financial-lifecycle-obligations.jpg)

### Planning, capacity & field execution

![Planning and field execution](../assets/stynk/slides/product/05-planning-capacity-field-execution.jpg)

### Website ↔ CRM sales loop

![Website to CRM sales loop](../assets/stynk/slides/product/06-website-crm-sales-loop.jpg)

### Operational photos → public realizations

![Operational photos to public realizations](../assets/stynk/slides/product/07-operational-photos-public-realizations.jpg)

### OCR with human review

![OCR human review](../assets/stynk/slides/product/08-ocr-human-review.jpg)

[Read the product/domain deep dive →](product-domain.md)

---

## Model & runtime

### Model business concepts directly

![Studio business language](../assets/stynk/slides/model-runtime/01-studio-business-language.jpg)

### One authoring language, one deterministic runtime

![Studio authoring runtime](../assets/stynk/slides/model-runtime/02-studio-authoring-runtime.jpg)

### Architecture companions

![Platform kernel and Stynk bindings](../assets/stynk/diagrams/04-platform-system-boundary.svg)

![Capability-based pricing](../assets/stynk/diagrams/05-capability-pricing.svg)

![Versioned, explainable pricing](../assets/stynk/diagrams/06-versioned-pricing.svg)

[Read the model/runtime deep dive →](model-runtime.md)

---

## Engineering system

### Quality gates from domain rules to a real browser

![Quality gates](../assets/stynk/slides/engineering/01-quality-gates.jpg)

### Selective CI as a feedback loop

![Selective CI](../assets/stynk/slides/engineering/02-selective-ci.jpg)

### Deployment sized to the operating model, portable by construction

![Deployment portability](../assets/stynk/slides/engineering/03-deployment-portability.jpg)

### Operational resilience & recovery

![Resilience and disaster recovery](../assets/stynk/slides/engineering/04-resilience-disaster-recovery.jpg)

### Permissions, audit & governance

![Permissions and governance](../assets/stynk/slides/engineering/05-permissions-audit-governance.jpg)

### Architecture companions

![One coherent business core](../assets/stynk/diagrams/01-business-core.svg)

![Durable async execution](../assets/stynk/diagrams/03-durable-async.svg)

![Public/private trust boundary](../assets/stynk/diagrams/07-public-private-boundary.svg)

[Read the engineering-system deep dive →](engineering-system.md)

---

## How it got here

The visual set shows the current system. The discovery deep dive shows why those concepts exist at all: the sequence from contract capture to workflow, lifecycle, configurable Jobs/pricing, canonical runtime and Studio.

[Read discovery & evolution →](discovery.md)
