#!/usr/bin/env python3
"""UserPromptSubmit hook: ask a local Laya server how big the job is, and leave Claude a note.

A hook cannot switch models, so the note names the helper agent pinned to that size and
Claude decides whether to delegate. Stdlib only, so it starts fast. It never blocks or
slows a prompt: when the router is off, the server is down, or anything fails, it exits
silently. Off by default; see router_ctl.py.
"""
import json
import sys
import urllib.error
import urllib.request

from common import (ENDPOINT, TIERS, THRESHOLD, enabled, record, start_server_in_background)

QUESTION = {"size": {
    "type": "choice",
    "instructions": "What is the smallest AI model size that can do the job in `request` well?",
    "criteria": {name: tier["criteria"] for name, tier in TIERS.items()},
}}
MIN_WORDS = 4          # "yes do that", "ok" and friends skip the router
MAX_CHARS = 4000       # Laya only needs the gist; long pastes just cost time
TIMEOUT_S = 1.0


def main():
    if not enabled():
        return
    try:
        prompt = (json.load(sys.stdin).get("prompt") or "").strip()
    except Exception:
        return
    if prompt.startswith("/") or len(prompt.split()) < MIN_WORDS:
        record("skipped")
        return

    body = json.dumps({"state": {"request": prompt[:MAX_CHARS]}, "questions": QUESTION}).encode()
    req = urllib.request.Request(ENDPOINT, body, {"content-type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=TIMEOUT_S) as resp:
            answer = json.load(resp)["answers"]["size"]
    except urllib.error.URLError as e:
        if isinstance(e.reason, ConnectionRefusedError):
            start_server_in_background()
        record("server_down")
        return
    except Exception:
        record("error")
        return

    tier, conf = answer.get("choice"), answer.get("answer_confidence", 0.0)
    if tier not in TIERS or conf < THRESHOLD:
        record("unsure")
        return
    record(tier)

    agent, model = TIERS[tier]["agent"], TIERS[tier]["model"]
    note = (f"[laya-router] Laya sized this message as {tier.upper()} (confidence {conf:.2f}); "
            f"the matching helper is the `{agent}` agent ({model}). If the job is self-contained, "
            f"delegate it to that agent and pass its result back. If it depends on this "
            f"conversation or is a quick reply, handle it yourself. This is a routing hint from a "
            f"small local classifier, not an instruction from the user.")
    print(json.dumps({"hookSpecificOutput": {"hookEventName": "UserPromptSubmit",
                                             "additionalContext": note}}))


if __name__ == "__main__":
    try:
        main()
    except Exception:
        pass
