# Szymon Żyrek

**Software / Systems Architect · Senior Software Engineer**

I like systems where the interesting work does not stop at the framework boundary.

My background spans embedded/storage software, financial systems, fraud-detection products, banking, shipping, full-stack web systems, ML experiments, infrastructure/operations and, more recently, agentic software-engineering workflows.

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
| **VibeGuard** | Human-in-the-loop code review/debugging prototype for AI-assisted development | GitHub inspection, AI audit, diff/review UX and human escalation; currently private while evolving |
| **[github_manager](https://github.com/SzymonZyrek/github_manager)** | Explicit MCP server for narrowly scoped GitHub administration capabilities | MCP/tool design, capability boundaries, TypeScript, Docker and CI |

See **[PROJECTS.md](PROJECTS.md)** for the wider project map, including older R&D and historical engineering labs.

## ML / neural-network work

I did not arrive at AI through chat interfaces alone.

**[neural-networks-labs](https://github.com/SzymonZyrek/neural-networks-labs)** preserves hands-on experiments with regression/classification, gradient descent, backpropagation, CIFAR classification, object detection, TensorFlow/Detecto workflows, sentiment analysis and early Hugging Face/GPT-2 work.

**[MLFramework](https://github.com/SzymonZyrek/MLFramework)** moves one level outward: model-backend abstraction, scikit-learn and Keras/TensorFlow training, dataset configuration, model packaging and orchestration.

The current agentic work is therefore a continuation of a broader systems/ML path rather than my first contact with models.

## Engineering archaeology

I keep older learning projects public instead of rewriting history into a collection of freshly generated demos.

A few of them form a useful chain:

```text
java_events
    ↓
cpp_events
    ↓
just_build_poc → justbuild
                     ↓
                  FetchDog
                     ↓
                   Faxus

meserve ── application runtime / metadata / class loading / events / HTTP
```

- **[java_events](https://github.com/SzymonZyrek/java_events)** — concurrency and asynchronous event dispatch in Java.
- **[cpp_events](https://github.com/SzymonZyrek/cpp_events)** — rebuilding familiar ideas in C++, then discovering toolchain/build-system boundaries.
- **[just_build_poc](https://github.com/SzymonZyrek/just_build_poc)** / **[justbuild](https://github.com/SzymonZyrek/justbuild)** — learning what a build system actually has to model.
- **[fetchdog](https://github.com/SzymonZyrek/fetchdog)** / **[faxus](https://github.com/SzymonZyrek/faxus)** — artifact identity, qualifiers, providers and resolution.
- **[meserve](https://github.com/SzymonZyrek/meserve)** — reconstructing pieces of an application runtime: metadata, configuration, annotation processing, class loading, lifecycle, events and HTTP serving.
- **[roy_batty](https://github.com/SzymonZyrek/roy_batty)** — desktop keyboard/mouse macro recording and hotkey automation.

These repositories are not meant to compete with mature frameworks. They document a learning method I still use: rebuild a small version of an abstraction, let reality break the model, then return to the established tool with better questions.

## Commercial work

A large part of my professional code is not public because it was written in employer- or client-owned repositories.

My commercial path includes work on:

- **Intel** — NAND/storage-driver work and automated testing;
- **Misys / Finastra** — financial risk systems, Java EE/C++, integrations and production debugging;
- **Ciklum / EverC** — fraud-detection product work and operational ownership;
- **Nordea** — banking microservices/microfrontends and integration work;
- **Hapag-Lloyd** — event-driven shipping/container-tracking and platform services;
- **Stynk** — current end-to-end product/system ownership.

So this GitHub profile is best read as a mix of **public engineering history, selected experiments and current R&D**, not as a complete chronological record of employment.

## Technologies I have worked with

Java / Jakarta EE / Spring · C / C++ · Python / Django · TypeScript / Angular / React · Groovy / Grails · SQL / PostgreSQL · Docker · Linux · GitHub Actions · REST / event-driven systems · MCP · local LLM tooling / llama.cpp

---

I am most interested in roles where architecture is still connected to implementation: enough abstraction to design the system, enough proximity to code and operations to know whether the design survives contact with reality.
