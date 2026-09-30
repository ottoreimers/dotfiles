#!/usr/bin/env python3
"""Turn the Laya router on or off, or show its status: router_ctl.py on|off|status|reset"""
import json
import sys
import urllib.request

from common import (ENABLED_FLAG, HEALTH, STATE_DIR, STATS_FILE, TIERS, THRESHOLD, load_stats,
                    server_pid, start_server_in_background, stop_server)


def health():
    try:
        with urllib.request.urlopen(HEALTH, timeout=1) as r:
            return json.load(r)
    except Exception:
        return None


def status():
    on = ENABLED_FLAG.exists()
    h = health()
    server = "up (" + ", ".join(h.get("loaded", [])) + ")" if h else (
        "starting" if server_pid() else "down")
    print(f"Laya router: {'ON' if on else 'OFF'}   server: {server}   threshold: {THRESHOLD}")
    stats = load_stats()
    routed = sum(stats.get(t, 0) for t in TIERS)
    for t, cfg in TIERS.items():
        print(f"  {t:9} -> {cfg['agent']:12} {stats.get(t, 0)}")
    print(f"  routed {routed}, unsure {stats.get('unsure', 0)}, skipped (short or /command) "
          f"{stats.get('skipped', 0)}, server down {stats.get('server_down', 0)}, "
          f"errors {stats.get('error', 0)}")
    print("  Laya cost so far: $0 (runs locally; prompts never leave this Mac)")


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "status"
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    if cmd == "on":
        ENABLED_FLAG.touch()
        start_server_in_background()
        print("Laya router ON. The first message or two may pass unrouted while the model loads (~15 s).")
    elif cmd == "off":
        ENABLED_FLAG.unlink(missing_ok=True)
        pid = stop_server()
        print("Laya router OFF" + (f" (stopped server pid {pid})" if pid else "") + ".")
    elif cmd == "reset":
        STATS_FILE.unlink(missing_ok=True)
        print("Stats cleared.")
    elif cmd != "status":
        sys.exit("usage: router_ctl.py on|off|status|reset")
    status()


if __name__ == "__main__":
    main()
