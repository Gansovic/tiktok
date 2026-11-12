---
name: storyboard
description: Pipeline stage 3. Turns an approved script.md into videos/<slug>/plan.md (scenes with timecodes, files, assets, audio, checks, risks) and waits for Luka's "approved". Does not edit HTML.
argument-hint: <slug>
---

# /storyboard <slug>

Goal: a plan that `/build` can follow scene by scene and `bin/check-scope` can enforce.

## Steps

1. Read `videos/<slug>/script.md` (must say `Status: approved`; if not, stop), `brief.md`,
   `AGENTS.md`, `brand/tokens.css`, `brand/safe-zones.css` and `docs/integrations.md`.
2. Load `/hyperframes` and search `/hyperframes-registry` for ready-made blocks before planning any
   hand-built visual.
3. Fill `videos/<slug>/plan.md`:
   - `## Scenes`: one row per scene with start, end, the file it lives in, what happens, assets and
     blocks. Scene times add up to the script's target seconds. A scene that can be built
     independently gets its own file under `compositions/`.
   - `## Files`: only files outside `videos/<slug>/`, one per line as `` - `path` — why ``. Usually
     empty. A change to `brand/` or `templates/` belongs here and needs a reason.
   - `## Audio`: narration, music, effects with source and licence.
   - `## Checks`: what `bin/check` covers and what Luka checks by hand, with the exact second.
   - `## Risks` and `## Not doing`.
4. More than 8 scenes or 60 seconds: propose splitting into two slugs and stop.
5. Show `## Scenes` and `## Files` in the chat. End with: "Reply `approved` or edit
   `videos/<slug>/plan.md`." **And stop.** Do not start any scene.
6. When Luka writes `approved`, set `Status: approved (date)` and say: "Branch `video/<slug>`.
   Next: `/build <slug> 1`."

## Rules
- Never create the branch or edit `index.html`, `compositions/` or `assets/` from this skill.
- Do not plan media you cannot name a licence-clean source for.
