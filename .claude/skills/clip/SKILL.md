---
name: clip
description: Clips mode stage 2. Builds ONE clip from a row Luka picked in clips/_inbox.md - fetch the section, transcribe, fill clip.md, compose, check, render - and stops for Luka to watch and write "ship". Publishes nothing.
argument-hint: <slug> [inbox row or URL from to]
---

# /clip <slug>

Goal: `renders/<slug>.mp4`, green, following `docs/clips/playbook.md`, ready for Luka to watch.

## Steps

1. Take the row from `clips/_inbox.md` (or the URL and timecodes given). Check it against the
   playbook's "Never clip" list; if it fails, say why and stop.
2. `bin/new-clip <slug> --layout <crop|stack|fit> --series <gta6-es|gta6-en>`.
3. `bin/clip-fetch <slug> <url> <from> <to>` (asks; it is the only network step). It fills
   Source, From, To, Start and Target seconds in `clips/<slug>/clip.md`.
4. `bin/clip-transcribe <slug>`, then **read** `assets/transcript.json` against what is said:
   whisper invents words over gunfire, music and silence. Fix or delete wrong words in the file.
5. Fill `clip.md`: Creator, Hook (series language, search phrase, ≤ ~7 words), Hook accent, Credit
   (`@creator · platform`), Zooms (seconds of the peak), Crop x or Cam, Hashtags, and "Why this
   moment". Tighten Start / Target seconds so the clip opens ~0.5 s before the peak.
6. `bin/clip-compose <slug>`. Never edit `index.html` by hand: change `clip.md` and compose again.
   A look the generator cannot do is a change to `bin/clip-compose`, asked of Luka first.
7. Look: `pnpm exec hyperframes snapshot clips/<slug> --at 0,<peak>,<late>` and read the PNGs.
   Frame 0 shows the hook; captions and hook are inside the safe area and off the creator's face;
   the crop holds the action. Fix through `clip.md` and recompose.
8. `bin/check <slug>` (full: lint, runtime check, draft render), then `bin/render <slug>`.
   Lint warnings about sub-composition structure are expected for clips (ADR 0002).
9. End with at most 8 lines: render path, length, the second to look at, anything doubtful
   (transcript words, crop), and the proposed TikTok caption with hashtags. "Watch
   `renders/<slug>.mp4`, then reply `ship` or notes." **And stop.**
10. On `ship`: set `Status: ship (date)` in `clip.md`, remove the inbox row, ask permission to
    commit `feat(clips): <slug>`. Uploading is `/post <slug>`, only when Luka writes `post`.

## Rules
- One clip per run. For an A/B pair use two slugs (`<slug>-a`, `<slug>-b`) that differ in one thing.
- Footage, transcript files and renders are never committed; `bin/check` fails if anything but
  `clip.md`, `index.html`, `hyperframes.json`, `meta.json` and `brand/*.css` is tracked in a clip.
- Do not upload here. `ship` is not `post` (ADR 0003).
