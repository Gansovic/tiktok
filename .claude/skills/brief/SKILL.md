---
name: brief
description: Pipeline stage 1. Interviews Luka about a new video and leaves videos/<slug>/brief.md. Creates the video folder with bin/new-video. Does not write a script or touch compositions.
argument-hint: <slug>
---

# /brief <slug>

Goal: a brief short enough to read in one minute that fixes what the video is for.

## Steps

1. Read `AGENTS.md`. If `videos/<slug>/` does not exist, run `bin/new-video <slug>`. If it exists
   and `brief.md` says `Status: confirmed`, say so and stop.
2. List `series/` and ask which series this belongs to (or "one-off"). Read that `series.md`; do not
   ask again for anything it already answers.
3. Ask, **one question per message**: audience, the one point, hook idea, length, language,
   narration or text only, CTA, what is out of scope. Offer a concrete suggestion with each question.
4. If Luka names reference videos or accounts, a subagent may research them; report only what
   changes the brief.
5. Fill `videos/<slug>/brief.md` and show it in the chat. End with: "Reply `confirmed` or edit
   `videos/<slug>/brief.md`." **And stop.**
6. When Luka writes `confirmed`, set `Status: confirmed (date)` and say: "Next: `/script <slug>`."

## Rules
- One point per video. A second point is a second slug.
- Never write narration, scenes or HTML from this skill.
