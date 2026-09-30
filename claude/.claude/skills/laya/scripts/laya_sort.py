#!/usr/bin/env python3
"""Run Laya typed questions over a pile of items, locally, and print compact results.

Usage:
  laya_sort.py QUESTIONS.json ITEMS [--threshold 0.8] [--batch-size 16] [--csv OUT.csv]

ITEMS is one of:
  - a .json file holding a list (strings or objects; objects may carry an "id")
  - a .jsonl file, one item per line
  - a directory: every regular file inside is one item (id = filename)
  - "-" to read a JSON list from stdin

Prints a JSON list, one entry per item: {"id", "answers": {qid: {"value", "conf"}}, "check": [qids]}.
"check" lists the answers whose confidence is below --threshold; those need a human (or Claude) call.
"""
import argparse
import csv
import json
import sys
import time
from pathlib import Path

LAYA_PYTHON_HINT = "run with ~/dotfiles/venv/bin/python (the venv that has laya installed)"


def load_items(src):
    if src == "-":
        raw = json.load(sys.stdin)
    else:
        p = Path(src).expanduser()
        if p.is_dir():
            return [(f.name, f.read_text(errors="replace")) for f in sorted(p.iterdir()) if f.is_file()]
        if p.suffix == ".jsonl":
            raw = [json.loads(line) for line in p.read_text().splitlines() if line.strip()]
        else:
            raw = json.loads(p.read_text())
    items = []
    for i, it in enumerate(raw):
        if isinstance(it, dict) and "id" in it:
            items.append((str(it["id"]), {k: v for k, v in it.items() if k != "id"}))
        else:
            items.append((str(i), it))
    return items


def compact(answer):
    kind = answer["type"]
    if kind == "choice":
        value = answer["choice"]
    elif kind == "score":
        value = round(answer["score"], 2)
    else:  # noul: P(true)
        value = round(answer["noul"], 2)
    return {"value": value, "conf": round(answer["answer_confidence"], 2)}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("questions")
    ap.add_argument("items")
    ap.add_argument("--threshold", type=float, default=0.8)
    ap.add_argument("--batch-size", type=int, default=16)
    ap.add_argument("--csv", help="also write a flat CSV here")
    args = ap.parse_args()

    try:
        import laya
    except ImportError:
        sys.exit("laya is not importable: " + LAYA_PYTHON_HINT)

    questions = json.loads(Path(args.questions).expanduser().read_text())
    items = load_items(args.items)

    t0 = time.perf_counter()
    agent = laya.load("convaiinnovations/laya")
    t1 = time.perf_counter()
    results = agent.predict_batch([state for _, state in items], questions, batch_size=args.batch_size)
    t2 = time.perf_counter()

    out = []
    for (item_id, _), res in zip(items, results):
        answers = {qid: compact(a) for qid, a in res["answers"].items()}
        check = [qid for qid, a in answers.items() if a["conf"] < args.threshold]
        out.append({"id": item_id, "answers": answers, "check": check})

    print(json.dumps(out, indent=1, ensure_ascii=False))
    print(f"laya: {len(items)} items, load {t1 - t0:.1f}s, predict {(t2 - t1) * 1000:.0f} ms, "
          f"device {agent.device}", file=sys.stderr)

    if args.csv:
        with open(Path(args.csv).expanduser(), "w", newline="") as f:
            w = csv.writer(f)
            w.writerow(["id"] + [f"{q}{s}" for q in questions for s in ("", "_conf")] + ["check"])
            for row in out:
                cells = [row["id"]]
                for q in questions:
                    cells += [row["answers"][q]["value"], row["answers"][q]["conf"]]
                w.writerow(cells + [" ".join(row["check"])])


if __name__ == "__main__":
    main()
