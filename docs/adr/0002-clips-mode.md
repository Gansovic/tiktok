# 0002 — Clips mode next to the video pipeline

Date: 2026-11-15. Status: accepted. Posting: see ADR 0003.

## Decision

The repo gets a second mode, `clips/<slug>/`: a moment cut from a creator's public stream or video,
recomposed to 1080x1920 with our own hook, karaoke captions and an on-screen credit. Scope for now is
GTA 6 only, two series (`gta6-es`, `gta6-en`), one TikTok account each.

Clips use a short pipeline — `/scout` → `/clip` → `/metrics` — with one human gate (Luka watches the
render and writes `ship`) instead of the three approvals of ADR 0001. `clip.md` is the single source
of a clip; `bin/clip-compose` generates `index.html` from it, so nobody edits clip HTML by hand.
`bin/check` and `bin/render` serve both trees.

## Why

A clip is worth most in the hours after the moment happens; brief → script → storyboard would cost
more than the clip. The risk moves from "wrong video" to "wrong footage", so the gate checks
provenance (source, creator, credit) and the rules below rather than a plan.

## Consequences

- Footage, transcript files and renders never enter git: `clips/*/assets/` is ignored and `bin/check`
  fails on any tracked file in a clip other than `clip.md`, `index.html`, `hyperframes.json`,
  `meta.json` and `brand/*.css`. The caption words are part of the generated `index.html`. The repo stays public and licence-clean; only metadata and the
  generated composition are committed.
- `bin/clip-fetch` (yt-dlp, one section, at most 180 s) is the only script that fetches footage and
  always asks. Two other things reach the network: the first `bin/clip-transcribe` per language
  downloads a whisper model, and compositions load GSAP from jsdelivr like the video template.
- Content rules live in `docs/clips/playbook.md`: no leaks or pre-release footage, no isolated
  cutscenes, no endings, creator always credited, every clip transformed, takedown on first request.
- Creator permission is mostly unverified (`docs/clips/creators.md`); that is an accepted risk, not
  a solved one.
- Language priority is decided by numbers in `clips/metrics.csv`, first review 2026-11-25.
- Captions are a generated single-file composition, so `hyperframes lint` warns about
  sub-composition structure on every clip; those warnings are expected.
