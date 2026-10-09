# CV source

This directory contains the editable source for the PDF linked from the profile README.

## Source of truth

- `Szymon_Zyrek_CV.html` — semantic document content and structure
- `styles.css` — visual language and print layout
- `build.sh` — deterministic render + validation entry point
- `requirements.txt` — pinned Python renderer dependency

The root-level `Szymon_Zyrek_CV.pdf` is a **generated artifact**. Do not edit it by hand.

## Visual grammar

The CV deliberately carries information in more than prose:

- chronology runs **oldest → newest** because the page is about accumulated engineering perspective;
- the vertical spine means **becoming by doing**, not merely employment history;
- each role/stage uses **Problem → Intervention → Evidence → Competence**;
- phase icons mean **discover · design · build · operate · evolve**;
- color tags are semantic scan aids, not ratings:
  - blue — systems / debugging / distributed concerns
  - green / teal — integration, business, operations, data
  - amber — assurance, security, governance, CI/CD
  - coral — identity / UX
  - purple — platform / AI / agentic work
  - gray — legacy context

The PDF should remain exactly two A4 pages, searchable/selectable, and link-rich.

## Build locally

System packages:

```bash
sudo apt-get install fonts-inter ghostscript poppler-utils
```

Python dependency:

```bash
python -m pip install -r cv/requirements.txt
```

Build and verify:

```bash
bash cv/build.sh
```

## CI

`.github/workflows/build-cv.yml` watches the CV source files. It installs the same dependencies, runs `cv/build.sh`, and commits the regenerated root PDF only when the artifact changed.

That keeps the public portfolio link stable:

```text
README.md
  └── Szymon_Zyrek_CV.pdf   # generated
          ↑
      cv/build.sh
          ↑
  HTML + CSS source
```

## Role-targeted variants

The original `cv/Szymon_Zyrek_CV.html`, `cv/styles.css` and root-level
`Szymon_Zyrek_CV.pdf` stay the canonical architecture/storytelling CV.

Two **additional**, reverse-chronological, recruiter-oriented sources live alongside it:

| Source | Generated PDF | Use |
| --- | --- | --- |
| `Szymon_Zyrek_CV_Senior.html` | `../Szymon_Zyrek_CV_Senior.pdf` | Senior Java / Angular / Full-stack / Backend |
| `Szymon_Zyrek_CV_Agentic.html` | `../Szymon_Zyrek_CV_Agentic.pdf` | Applied AI platform / coding-agent tooling |

Both sources use `styles.css` plus additive `variants.css`, Inter fonts,
WeasyPrint, Ghostscript optimization, poppler page-count checks and searchable-text
smoke tests. `bash cv/build.sh` renders and validates all three PDFs, each exactly
two A4 pages. The GitHub Actions workflow publishes the two **new** PDFs and deliberately
does not rewrite the original committed PDF.

No unsupported experience is introduced: R&D work is explicitly identified,
and the production Stynk project is kept distinct from agent-platform experiments.
