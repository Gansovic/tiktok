# Integrations

What produces each part of a video. Only the first table is in use; the rest is undecided.

| Need | Tool | Notes |
|---|---|---|
| Composition, render | HyperFrames CLI (pinned in `package.json`) | HTML + GSAP → MP4, local Chrome + FFmpeg |
| Narration | `hyperframes tts` | local model (Kokoro-82M); output is ignored by git |
| Captions | `hyperframes transcribe` | word-level timestamps from the narration audio |
| Audio and images | `/media-use` skill | check the licence of anything that gets committed |

## Undecided

- **Posting and scheduling:** manual upload for now. The reference video
  (https://www.youtube.com/watch?v=unLzowVKEiQ) mentions agents that schedule videos but its tool
  could not be confirmed. Any choice here gets an ADR and stays behind an explicit go.
- **External voices, image or video generation:** none. Adding one means an API key in `.env`
  (never committed) and an ADR.
