#!/bin/bash
# Stop hook (informative, exit 0): on video/<slug> branches with a plan, remind if the diff left the
# plan. Blocks nothing; the real gate is bin/check-scope inside /build and in review.
cd "$(dirname "$0")/../.." || exit 0
branch=$(git branch --show-current 2>/dev/null)
case "$branch" in video/*) ;; *) exit 0 ;; esac
[ -f "videos/${branch#video/}/plan.md" ] || exit 0
bin/check-scope 2>&1 | tail -6
exit 0
