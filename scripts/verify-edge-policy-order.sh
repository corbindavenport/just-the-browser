#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE_REG="$ROOT_DIR/edge/install-base.reg"
SEARCH_REG="$ROOT_DIR/edge/install-search.reg"
PS1_FILE="$ROOT_DIR/main.ps1"

echo "Verifying Edge policy split files..."
test -f "$BASE_REG"
test -f "$SEARCH_REG"

echo "Checking base file contains campaign/search-protection policies..."
grep -q '"DefaultBrowserSettingsCampaignEnabled"=dword:00000000' "$BASE_REG"
grep -q '"AutoImportAtFirstRun"=dword:00000004' "$BASE_REG"

echo "Checking search file only applies the search box redirect policy..."
grep -q '"NewTabPageSearchBox"="redirect"' "$SEARCH_REG"
if grep -q '"DefaultBrowserSettingsCampaignEnabled"' "$SEARCH_REG"; then
  echo "ERROR: install-search.reg should not include DefaultBrowserSettingsCampaignEnabled"
  exit 1
fi

echo "Checking PowerShell install order..."
base_line="$(grep -n 'edge-base.reg' "$PS1_FILE" | head -n1 | cut -d: -f1)"
search_line="$(grep -n 'edge-search.reg' "$PS1_FILE" | head -n1 | cut -d: -f1)"
if [[ -z "${base_line}" || -z "${search_line}" ]]; then
  echo "ERROR: could not locate Edge import lines in main.ps1"
  exit 1
fi
if (( base_line >= search_line )); then
  echo "ERROR: base import must appear before search import in main.ps1"
  exit 1
fi

echo "PASS: Edge policy split and install order are correct."
