#!/bin/bash
# PreToolUse (Edit|Write|Bash). Blocks access to secret files. Exit 2 = block, 0 = allow.
# Covers file_path (Edit/Write) and the command string (Bash). `.env.example` is allowed.
INPUT=$(cat)

field() {
  printf '%s' "$INPUT" | python3 -c '
import json, sys
try:
    d = json.load(sys.stdin).get("tool_input", {})
    print(d.get(sys.argv[1], "") or "")
except Exception:
    pass
' "$1" 2>/dev/null
}

FILE_PATH=$(field file_path)
COMMAND=$(field command)

SECRET_RE='(^|[^A-Za-z0-9_])\.env($|[^A-Za-z0-9_.]|\.[A-Za-z0-9_]+)|\.pem($|[^A-Za-z0-9_])|\.key($|[^A-Za-z0-9_])|\.p12($|[^A-Za-z0-9_])|credentials[A-Za-z0-9_.-]*\.json'

check() {
  # Remove the one allowed name before matching.
  local text=${1//.env.example/}
  if printf '%s' "$text" | grep -qE "$SECRET_RE"; then
    echo "BLOCKED: secret files (.env*, *.pem, *.key, *credentials*.json) are off limits. Do not look for another way." >&2
    exit 2
  fi
}

[ -n "$FILE_PATH" ] && check "$(basename "$FILE_PATH")"
[ -n "$COMMAND" ] && check "$COMMAND"

if [ -n "$FILE_PATH" ] && printf '%s' "$FILE_PATH" | grep -q "node_modules/"; then
  echo "BLOCKED: do not edit node_modules" >&2
  exit 2
fi
exit 0
