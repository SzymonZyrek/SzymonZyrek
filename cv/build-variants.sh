#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for tool in weasyprint gs pdfinfo pdftotext; do
  command -v "$tool" >/dev/null || { echo "Missing dependency: $tool" >&2; exit 1; }
done
for variant in Senior Agentic; do
  source="$ROOT/cv/Szymon_Zyrek_CV_${variant}.html"
  output="$ROOT/Szymon_Zyrek_CV_${variant}.pdf"
  raw="$(mktemp --suffix=.pdf)"
  trap 'rm -f "$raw"' EXIT
  echo "Rendering $variant CV..."
  weasyprint "$source" "$raw"
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dPDFSETTINGS=/prepress \
    -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages=true \
    -dCompressFonts=true -sOutputFile="$output" "$raw"
  pages="$(pdfinfo "$output" | awk '/^Pages:/ {print $2}')"
  if [[ "$pages" != "2" ]]; then
    echo "$variant CV should have 2 pages, got $pages" >&2
    exit 1
  fi
  textfile="$(mktemp)"
  pdftotext "$output" "$textfile"
  if [[ "$variant" == "Senior" ]]; then
    for needle in "Senior Full-stack" "Finastra" "Nordea" "Stynk" "Kafka" "Spring Boot" "Oracle" "SQL Server" "Mockito" "Playwright"; do
      grep -qi "$needle" "$textfile" || { echo "Missing text: $needle" >&2; exit 1; }
    done
  else
    for needle in "AI Platform" "RepoGraph" "VibeGuard" "HackaTeam" "Finastra" "Kafka" "Spring Boot" "Oracle"; do
      grep -qi "$needle" "$textfile" || { echo "Missing text: $needle" >&2; exit 1; }
    done
  fi
  rm -f "$raw" "$textfile"
  trap - EXIT
  echo "Built: $output ($pages pages)"
done
