---
layout: layout.njk
title: Edge issue #49 verification checklist
permalink: "edge/verification-checklist/index.html"
---

Use this checklist after making changes related to issue #49.

### Quick automated check

From the repository root:

```bash
./scripts/verify-edge-policy-order.sh
```

Expected result: script exits with code `0` and prints a `PASS` message.

### Manual verification (Windows)

1. Ensure Edge is closed.
2. Import `edge/install-base.reg`.
3. Import `edge/install-search.reg`.
4. Start Edge and open `edge://policy/`.
5. Confirm at least these values are applied:
   - `AutoImportAtFirstRun = 4`
   - `DefaultBrowserSettingsCampaignEnabled = 0`
   - `NewTabPageSearchBox = redirect`
6. Open `edge://settings/search` and verify your default search engine was not replaced.
7. Search from the address bar and verify requests go to the expected engine.

### Regression checks

- Run `npm run bundle` from the repository root to ensure the site still builds.
- Revisit the [reproduction matrix](reproduction-matrix.md) and update observed results when testing new Edge versions.
