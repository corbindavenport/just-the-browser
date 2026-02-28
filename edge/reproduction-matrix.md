---
layout: layout.njk
title: Edge issue #49 reproduction matrix
permalink: "edge/reproduction-matrix/index.html"
---

This matrix tracks reproducibility for issue #49 (default search engine being reset/overridden in Microsoft Edge).

### Test prerequisites

- Windows user profile with at least one non-Bing default search engine configured in Edge.
- No enterprise policy manager (Intune/GPO) setting additional Edge search policies.
- Fresh browser restart after each policy import.

### Reproduction steps

1. Set a non-Bing search engine as default in Edge settings.
2. Apply the Just the Browser Edge policy file(s).
3. Restart Edge.
4. Check the default search engine in `edge://settings/search` and verify searches from the address bar.

### Matrix

| Windows version | Edge channel | Edge version | Install method | Expected result | Observed result |
| --- | --- | --- | --- | --- | --- |
| Windows 10 22H2 | Stable | 133.x | Single import (`install.reg`) | Default search engine remains unchanged | Intermittent override to Bing reported |
| Windows 10 22H2 | Beta | 134.x | Single import (`install.reg`) | Default search engine remains unchanged | Intermittent override to Bing reported |
| Windows 11 23H2 | Stable | 133.x | Single import (`install.reg`) | Default search engine remains unchanged | Intermittent override to Bing reported |
| Windows 11 24H2 | Stable | 133.x | Single import (`install.reg`) | Default search engine remains unchanged | Intermittent override to Bing reported |
| Windows 11 24H2 | Dev | 134.x | Single import (`install.reg`) | Default search engine remains unchanged | Intermittent override to Bing reported |
| Windows 10 22H2 | Stable | 133.x | Two-phase import (`install-base.reg` then `install-search.reg`) | Default search engine remains unchanged | No override observed |
| Windows 11 24H2 | Stable | 133.x | Two-phase import (`install-base.reg` then `install-search.reg`) | Default search engine remains unchanged | No override observed |

### Notes

- The issue appears timing/order sensitive on Windows when all policies are imported in one pass.
- The two-phase import order is the current workaround in this repository.
- Re-test this matrix when major Edge versions change.
