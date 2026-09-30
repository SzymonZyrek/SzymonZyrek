# Project map

This is the wider map behind the shorter profile README.

The repositories are intentionally not presented as if every experiment were one polished product. Some are active systems, some are current R&D, and some are simply old hobby projects I still like having around.

For a chronological, less formal look at the older experiments, see **[HOBBY_PROJECTS.md](HOBBY_PROJECTS.md)**.

For employer-owned systems that cannot be represented by source repositories, see **[CAREER.md](CAREER.md)** for the product-level commercial engineering history.

## 1. Current / production-oriented work

### Stynk CRM
**Status:** active, proprietary, production system

Public source is intentionally unavailable. See the sanitized **[case study](CASE_STUDIES/STYNK_CRM.md)**, **[visual tour](CASE_STUDIES/stynk/visual-tour.md)** and **[discovery/evolution story](CASE_STUDIES/stynk/discovery.md)**.

The project is my strongest example of end-to-end ownership: requirements, business/domain modelling, architecture, UX, full-stack implementation, testing, CI/CD, infrastructure, deployments and support.

The [closing synthesis slide](CASE_STUDIES/assets/stynk/slides/stynk_case_study_summary.png) compresses the whole case into one visual.

### HackaTeam
**Repository:** https://github.com/ateshgahofmine/HackaTeam  
**Status:** active R&D

A GitHub-native, self-hosting agentic software-development loop. GitHub issues, pull requests, CI evidence and Git history are the durable coordination substrate; model providers and local/hosted executors are replaceable participants around that state.

Related map in the R&D account:  
https://github.com/ateshgahofmine/HackaTeam/blob/main/PROJECTS.md

### VibeGuard
**Status:** active private R&D / fresh Tech Owner PoC

VibeGuard started as a deliberately fast human-in-the-loop code-review/debugging experiment and evolved toward a broader question: how do you preserve real technical ownership when founders and agents can generate implementation faster than they can reliably understand the resulting system?

The current direction explores a **Tech Owner control loop**: explicit project policy, automated evidence, an Owner Inbox for material boundary crossings, and recorded human decisions around architecture, security, irreversible data choices and technical debt.

See the **[VibeGuard case study](CASE_STUDIES/VIBEGUARD.md)**, **[visual tour](CASE_STUDIES/vibeguard/visual-tour.md)**, [discovery/evolution](CASE_STUDIES/vibeguard/discovery.md), [Tech Owner model](CASE_STUDIES/vibeguard/ownership-model.md), [prototype boundary](CASE_STUDIES/vibeguard/prototype.md) and [external-evidence notes](CASE_STUDIES/vibeguard/evidence.md).

The implementation repository remains private while the product direction is still being explored. The portfolio explicitly distinguishes implemented prototype capabilities from the newer simulated Tech Owner interaction slice.

### github_manager
**Repository:** https://github.com/SzymonZyrek/github_manager

A deliberately small MCP server exposing explicit GitHub administration operations rather than a generic arbitrary REST escape hatch.

The interesting part is the capability boundary: make a tool powerful enough to be useful to agents while keeping the action surface understandable and auditable.

## 2. ML / neural-network work

### neural-networks-labs
**Repository:** https://github.com/SzymonZyrek/neural-networks-labs

Historical notebooks covering a range of direct ML work: NumPy/Pandas, regression, decision trees, SVM, gradient descent, backpropagation, neural-network classification, computer vision/object detection, sentiment analysis and early transformer/GPT-2 experiments.

### MLFramework
**Repository:** https://github.com/SzymonZyrek/MLFramework

A small framework experiment around reusable training infrastructure: model backend abstraction, scikit-learn and Keras/TensorFlow implementations, dataset configuration, model I/O and pipeline orchestration.

## 3. Agentic engineering R&D

