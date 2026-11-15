---
name: post
description: Clips mode. Uploads ONE shipped clip to TikTok through Luka's logged-in Chrome, only after Luka wrote "post" for that clip (ADR 0003). Records the URL. Does nothing else on the account.
argument-hint: <slug>
---

# /post <slug>

Goal: the shipped render of `<slug>` is live on the right account, and `clip.md` says where.

## Steps

1. Luka must have written `post` for this slug in this conversation. If not, ask and stop.
2. Check: `clips/<slug>/clip.md` has `Status: ship`, `Posted:` is empty, `renders/<slug>.mp4` exists
   (`ffprobe`: 1080x1920, the clip's length). Read the series' `series.md` for the account handle.
3. Load `/claude-in-chrome`. Open TikTok Studio's upload page in a new tab. Confirm the logged-in
   handle is the series account; if it is another account, stop and say so.
4. The browser upload tool takes at most 10 MB. If the render is larger, make an upload copy
   `renders/<slug>.upload.mp4` (H.264, same 1080x1920 and length, bitrate sized to stay under 10 MB)
   and say so in the report. Attach the file, wait for processing, paste the approved caption and hashtags. Leave
   every other setting at its default unless Luka said otherwise.
   Decline TikTok's offer to turn on automatic content checks (an account setting: Luka's call). Do
   not @-mention a creator unless Luka confirmed the handle; write the name as plain text.
5. Read the page back: caption as approved, right file, no warning banner (copyright, unoriginal,
   content check). Any warning, captcha, login prompt or unexpected screen: **stop, do not publish**,
   report what the page says.
6. Press Publish once. Studio goes to Publicaciones; the video shows "Contenido en revisión / Solo yo"
   for a few seconds before turning public — wait and re-read, do not publish again.
   Get the video URL from the profile page.
7. Write `Posted: <url> (<date time>)` in `clip.md`, add the clip's row to `clips/metrics.csv`
   (numbers empty), and report the URL in one line. **And stop.**

## Rules
- One clip, one account, one `post`. Never retry a Publish that may have gone through: check the
  profile first.
- Nothing else on the account: no likes, follows, comments, profile edits or deletions.
- Never type or read passwords or codes. If the session is logged out, Luka logs in.
