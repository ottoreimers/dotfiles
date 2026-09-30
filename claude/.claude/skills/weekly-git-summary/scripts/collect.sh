#!/usr/bin/env bash
# Usage: collect.sh [SINCE] [UNTIL] [ROOT] [AUTHOR]
#   SINCE/UNTIL: YYYY-MM-DD (default: Monday..Friday of the current week)
#   ROOT: directory to scan for repos (default: current dir)
#   AUTHOR: regex matched against author name/email (default: global git user.name)
set -u
monday=$(date -v-mon +%F 2>/dev/null || date -d "monday this week" +%F)
friday=$(date -j -v+4d -f %F "$monday" +%F 2>/dev/null || date -d "$monday +4 days" +%F)
SINCE=${1:-$monday}
UNTIL=${2:-$friday}
ROOT=${3:-.}
AUTHOR=${4:-$(git config --global user.name)}

echo "# Commits by /$AUTHOR/ from $SINCE to $UNTIL under $ROOT"
find "$ROOT" -maxdepth 4 -name .git -not -path '*/node_modules/*' 2>/dev/null | sort | while read -r g; do
  d=$(dirname "$g")
  out=$(git -C "$d" log --all -i --author="$AUTHOR" \
        --since="$SINCE 00:00" --until="$UNTIL 23:59" \
        --date=format:'%a %d %b %H:%M' --pretty='%ad  %s' 2>/dev/null)
  if [ -n "$out" ]; then
    echo; echo "=== ${d#./}"; echo "$out"
  fi
done
exit 0
