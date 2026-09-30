# Szymon Żyrek

**Software / Systems Architect · Senior Software Engineer**

**[CV / Resume (PDF)](Szymon_Zyrek_CV.pdf)** · **Email:** [stynkdev@gmail.com](mailto:stynkdev@gmail.com) · [szyrek@stynk.eu](mailto:szyrek@stynk.eu)

I like systems where the interesting work does not stop at the framework boundary.

I have 12+ years of professional software-engineering experience spanning embedded/storage software, financial systems, fraud-detection products, banking, shipping, full-stack web systems, infrastructure/operations and, more recently, agentic software-engineering workflows.

A recurring theme in my work is moving between abstraction levels:

```text
requirements
   ↓
domain model
   ↓
architecture
   ↓
implementation
   ↓
verification
   ↓
deployment / operations
```

## Current work

| Project | What it is | My focus |
|---|---|---|
| **[Stynk CRM — case study](CASE_STUDIES/STYNK_CRM.md)** | Proprietary CRM/ERP-style platform used by a construction company | End-to-end ownership: requirements, domain, UX, Angular/Django implementation, CI/CD, deployment, operations and support |
| **[HackaTeam](https://github.com/ateshgahofmine/HackaTeam)** | GitHub-native, self-hosting agentic software-development loop | Workflow architecture, evaluation, agent coordination, local/hosted execution and aggressive simplification |
| **[VibeGuard — case study](CASE_STUDIES/VIBEGUARD.md)** | Tech Owner control-loop PoC for AI-built software | Human technical ownership above agent execution: architecture/security sanity, evidence compression, escalation and decision memory; private R&D prototype |
| **[github_manager](https://github.com/SzymonZyrek/github_manager)** | Explicit MCP server for narrowly scoped GitHub administration capabilities | MCP/tool design, capability boundaries, TypeScript, Docker and CI |

Some active experimental infrastructure still lives under my R&D account, **[ateshgahofmine](https://github.com/ateshgahofmine)**, where runners and agent workflows can evolve without turning this professional profile into an operational control plane.

See **[PROJECTS.md](PROJECTS.md)** for the wider project map.

## ML / neural-network work

I did not arrive at AI through chat interfaces alone.

**[neural-networks-labs](https://github.com/SzymonZyrek/neural-networks-labs)** preserves hands-on experiments with regression/classification, gradient descent, backpropagation, CIFAR classification, object detection, TensorFlow/Detecto workflows, sentiment analysis and early Hugging Face/GPT-2 work.

**[MLFramework](https://github.com/SzymonZyrek/MLFramework)** moves one level outward: model-backend abstraction, scikit-learn and Keras/TensorFlow training, dataset configuration, model packaging and orchestration.

## Hobby projects / engineering archaeology

I have kept a fair amount of old code public: tiny utilities, half-finished frameworks, build-system experiments, editor configs and other things I built mostly because I was curious.

I do not treat them as a portfolio of finished products. They are more useful as a record of how I learn — usually by rebuilding a small version of something until I understand which parts are essential, which are accidental complexity, and where the abstraction starts leaking.

If that sounds interesting, I wrote up the timeline in **[HOBBY_PROJECTS.md](HOBBY_PROJECTS.md)**.

## Commercial work

A large part of my professional code is not public because it was written in employer- or client-owned repositories. The short version below is deliberately product-oriented; **[CAREER.md](CAREER.md)** contains the fuller engineering history.

- **Misys / Finastra** — TopOffice, KGR, CMR, ALM and UserManagement; DataXtend→JPA modernization; shared identity/OIDC across C++, Java and Objective-C/GNUstep; OpenAPI-wrapped legacy capabilities composed into the Docker-based MisysBoard MVP that evolved into the FusionFabric platform.
- **Intel** — NAND/storage-driver software, automated verification and internal engineering tooling close to the hardware boundary.
- **Ciklum / EverC** — MerchantView fraud/risk product work, stabilization during organizational transition, AWS/Terraform/Kubernetes delivery, Grafana/alerting and hands-on on-call production ownership.
- **Nordea** — Java/Angular financing capability inside a larger microservice/microfrontend banking ecosystem; explicit contracts, quality/security gates and cross-team dependency coordination.
- **Hapag-Lloyd** — Java/Jakarta EE, event-driven shipping/logistics systems and platform/integration services.
- **Stynk** — current end-to-end product/system ownership from requirements and UX through implementation, CI/CD, deployment and operations.

Across those roles the infrastructure story moved from legacy on-prem/Solaris and SSH-managed environments, through Azure and AWS/Kubernetes, to current Docker/Linux operations and Google Cloud/AI-platform experiments.

So this GitHub profile is best read as a mix of **public engineering history, selected experiments and current R&D**, not as a complete chronological record of employment.

## Technologies I have worked with

Java / Jakarta EE / Spring · C / C++ · Objective-C / GNUstep · Python / Django · TypeScript / Angular / React · Groovy / Grails · SQL / PostgreSQL · JPA · JNI · OpenAPI / REST · OAuth / OIDC · Docker · Kubernetes · Terraform · Linux · Azure · AWS · Google Cloud · GitHub Actions · event-driven systems · MCP · local LLM tooling / llama.cpp

---

I am most interested in roles where architecture is still connected to implementation: enough abstraction to design the system, enough proximity to code and operations to know whether the design survives contact with reality.
