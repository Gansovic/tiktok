# Plan: hello

Status: approved (2026-11-12, setup sample)

## Scenes

| # | Start | End | File | What happens | Assets / blocks |
|---|---|---|---|---|---|
| 1 | 0.0 | 3.0 | `index.html` | "Hello, TikTok" rises into the safe area, accent bar grows under it | none |

## Files

None outside `videos/hello/`.

## Audio

None.

## Checks

`bin/check hello` covers lint, canvas size, runtime check and a draft render with ffprobe.
By hand: at second 1.5 the title is centred inside the safe area.

## Risks

None; this is the smoke test for the setup.

## Not doing

Audio, captions, posting.
