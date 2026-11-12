---
name: script
description: Pipeline stage 2. Turns a confirmed videos/<slug>/brief.md into script.md (timed beats, narration, on-screen text, CTA, target seconds) and waits for Luka's "approved". Does not touch compositions.
argument-hint: <slug>
---

# /script <slug>

Goal: a script Luka can approve in two minutes, timed tightly enough to build from.

## Steps

1. Read `videos/<slug>/brief.md` (must be `confirmed`; if not, say what is missing and stop), the
   series file it names, and `AGENTS.md`.
2. Fill `videos/<slug>/script.md`: `Target seconds:` plus the beat table (start, end, narration,
   on-screen text, visual idea) and the CTA.
   - Beat 1 is the hook and ends by second 2.
   - Narration at speaking pace: about 2.5 words per second. Count it; do not guess.
   - On-screen text is at most 7 words per beat and is not a transcript of the narration.
3. Show in the chat: the hook, the beat table and total seconds. End with: "Reply `approved` or edit
   `videos/<slug>/script.md`." **And stop.**
4. When Luka writes `approved`, set `Status: approved (date)` and say: "Next: `/storyboard <slug>`."

## Rules
- Nothing in the script that the brief did not ask for. Extra ideas go to the chat as a list, not
  into the table.
- No claims of fact that you have not checked; mark anything uncertain for Luka.
