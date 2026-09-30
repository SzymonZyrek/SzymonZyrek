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
./cv/build.sh
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
