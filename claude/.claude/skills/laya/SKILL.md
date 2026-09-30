---
name: laya
description: Use Laya, a local open-source decision model, to sort, triage, score or classify a pile of text (emails, tickets, invoices, feedback, files) fast and for free. Use when the user says "use Laya to sort these", "triage these with Laya", or asks to classify/score/label many items. Laya decides; Claude writes.
---

# Laya: fast local decisions

Laya (`convaiinnovations/laya`, installed in `~/dotfiles/venv`) is a "System 1" model: it never writes text. You give it a **state** (text or JSON) and **typed questions**, and it answers all of them in one parallel forward pass (~50 ms per item on this Mac's GPU, about 15–20 s to load the model once). It runs **locally**, so nothing leaves the machine, and it costs nothing.

## The rule

**Laya decides, Claude writes.** Laya answers the questions. Claude does the judging when Laya is unsure, plus all writing, summarising and reasoning.
- If `answer_confidence` is below **0.8**, don't trust the answer. Make that call yourself, or put the item in a "check these" pile for the user. The shipped checkpoints are over-confident, so the docs gate at 0.8. Only lower the threshold after checking it against labelled examples.
- Laya's decisions only affect what someone looks at first. Never take an irreversible action (pay, delete, reject, send) on Laya's word alone.
- Weak spots, so do these yourself: writing, chat, multi-step reasoning, counting, maths, date comparison, and long inputs padded with irrelevant text. Pre-compute sums and dates and pass the results in the state.
- English works best. Laya auto-routes to a multilingual checkpoint for other languages, including Swedish.

## Three answer shapes

```json
{
  "kind":  {"type": "choice", "instructions": "What kind of email is `state`?",
            "criteria": {"new_lead": "a potential new customer", "support": "help with an existing product", "spam": "junk"}},
  "lead":  {"type": "score",  "instructions": "How strong a sales lead is `state`?",
            "criteria": ["not a lead", "cold: vague interest", "warm: real need, no budget/timeline", "hot: need plus budget, timeline or decision maker"]},
  "reply": {"type": "noul",   "instructions": "Does `state` need a personal reply from our team?"}
}
```
- `choice`: picks one label. Use descriptive label keys (never yes/no), give every label a short description, and keep it to 20 options or fewer. **This is the most reliable shape**: in testing it got the email type right on 5 of 5.
- `score`: an ordinal rubric, returned as a float from 0 to N-1. **This is the weakest shape** (the docs say so, and it failed in testing: every email scored about 2). Don't use it for fuzzy judgments like "lead strength". Use a choice, or better, split the judgment into yes/no facts (see below).
- `noul`: the probability that the statement is true. Always give `criteria` for `true`/`false` and neutral labels, `"labels": {"true": "A", "false": "B"}`. Without them, the English checkpoint follows the label wording instead of the content.
- For a dict state, refer to its **keys** in instructions (e.g. `` `email` ``, `` `body` ``), not `` `state` ``. Put one line of business context in the state when it matters, e.g. `{"business": "...", "email": "..."}`.
- **Split fuzzy judgments into facts.** Instead of "how hot is this lead?", ask separate yes/no questions (wants to buy? budget mentioned? timeline mentioned?) and combine them yourself. Treat the result as a way to order the pile, not a final verdict.

## Running it

Write the questions to a JSON file in the scratchpad, then:

```bash
~/dotfiles/venv/bin/python ~/.claude/skills/laya/scripts/laya_sort.py questions.json ITEMS [--threshold 0.8] [--csv out.csv]
```
ITEMS can be a `.json` list, a `.jsonl` file, a directory (one file per item), or `-` for stdin. The output is compact JSON per item: `answers.{qid}.value`, `answers.{qid}.conf`, and a `check` list of the answers below the threshold. Batch everything in one run so the model loads only once.

For a one-off quick check: `~/dotfiles/venv/bin/laya --predict --preset triage "text"` (presets: email, guard, moderation, router, triage).

## Presenting results

Show a table sorted by what matters most (hot leads first, urgent tickets first, riskiest invoices first), then a separate **Check these** list for anything under the threshold, with your own call and a one-line reason for each. Then do the writing part the user asked for (draft replies, etc.) for the items that matter.
