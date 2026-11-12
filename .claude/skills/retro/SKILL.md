---
name: retro
description: Pipeline stage 6. After a video ships, turns what Luka had to correct or ask twice into dated rules in AGENTS.md (## Learned rules) or an ADR. Keeps AGENTS.md at or under 150 lines.
argument-hint: <slug>
---

# /retro <slug>

Goal: the same mistake does not happen again, by writing it where the agent always reads it.

## Steps

1. Ask Luka, one thing per message:
   - What did you have to correct or ask me twice in `<slug>`?
   - What looked or sounded wrong in the first render that the checks did not catch?
   - Was there a decision (structure, tool, format, series rule) worth fixing in writing?
   - If it was posted: how did it do, and what would you change in the hook?
2. For each answer propose **one sentence**:
   - Process or video rule → `AGENTS.md` under `## Learned rules`, format
     `- (YYYY-MM-DD, <slug>) rule`.
   - Rule for one series → that `series/<name>/series.md`.
   - Structural decision → new `docs/adr/NNNN-title.md` in the shape of `0001-pipeline.md`.
3. Check `wc -l AGENTS.md`. Over 150: propose which old rule is already covered by another rule or
   by `bin/check`, and delete it first. Never add above the cap.
4. If the new rule nearly duplicates one in `## Video rules`, strengthen that one with an example
   from this slug instead.
5. Show the diff in the chat, ask permission to commit (`docs(agents): rule from <slug>`), and
   finish. **And stop.**

## Rules
- A rule is a sentence an agent can obey without context. "Be careful with text" does not count;
  "captions never go below the safe area's bottom edge" does.
- No just-in-case rules: only what actually happened in this slug.
