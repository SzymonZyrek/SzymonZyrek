# Hobby projects & engineering archaeology

This is a loose archive of things I built because I was curious.

Some are useful little tools. Some are half-finished experiments. Some are old enough that I would solve the problem very differently today. I keep them because they are a fairly honest record of how I tend to learn: I run into something interesting, use it for a while, get curious about what is underneath, and often end up building a small version of the idea for myself.

I would not present these as products or as alternatives to mature frameworks. They are closer to notebooks made out of code.

A recurring pattern is that I like moving up and down abstraction layers until the pieces stop feeling magical:

```text
environment / runtime
        ↓
developer tooling
        ↓
builds and artifacts
        ↓
application/runtime mechanics
        ↓
events, state and concurrency
        ↓
ML/model lifecycle
        ↓
agent workflows and engineering process
```

That habit has stayed useful professionally: it helps me reason at a higher level without losing sight of what lower layers actually have to do.

## Early workstation and tooling experiments

### wallpaper-rotator
**Repository:** https://github.com/SzymonZyrek/wallpaper-rotator  
**Period:** August 2015

A Bash utility I wrote around the beginning of my professional career because I wanted my first corporate Linux workstation to feel a little more like my own machine.

It gradually grew CLI lifecycle commands, configuration, a daemon, PID handling, GNOME-version compatibility and desktop integration.

Mostly a tiny quality-of-life project, but also an early example of me turning a repeated annoyance into a reusable tool.

### java_installer
**Repository:** https://github.com/SzymonZyrek/java_installer  
**Period:** July 2015 onward

A portable JDK/JRE installer for unfamiliar development and support environments.

It discovered Oracle Java releases, matched versions/architecture, downloaded and unpacked runtimes, and could configure JAVA_HOME and alternatives.

The practical goal was simple: get a strange machine into a state where I could start investigating something useful.

### vimrc
**Repository:** https://github.com/SzymonZyrek/vimrc  
**Period:** 2015–2018

My old portable Vim environment.

It accumulated fuzzy navigation, file/project search, snippets, diagnostics, shell integration, Java/C++ helpers and Eclim-backed debugging.

For a while this was effectively my editor, IDE and remote-development setup rolled into one. It was less about minimalism than about being able to feel at home on almost any machine I SSHed into.

### devtools
**Repository:** https://github.com/SzymonZyrek/devtools  
**Period:** 2016–2017

A pragmatic bootstrap script for rebuilding that environment.

It tried to normalize package-manager differences, install/compile the tools I cared about, and compose smaller personal utilities into one repeatable setup.

Not configuration management in any serious sense; more like a personal "make this host sane enough to work on" button.

## Build systems, artifacts and dependency experiments

### just_build_poc
**Repository:** https://github.com/SzymonZyrek/just_build_poc  
**Period:** August 2015

An early Bash experiment inspired by Maven/CMake-style build tooling.

I liked conventions and dependency/build automation, but also wanted configuration to stay executable when needed, so the project settings were sourced Bash with lifecycle hooks.

It was a small experiment, but it already contained target types, source discovery, incremental compilation and a basic integration-style sanity check.

### justbuild
**Repository:** https://github.com/SzymonZyrek/justbuild  
**Period:** August–September 2015

A more ambitious rewrite in Java/Groovy.

The core was separated from toolchain-specific builders; builders could be loaded as plugins, project settings were executable Groovy, and build phases exchanged typed inputs/outputs before producing commands and artifacts.

This is one of those projects where the main value for me was discovering how quickly a "simple build tool" turns into questions about lifecycle, extensibility, dependency resolution and artifact identity.

### fetchdog
**Repository:** https://github.com/SzymonZyrek/fetchdog  
**Period:** June–July 2016

A configurable file/artifact fetching experiment.

A `Fetchable` described what was needed, while a `FetchProvider` described where/how to obtain it. The code explored provider fallback, uploads, caching, batch work, concurrency limits, versioned assets and native-library qualifiers.

