---
name: laya-router
description: Turn the Laya model router on or off, or show its status. Usage /laya-router on|off|status|reset
disable-model-invocation: true
---

# Laya router switch

Run this and show the user its output verbatim:

```bash
~/dotfiles/venv/bin/python ~/.claude/skills/laya-router/scripts/router_ctl.py $ARGUMENTS
```

(No argument means `status`.)

## How the router works (for answering questions about it)

- A `UserPromptSubmit` hook (`scripts/router_hook.py`) sends each message to a local `laya-serve` on `127.0.0.1:8765` and asks one question: what's the smallest model size that can do this job well (tiny / everyday / large / hardest).
- If Laya is at least 60% sure, the hook adds a note naming the matching helper agent: `laya-haiku`, `laya-sonnet`, `laya-opus` or `laya-fable`. Claude delegates to that agent when the job is self-contained, and otherwise handles it itself.
- **Honest limit:** Claude Code has no per-message model switch, and a hook can't change the model. The note and pinned agents are the closest thing that works.
- It never blocks or slows a message. Slash commands and replies under 4 words skip it, and if the server is down or anything fails, the message goes through untouched. Turning it on starts the server; turning it off stops it.
- Everything runs locally, so nothing is sent to a third party. That makes it safe to leave on for private work too, unlike the Jev version.
- State, stats and the server log are in `~/.claude/laya-router/`.
