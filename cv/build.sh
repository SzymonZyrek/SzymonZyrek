#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$ROOT/cv/Szymon_Zyrek_CV.html"
OUTPUT="$ROOT/Szymon_Zyrek_CV.pdf"
RAW="${TMPDIR:-/tmp}/Szymon_Zyrek_CV.raw.pdf"

command -v weasyprint >/dev/null || { echo "Missing dependency: weasyprint" >&2; exit 1; }
command -v gs >/dev/null || { echo "Missing dependency: ghostscript" >&2; exit 1; }
command -v pdfinfo >/dev/null || { echo "Missing dependency: poppler-utils (pdfinfo)" >&2; exit 1; }
command -v pdftotext >/dev/null || { echo "Missing dependency: poppler-utils (pdftotext)" >&2; exit 1; }

echo "Rendering CV..."
weasyprint "$SOURCE" "$RAW"

echo "Optimizing PDF..."
gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.7 \
   -dPDFSETTINGS=/prepress \
   -dNOPAUSE -dQUIET -dBATCH \
   -dDetectDuplicateImages=true \
   -dCompressFonts=true \
   -sOutputFile="$OUTPUT" "$RAW"

pages="$(pdfinfo "$OUTPUT" | awk '/^Pages:/ {print $2}')"
if [[ "$pages" != "2" ]]; then
  echo "Expected a 2-page CV, got $pages pages." >&2
  exit 1
fi

if ! pdftotext "$OUTPUT" - | grep -qi "software / systems architect"; then
  echo "Searchable text sanity check failed." >&2
  exit 1
fi

echo "Built: $OUTPUT ($pages pages)"

# Render the two role-targeted CVs using the same HTML/CSS → WeasyPrint → Ghostscript pipeline.
bash "$ROOT/cv/build-variants.sh"
