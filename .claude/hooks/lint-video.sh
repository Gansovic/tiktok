#!/bin/bash
# PostToolUse (Edit|Write), informative, always exit 0: after an edit to an .html file inside
# videos/<slug>/ or clips/<slug>/, run `hyperframes lint` on that project and print the tail.
INPUT=$(cat)
cd "$(dirname "$0")/../.." || exit 0
FILE_PATH=$(printf '%s' "$INPUT" | python3 -c '
import json, sys
try:
    print(json.load(sys.stdin).get("tool_input", {}).get("file_path", "") or "")
except Exception:
    pass
' 2>/dev/null)
case "$FILE_PATH" in *.html) ;; *) exit 0 ;; esac
rel=${FILE_PATH#"$PWD"/}
case "$rel" in videos/*/*) tree=videos ;; clips/*/*) tree=clips ;; *) exit 0 ;; esac
slug=${rel#"$tree"/}; slug=${slug%%/*}
[ -f "$tree/$slug/index.html" ] || exit 0
[ -d node_modules ] || exit 0
. bin/_env.sh
pnpm exec hyperframes lint "$tree/$slug" 2>&1 | tail -12
exit 0
