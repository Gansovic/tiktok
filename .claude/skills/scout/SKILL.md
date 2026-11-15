---
name: scout
description: Clips mode stage 1. Finds clip-worthy GTA 6 moments in a creator's public stream or video and lists them in clips/_inbox.md for Luka to pick. Downloads nothing and builds nothing.
argument-hint: <creator or URL> [gta6-es|gta6-en]
---

# /scout <creator or URL> [series]

Goal: 3–8 candidate moments with exact timecodes and a proposed hook, so Luka can pick in a minute.

## Steps

1. Read `docs/clips/playbook.md` and `docs/clips/creators.md`. A creator marked `no` is not scouted:
   say so and stop.
2. Find the source: the URL given, or the creator's latest GTA 6 VOD or video (WebFetch / WebSearch).
   Public pages only; no logins, no leak sites.
3. Find moments, strongest signal first: the platform's own top clips of that stream, chat spikes,
   chapter markers and comments with timestamps, then the transcript. Wide searches across several
   VODs go to a subagent (smaller model is fine: it is lookup).
4. For each candidate write one row in `clips/_inbox.md`: date found, series, creator, URL,
   `From–To` (start about 0.5 s before the peak, 10–25 s long), why it works in one line, a hook in
   the series language with the search phrase, and the layout (`crop`, `stack`, `fit`).
5. Drop anything the playbook forbids (cutscenes, endings, leaks, out-of-context cuts) and say what
   was dropped and why.
6. Summarise the rows in at most 10 lines, best first. End with: "Pick the ones to build:
   `/clip <slug>` for each." **And stop.**

## Rules
- Timecodes you have not checked against the source are marked `?`. Do not invent them.
- Do not run `bin/clip-fetch` here.
