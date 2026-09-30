"""Shared config and state for the Laya router hook and its on/off control script."""
import json
import os
import subprocess
import time
from pathlib import Path

STATE_DIR = Path.home() / ".claude" / "laya-router"
ENABLED_FLAG = STATE_DIR / "enabled"
STATS_FILE = STATE_DIR / "stats.json"
PID_FILE = STATE_DIR / "server.pid"
LOG_FILE = STATE_DIR / "server.log"

LAYA_SERVE = Path.home() / "dotfiles" / "venv" / "bin" / "laya-serve"
HOST, PORT = "127.0.0.1", 8765          # localhost only; laya-serve defaults to 0.0.0.0
ENDPOINT = f"http://{HOST}:{PORT}/v1/systemone"
HEALTH = f"http://{HOST}:{PORT}/health"

THRESHOLD = 0.6                          # below this Laya is "unsure" and Claude just carries on

# Ordered smallest to biggest: tested 7/8 correct in this order, 5/8 reversed.
TIERS = {
    "tiny":     {"criteria": "a lookup, a rename or a one-line answer",
                 "agent": "laya-haiku", "model": "haiku"},
    "everyday": {"criteria": "a normal email, a post, a short document or a small code change",
                 "agent": "laya-sonnet", "model": "sonnet"},
    "large":    {"criteria": "a multi-step build, research, or a full report",
                 "agent": "laya-opus", "model": "opus"},
    "hardest":  {"criteria": "strategy, architecture, or anything where a wrong call is expensive",
                 "agent": "laya-fable", "model": "fable"},
}


def enabled():
    return ENABLED_FLAG.exists()


def load_stats():
    try:
        return json.loads(STATS_FILE.read_text())
    except Exception:
        return {}


def record(outcome):
    try:
        STATE_DIR.mkdir(parents=True, exist_ok=True)
        stats = load_stats()
        stats[outcome] = stats.get(outcome, 0) + 1
        tmp = STATS_FILE.with_suffix(".tmp")
        tmp.write_text(json.dumps(stats))
        tmp.replace(STATS_FILE)
    except Exception:
        pass


def server_pid():
    try:
        pid = int(PID_FILE.read_text())
        os.kill(pid, 0)
        return pid
    except Exception:
        return None


def start_server_in_background():
    """Start laya-serve detached, unless one is already starting. Returns immediately."""
    if server_pid():
        return
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ, LAYA_HOST=HOST, LAYA_PORT=str(PORT),
               LAYA_MODELS="english,multilingual", LAYA_LOG_LEVEL="warning")
    with open(LOG_FILE, "ab") as log:
        proc = subprocess.Popen([str(LAYA_SERVE)], env=env, stdout=log, stderr=log,
                                stdin=subprocess.DEVNULL, start_new_session=True)
    PID_FILE.write_text(str(proc.pid))


def stop_server():
    pid = server_pid()
    if pid:
        os.kill(pid, 15)
        for _ in range(50):
            try:
                os.kill(pid, 0)
                time.sleep(0.1)
            except OSError:
                break
    PID_FILE.unlink(missing_ok=True)
    return pid
