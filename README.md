# tiktok

Short vertical videos (1080x1920) written as code and rendered to MP4, produced with Claude Code
through a staged pipeline. Compositions are HTML + CSS + GSAP, rendered by
[HyperFrames](https://hyperframes.heygen.com).

## Prerequisites

- Node 22+ (`nvm install 22`; the scripts in `bin/` pick it up from `~/.nvm` on their own)
- pnpm
- FFmpeg (`brew install ffmpeg`)
- Claude Code. The HyperFrames plugin is declared in `.claude/settings.json`; accept it when asked.

## Quick start

```
pnpm install
pnpm exec hyperframes doctor
bin/check hello          # full gate on the sample video, including a draft render
bin/render hello         # renders/hello.mp4
```

## Making a video

In Claude Code, one stage at a time; each stops and waits for you:

```
/brief <slug>        what the video is for
/script <slug>       timed beats → you write "approved"
/storyboard <slug>   scenes and files → you write "approved"
/build <slug> <n>    one scene per run, on branch video/<slug>
/review <slug>       full check, render, frame review → you write "ship"
/retro <slug>        what to do differently next time
```

How the pipeline works and the rules agents follow: [AGENTS.md](AGENTS.md).
What produces narration, captions and media: [docs/integrations.md](docs/integrations.md).

## Layout

```
videos/<slug>/    one video = one HyperFrames project plus its brief, script, plan, review
clips/<slug>/     one clip of a creator's GTA 6 stream: clip.md + generated composition (footage is not in git)
templates/video/  starter copied by bin/new-video
brand/            shared palette, fonts, safe zones
series/           one file per account or recurring format
bin/              check (the gate), check-scope, render, new-video
```

Posting is manual. Renders and generated audio are not committed.