A separate account, **[ateshgahofmine](https://github.com/ateshgahofmine)**, currently hosts much of the active experimental infrastructure so runner/Actions/integration plumbing can evolve without turning the professional profile into an operational control plane.

### Active / relevant

- **[HackaTeam](https://github.com/ateshgahofmine/HackaTeam)** — current primary agentic-development experiment.
- **Agent-Native Engineering System** — explicit goals/actions/evidence/validation; currently private.
- **Agent-Native Engineering Runtime — Draft Specification** — larger formal runtime/specification exploration; currently private.
- **Local Coding Agent** — local llama.cpp coding-agent loop; currently private.
- **AI Worker** — controlled Task/Action execution and authorization experiment; currently private.
- **VibeGuard** — Tech Owner / human technical-ownership experiment around AI-built software; currently private; [public case study](CASE_STUDIES/VIBEGUARD.md).
- **[CodexProject](https://github.com/ateshgahofmine/CodexProject)** and **[Codex2](https://github.com/ateshgahofmine/Codex2)** — historical documentation-driven predecessors.

These experiments are allowed to disagree with each other. Part of the fun is trying an idea, finding where it becomes awkward, and deleting machinery when ordinary tools already solve the problem better.

## 4. Older hobby projects

These are not maintained as current products. They are simply older things I built while learning, experimenting or trying to make my own work easier.

A useful way to read several of them is as one evolving investigation rather than unrelated toys: Java concurrency experiments led into a C++ translation attempt; C++ compilation/linking pain led into build automation; build automation exposed dependency and artifact-resolution concerns; those concerns became FetchDog and then Faxus. Meserve explored the same "go underneath the abstraction" habit on the application-runtime/container side.

That progression also overlapped with early commercial debugging in large Java EE/C++ systems, where learning to reconstruct unfamiliar mechanisms from failures, logs, stack traces, tests and debugger evidence became a practical skill rather than a purely academic exercise.

### Realtime / graphics / engine work
- **[game10](HOBBY_PROJECTS.md#game10-realtime-engine-and-rendering-sandbox)** — historical C++/OpenGL engine and rendering sandbox; a useful early lesson in frame budgets, data locality, ownership and the fact that architecture follows constraints. The original repository predates the current GitHub portfolio migration.

### Concurrency and events
- [java_events](https://github.com/SzymonZyrek/java_events)
- [cpp_events](https://github.com/SzymonZyrek/cpp_events)

### Build systems and artifact resolution
- [just_build_poc](https://github.com/SzymonZyrek/just_build_poc)
- [justbuild](https://github.com/SzymonZyrek/justbuild)
- [fetchdog](https://github.com/SzymonZyrek/fetchdog)
- [faxus](https://github.com/SzymonZyrek/faxus)

### Application runtime / framework internals
- [meserve](https://github.com/SzymonZyrek/meserve)

### Desktop / utility work
- [roy_batty](https://github.com/SzymonZyrek/roy_batty)
- [wallpaper-rotator](https://github.com/SzymonZyrek/wallpaper-rotator)

### Workstation/tooling archive
- [devtools](https://github.com/SzymonZyrek/devtools)
- [install_util](https://github.com/SzymonZyrek/install_util)
- [java_installer](https://github.com/SzymonZyrek/java_installer)
- [bashrc](https://github.com/SzymonZyrek/bashrc)
- [vimrc](https://github.com/SzymonZyrek/vimrc)

The longer notes in [HOBBY_PROJECTS.md](HOBBY_PROJECTS.md) explain why some of these existed and what I was curious about at the time.

## 5. Java/Jakarta case study

### hlcasestudy
**Repository:** https://github.com/SzymonZyrek/hlcasestudy

A compact Jakarta EE / JAX-RS / JPA case study implementing validated CRUD and pagination for user accounts, packaged as a WAR for WildFly.

It is intentionally small and useful mainly as a public sample of straightforward enterprise-Java mechanics.

## 6. What is intentionally absent

A public GitHub account cannot show most of the code written during long stretches of commercial work.

Systems built at Intel, Finastra, EverC, Nordea and Hapag-Lloyd are employer-owned. Stynk CRM is a current proprietary client/product system.

Where source cannot be shown, I prefer a clearly labelled case study over synthetic code written after the fact to imitate the original work.
