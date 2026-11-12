# Sourced by bin/* and hooks. Makes sure Node 22+ is first on PATH (HyperFrames needs it) and
# turns HyperFrames telemetry off. Falls back to the newest v22+ under ~/.nvm when the default is older.
export HYPERFRAMES_NO_TELEMETRY=1
_node_major() { node -v 2>/dev/null | sed 's/^v//; s/\..*//'; }
if [ "$(_node_major || echo 0)" -lt 22 ] 2>/dev/null || ! command -v node >/dev/null 2>&1; then
  for d in $(ls -d "$HOME"/.nvm/versions/node/v*/bin 2>/dev/null | sort -t v -k 2 -V -r); do
    v=${d%/bin}; v=${v##*/v}; v=${v%%.*}
    if [ "$v" -ge 22 ] 2>/dev/null; then PATH="$d:$PATH"; export PATH; break; fi
  done
fi
if [ "$(_node_major || echo 0)" -lt 22 ] 2>/dev/null; then
  echo "ERROR: Node 22+ not found (have $(node -v 2>/dev/null || echo none)). Install it: nvm install 22" >&2
  exit 1
fi
