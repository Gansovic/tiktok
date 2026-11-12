# 0001 — Staged pipeline for every video

Date: 2026-11-12. Status: accepted.

## Decision

Every video goes brief → script → storyboard → build → review → retro, each stage a skill that leaves
a file in `videos/<slug>/` and stops at a gate. Script and plan need a written `approved`. `bin/check`
is the single technical gate and `bin/check-scope` keeps a `video/<slug>` branch inside its folder.
Same pattern as the `shopisan_admin` repo, adapted from features to videos.

## Why

Agents produce a render fast; the cost is in videos that miss the point or drift from what was
agreed. Gates before any composition code keep the expensive part (rendering, reviewing) for scripts
that were already approved.

## Consequences

- Each video is a self-contained HyperFrames project, so an Orca worktree per video works.
- `brand/` is copied into a video at creation: old videos re-render the same after a brand change.
- Publishing is outside the pipeline until a posting tool is chosen.
