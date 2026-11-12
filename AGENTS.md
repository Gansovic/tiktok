# AGENTS.md — how work happens in this repo

Short vertical videos (TikTok, 1080x1920) built as code: HTML + CSS + GSAP compositions rendered to
MP4 by [HyperFrames](https://hyperframes.heygen.com) (`hyperframes` CLI, pinned in `package.json`).
Needs Node 22+ (`.nvmrc`; `bin/*` find it under `~/.nvm` on their own) and FFmpeg on PATH.
This repo is **public**: no secrets, no copyrighted music, fonts or footage.

## Commands (use these, do not invent others)

```
bin/new-video <slug>          # copy templates/video + brand/ + doc templates into videos/<slug>/
bin/check [--quick] [slug]    # THE gate: lint, 1080x1920, docs status, file sizes; full = + runtime check + draft render
bin/check-scope [plan]        # branch diff stays inside videos/<slug>/** and the plan's "## Files"
bin/render <slug> [--draft]   # render to renders/<slug>.mp4 and assert size + duration with ffprobe
pnpm exec hyperframes preview videos/<slug> --background   # studio preview; --status / --stop
pnpm exec hyperframes snapshot videos/<slug> --at 1,3,5    # PNG frames to look at before rendering
```

Dependencies are added by Luka (`pnpm add` always asks).

## Structure

```
videos/<slug>/      one video = one HyperFrames project: brief.md, script.md, plan.md, review.md,
                    index.html, compositions/, assets/, brand/ (snapshot copied at creation)
templates/video/    1080x1920 starter copied by bin/new-video
brand/              tokens.css (palette, fonts), safe-zones.css — source of truth for the look
series/<name>/      series.md per account/series: audience, voice, language, format, cadence
docs/templates/     brief, script, plan, review       docs/adr/    decisions
docs/integrations.md   what produces narration, captions, music; posting (manual for now)
renders/            output MP4s, ignored by git
```

## The pipeline (mandatory for anything under `videos/`)

| Stage | Skill | Leaves | Gate |
|---|---|---|---|
| 1 Brief | `/brief <slug>` | `videos/<slug>/brief.md` | Luka confirms |
| 2 Script | `/script <slug>` | `script.md` | Luka writes `approved` |
| 3 Storyboard | `/storyboard <slug>` | `plan.md` | Luka writes `approved` |
| 4 Build | `/build <slug> <scene>` | commits on `video/<slug>` | `bin/check --quick` and `bin/check-scope` green |
| 5 Review | `/review <slug>` | `renders/<slug>.mp4` + `review.md` | Luka watches, writes `ship` or notes |
| 6 Retro | `/retro <slug>` | rule in "Learned rules" or an ADR | this file ≤ 150 lines |

Hard rule: **no edits to `index.html`, `compositions/` or `assets/` of a video without an approved
plan**. If the diff needs a file that is not in `## Files`, stop and ask Luka to widen the plan.
Do not widen it yourself. Publishing is not a stage yet: it is manual and always asks.

## Video rules

- Root element: `data-width="1080" data-height="1920"`. One root timeline registered on
  `window.__timelines`.
- Load `/hyperframes` before writing or changing a composition; `/media-use` for any audio or image.
- Text and key visuals stay inside the safe area from `brand/safe-zones.css` (class `safe`).
- The hook is on screen and readable within the first 2 seconds. Frame 0 is the thumbnail: it is
  never empty (animate scale or position in, not opacity from zero).
- Colours and fonts come from `brand/tokens.css` variables, never hard-coded per scene.
- Narration: `hyperframes tts`; captions: `hyperframes transcribe`. See `docs/integrations.md`
  before reaching for an external service.
- Media committed to git: small, licence-clean, under `videos/<slug>/assets/`. Nothing over 5 MB.
  Renders and generated audio stay ignored.
- `hyperframes share`, `publish`, `cloud`, `lambda`, `auth` leave the machine: denied.
- `git commit` and `git push` always ask. Commit messages in English, conventional commits, no AI
  attribution lines.

## Delegation

- **Inline (main session):** brief, script, storyboard and every approval. They need Luka.
- **Own subagents:** reference research for a brief; scene builds in parallel only when each scene is
  its own file under `compositions/`; `frame-reviewer` on snapshots during `/review` (it gets only
  `plan.md` and the PNGs, never the build conversation).
- **Orca worker:** one worktree per video (`video/<slug>`) when several videos are in production at
  once; a second agent (Codex) reviewing composition code, once Codex is installed.
- Brief every delegate with: goal, what done looks like, what is already known, constraints, output
  shape. Check what comes back against the files before reporting it.

## Secrets

Never read, write or quote `.env*` (except `.env.example`), `*.pem`, `*.key`, `*credentials*.json`.
The hooks in `.claude/hooks/` block it; if a hook blocks, do not look for another way.

## Learned rules

Format: `- (YYYY-MM-DD, <slug>) one-line rule`. Added by `/retro`. If this file passes 150 lines,
`/retro` proposes what to delete before adding.
