# 0003 — Posting clips through Luka's browser, on an explicit `post`

Date: 2026-11-15. Status: accepted. Replaces "posting is manual" for clips (ADR 0001, ADR 0002).

## Decision

Claude may upload a clip to TikTok by driving Luka's own logged-in Chrome session (TikTok Studio
upload page): attach `renders/<slug>.mp4`, fill the caption, press Publish.

It happens **only when Luka writes `post` for that clip**. One `post` covers one clip on one account.
`ship` is not `post`; an earlier `post` does not cover the next clip. No scheduling, no batches, no
posting on a timer.

## Why

Luka has 3–5 hours a day in launch week and uploads are the repetitive part. He asked for it
(2026-11-15) and chose full automation over "prepare and let me press the button".

## Consequences

- This is browser automation, not an official API. TikTok may treat it as automated behaviour, and a
  new account is the most exposed. Accepted risk. If an upload is flagged, a captcha or login prompt
  appears, or the page does not look as expected: stop, publish nothing, tell Luka. Never work around it.
- Preconditions checked before pressing Publish: `Status: ship` in `clip.md`, the render exists and
  matches the clip, the account shown in the browser is the one in the clip's `series.md`, the caption
  on screen is the approved one.
- After posting, the TikTok URL and time go into `Posted:` in `clip.md` and a row into
  `clips/metrics.csv`.
- No credentials are read, stored or typed. Only the existing session is used. Nothing else is done
  on the account (no follows, likes, comments, profile edits, deletions) without a separate ask.
- Videos under `videos/` are not covered: still manual.
- Whether web uploads perform worse than app uploads is unknown; compare in `clips/metrics.csv`.
