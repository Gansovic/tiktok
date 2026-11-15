# Clips playbook (GTA 6)

Working rules for `/scout` and `/clip`. Numbers marked (v) come from vendor blogs: direction, not
benchmarks. Replace them with our own from `clips/metrics.csv` as soon as we have them.

## Never clip

- Leaked or pre-release footage, however it was obtained. Rockstar sends DMCA notices for seconds of it.
- Isolated cutscenes, cutscene compilations, endings, major story reveals (Rockstar video policy).
  Gameplay with the creator reacting over it is the format.
- A moment cut so the creator seems to say something they did not.
- Creators on the "no" list in `creators.md`.
- The same render on both accounts, or a file downloaded back from TikTok (watermark).

If a creator or Rockstar asks for a clip to come down, it comes down the same day; note it in `creators.md`.

## Every clip has

- **Our hook** on screen from frame 0, in the series language, containing the phrase people search
  ("GTA 6 mapa", "GTA 6 hidden detail"). At most ~7 words. It must be paid off by the clip.
- **Karaoke captions** of what the creator says, checked against the audio.
- **Credit** on screen all clip long (`@creator · platform`) and the creator tagged in the caption.
- A real edit: start ~0.5 s before the peak, cut dead air, punch in on the moment (`Zooms:`).

A bare re-upload gets TikTok's "unoriginal" flag: out of For You, and repeat flags hurt the account.

## Shape

- Length: 10–25 s for one moment, 30–45 s for lists ("Detalles de GTA 6 #N"). (v)
- Layouts: `crop` for pure gameplay, `stack` when the reaction is the point, `fit` when the whole
  frame matters (map, HUD, wide shot).
- Text between y=168 and y=1330, nothing under the right-hand action rail (`brand/safe-zones.css`).
- Last frame should cut back into the first when the moment allows it.
- YouTube limits ads on graphic violence in the first 15 s; keep that in mind if we cross-post.

## Posting (`/post`, only on Luka's `post` — ADR 0003)

- **5 clips a day per account** (Luka, 2026-11-15), from day 2 of the account. Never 10 on a new
  account (v). Spread them over the day, at least ~2 h apart. If views per clip drop sharply after
  the jump from 1 to 5, go back to 3 and say so in `/metrics`.
- 15–20 min a day watching and liking GTA content on each account while it is new.
- A/B tests: same moment, one variable (hook, layout or start point), at least 6 h apart.
- Caption: one line + 3–5 hashtags (`#gta6 #gtavi #gta6gameplay` + topic). Speed beats time of day
  in launch week.
- Reels and Shorts: optional after week 1, always from the clean render.

## Numbers that decide

Per clip at 24 h and 72 h, into `clips/metrics.csv` (`/metrics`): views, average watch time, % watched
in full, shares, new followers, % from For You vs Search.

Rough targets for a new account (v): full-watch 50–70 % under 30 s; average watch ≥ 70 % of length on
10–15 s clips; shares > 1 % of views.

Language decision: on 2026-11-25 compare median views per clip, 3 s retention and full-watch between
`gta6-es` and `gta6-en`; 70 % of the time goes to the winner. Review weekly.

## Money (not a goal yet)

- TikTok Creator Rewards: 10k followers, 100k views in 30 days, original videos over 1 minute; reposted
  clips are reported not to pay, and eligibility for Spain is unclear.
- Paid clipping campaigns (Whop Content Rewards and similar, median about $1 per 1k views): none for
  GTA 6 found on 2026-11-15. Look again weekly. Rockstar's footage licence says "non-commercial".
