---
name: review
description: Pipeline stage 5. Runs the full bin/check and bin/render for videos/<slug>, has frame-reviewer inspect snapshots, and writes review.md for Luka to watch and write "ship" or notes. Publishes nothing.
argument-hint: <slug>
---

# /review <slug>

Goal: a rendered MP4 plus a short, honest list of what to look at before it goes anywhere.

## Steps

1. Every scene in `videos/<slug>/plan.md` must be built; if not, say which are missing and stop.
2. Run `bin/check <slug>` (full). Red: fix inside the plan's scope, or stop and report.
3. Run `bin/render <slug>` for the final-quality file at `renders/<slug>.mp4`.
4. Run `pnpm exec hyperframes snapshot videos/<slug> --review -o videos/<slug>/.hyperframes/review`
   and hand the `frame-reviewer` subagent only two things: the plan path and that folder.
5. Check its findings against the frames yourself. Fix blockers that are inside scope and rerun
   steps 2 to 4; anything else goes into the review as is.
6. Fill `videos/<slug>/review.md`: render path, size and duration, gate result, frame findings with
   second and severity, and three things Luka should check by eye or ear (exact second each).
7. End with: "Watch `renders/<slug>.mp4`, then reply `ship` or notes." **And stop.**
8. On `ship`: set `Status: ship (date)`, ask permission to commit, and say "Next: merge
   `video/<slug>`, upload by hand, then `/retro <slug>`."

## Rules
- Do not upload, share or publish. `hyperframes share|publish|cloud` are denied on purpose.
- Report what failed with its output. A review that hides a warning is worse than none.
