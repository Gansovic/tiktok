---
name: metrics
description: Clips mode stage 3. Records the numbers Luka reads from TikTok Studio for posted clips into clips/metrics.csv and reports what they say (ES vs EN, hooks, layouts). Does not scrape TikTok.
argument-hint: [slug]
---

# /metrics [slug]

Goal: every posted clip has one row with its 24 h numbers and its 72 h views, and the numbers decide what we clip next.

## Steps

1. List clips with `Posted:` filled in `clips/*/clip.md` and compare with `clips/metrics.csv`: which
   have no row yet (24 h numbers), which have no `views_72h`.
2. Ask Luka for exactly the missing numbers, one clip per line (views, % still watching at 3 s from
   the retention curve, average watch seconds, % watched in full, shares, new followers, % For You, % Search). He reads them from TikTok Studio.
   Leave a cell empty rather than guess.
3. Update `clips/metrics.csv` (one row per clip; header stays as is).
4. Report, in at most 12 lines: median views per clip by series, best and worst clip with the one
   variable that differs (hook, layout, creator, length), A/B pairs with their result, and one
   concrete change for tomorrow. With fewer than 5 clips per series, say the sample is too small to
   decide.
5. From 2026-11-25, add the language call from the playbook (70 % of the time to the series that
   wins on median views, 3 s retention and full-watch). **And stop.**

## Rules
- Numbers come from Luka. No scraping, no logins, no third-party analytics without an ADR.
- A rule that the numbers keep confirming goes to `docs/clips/playbook.md`, replacing a (v) figure.