The main question I was playing with was how much of an artifact's identity could be separated from its physical storage location.

### faxus
**Repository:** https://github.com/SzymonZyrek/faxus  
**Period:** 2016

The last substantial pass I found at the build/dependency problem before I mostly stopped trying to replace Maven.

By this point the experiment had moved beyond fetching files or wiring a builder to a dependency source. The code contains an explicit artifact model: `Artifact`, `ArtifactId`, `ArtifactDescriptor`, `ArtifactType`, `ArtifactQualifier` and a non-trivial `Version` model, plus language/platform-specific specializations for Java and C++.

The important idea was that an artifact should have a logical identity independent from where its bytes happen to live. Java and native artifacts could then add the dimensions that actually matter for compatibility: type, version, architecture, compiler/runtime family and similar qualifiers.

Around that model there are repository, cache and resolver abstractions, a local-filesystem resolver, REST resources for publishing/resolving artifacts, and tests for versioning, qualifiers, repository behavior and Java/C++ identifiers. The repository even keeps an older implementation under `legacy/`, so it visibly contains more than one attempt at finding the right model.

This looks like the furthest point of the early JustBuild → dependency → artifact-repository line of experiments. The “next big thing” was not another build command; it was trying to define a common semantic model for artifacts and let storage/resolution become interchangeable mechanisms underneath it.

It is still visibly experimental and unfinished. Around this point the practical value of simply using Maven and existing ecosystem tooling seems to have won over the urge to finish my own parallel ecosystem.

That is part of the learning record too: understanding an abstraction well enough can make the mature boring tool more attractive, not less.

## Later technical detours

### neural-networks-labs
**Repository:** https://github.com/SzymonZyrek/neural-networks-labs  
**Period:** 2024

A set of hands-on ML notebooks covering regression, gradient descent, trees, SVM, backpropagation, neural-network classification, sentiment analysis, transformers and object detection.

I used these mostly to rebuild intuition from lower-level mechanisms upward instead of treating model APIs as black boxes.

### hlcasestudy
**Repository:** https://github.com/SzymonZyrek/hlcasestudy  
**Period:** June 2024

A small recruitment exercise implemented with Jakarta EE / JAX-RS / JPA.

Spring Boot would have been the obvious choice. I used the task as an excuse to see what had changed in the Java EE/Jakarta ecosystem since I had last worked with it closely.

### querydsl fork
**Repository:** https://github.com/szyrek/querydsl  
**Period:** 2024

A focused Hapag-Lloyd QueryDSL fork/fix around generated class initialization, runtime behavior and compatibility.

The interesting part for me was the interaction between compile-time code generation and JVM/runtime initialization semantics rather than QueryDSL itself.

### MLFramework
**Repository:** https://github.com/SzymonZyrek/MLFramework  
**Period:** 2025

A small framework experiment around backend-independent model training and workflow orchestration.

It separates model backends behind a registry and uses declarative dataset/workflow configuration. Again, this was mostly me poking at where a useful abstraction boundary should sit rather than trying to create a general-purpose ML platform.

## Agent workflow experiments

Projects such as **CodexProject**, **CodexProjectTest1**, **Codex2** and later **HackaTeam** move the same curiosity one level outward.

Instead of only asking how code should be structured, I started asking how the work around code could be structured: context, ownership, task state, evidence, CI feedback, review, escalation and bounded autonomy for coding agents.

Those projects are much newer and still evolving, so I keep most of that material under my R&D account:

https://github.com/ateshgahofmine

## Why I keep this stuff public

Mostly because it is mine, it is old, and I like having it around.

It also gives a more useful picture of how I work than a polished list of technologies does.

I tend to learn by building a small model, testing it against reality, finding the parts I misunderstood, and then updating the model. After enough years, that makes it fairly natural to move between details and the bigger system without treating either side as magic.

It also taught me the opposite lesson: not every interesting abstraction needs to become a framework, not every bottleneck needs optimization, and sometimes the right design is simply the boring thing that is already good enough.
