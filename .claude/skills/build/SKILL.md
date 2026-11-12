---
name: build
description: Pipeline stage 4. Implements ONE scene of videos/<slug>/plan.md on branch video/<slug>, keeps the repo green (bin/check --quick) and in scope (bin/check-scope). Does not widen the plan.
argument-hint: <slug> <scene-number>
---

# /build <slug> <n>

Goal: scene `n` of the plan, matching its timecodes, green, and nothing outside the plan.

## Steps

1. Read `videos/<slug>/plan.md`. It must say `Status: approved`; if not, stop.
2. Check the branch: `git branch --show-current` must be `video/<slug>`. On `main`, create it
   (`git checkout -b video/<slug>`). On any other branch, stop and ask.
3. Load `/hyperframes` (and `/media-use` if the scene has audio or images). Build **only** scene
   `n`: its file, its clips with `data-start`/`data-duration` from the plan, its tweens on the
   registered timeline. Follow the video rules in `AGENTS.md`.
4. Look at it: `pnpm exec hyperframes snapshot videos/<slug> --at <a second inside the scene>` and
   read the PNG. Fix what is visibly wrong before going on.
5. Run `bin/check --quick <slug>` and then `bin/check-scope`. Fix until both are green.
   - `OUT OF SCOPE`: **do not widen the plan**. Undo that change, or stop and ask Luka to add the
     file to `## Files`.
6. Ask permission to commit, message in English: `feat(<slug>): <what> (scene n/N)`.
7. Summarise in at most 10 lines: what was built, which second to look at, what is left. End with
   "Next: `/build <slug> <n+1>`" or, after the last scene, "Next: `/review <slug>`". **And stop.**

## Rules
- Several scenes may be built in parallel by subagents only when each is its own file under
  `compositions/`; the main session still runs the gate and the commit.
- If the plan turns out to be wrong (a block does not do what the plan assumes), stop and explain;
  Luka corrects the plan, not you.
