---
name: weekly-git-summary
description: Summarize what the user worked on during a date range (default this week, Mon–Fri) by scanning git logs across all repos under a directory. Use when the user asks "what have I been working on this week", wants a weekly recap, time-report help, standup summary, or a summary of their commits across projects.
---

# Weekly git summary

Scan every git repo under a root directory, collect the user's own commits in a date range (all branches), and write a concise summary by project and by day.

## Steps

1. Work out the parameters:
   - **Date range**: use the dates the user gives. Otherwise default to Monday–Friday of the current week (use today's date from context). Check which weekday each date falls on.
   - **Root**: the current working directory unless the user names another.
   - **Author**: the default is the global `git config user.name`. Match on name, not email, because work repos may use a different email than the global one.

2. Run the collector:
   ```bash
   ~/.claude/skills/weekly-git-summary/scripts/collect.sh [SINCE] [UNTIL] [ROOT] [AUTHOR]
   ```
   Dates use the YYYY-MM-DD format, and every argument is optional. The script searches up to 4 levels deep, skips `node_modules`, and uses `--all` so commits on feature branches are included.

3. Clean up the output:
   - Drop `WIP on …` / `index on …` entries, which are git stash commits, not real work.
   - Collapse duplicate subjects (for example the same commit on two branches, or a hotfix merged twice) into one item.
   - If a change is reverted and then restored, mention it once.

4. Write the summary in chat (not a file), in this shape:
   - **By project**: order projects by activity. Give each a short header with its days, then bullets that group related commits into themes (for example "dependency upgrades", "SEO for partner list", "WCAG fixes"). Name versions, hotfix and release numbers, and notable fixes.
   - **By day**: one line per weekday with the main themes.
   - **In short**: one closing sentence.

   Keep it scannable. Describe what the work did, and don't just copy commit messages.

## Notes
- If nothing is found, say so and suggest checking the author pattern (run `git log -1 --format='%an <%ae>'` in a repo) or widening the root/depth.
- For a different period ("last week", "this month"), compute the dates and pass them explicitly.
