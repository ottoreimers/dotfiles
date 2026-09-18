---
name: changelog-from-git-log
description: Use when turning git log output (or a list of commits) into a human-readable release changelog, release notes, or "what changed" summary — strips commit metadata and groups commits into New/Fix/Other.
---

# Changelog from Git Log

## Overview

Convert raw git log output into a clean, categorized changelog. The input is one or more commit lines (often with hash, date, author, graph characters); the output is a flat bullet list grouped by change type. Drop all commit metadata — keep only the human-readable change.

## Output Contract

The output is a markdown bullet list. Each line has this exact shape:

```
- <Category>: <Change description>
```

- **Category** is one of exactly three: `New`, `Fix`, `Other`.
- **Change description** is the commit's intent, rewritten as a clear, capitalized, present-tense phrase. Reuse the commit subject's wording; clean up casing and abbreviations but don't invent detail.
- One bullet per commit. Include **every** commit in the range — nothing is dropped, including tooling/dev-env/chore commits.

Group the bullets by category in this fixed order: **New first, then Fix, then Other.** No category headers — just the bullets, with each line self-labeled by its `New:`/`Fix:`/`Other:` prefix.

## Categorization

| Category | Use for |
|----------|---------|
| `New` | New features or capabilities (added X, allow Y, introduce Z) |
| `Fix` | Bugfixes, security patches, dependency/version updates that correct or harden behavior |
| `Other` | Tooling, deploy, CI, dev-environment, local config, language files, version-bumps of build tooling — anything that's neither a user-facing feature nor a fix |

When a commit is ambiguous, pick by its primary effect: does it *add* something users get (New), *correct* something (Fix), or *change internal/dev machinery* (Other)?

## Strip This Metadata

Remove all of the following from each input line before writing the bullet:
- Graph characters (`*`, `|`, `\`, `/`)
- Commit hashes (`439edcf`, `4dca6d4`, …)
- Ref decorations (`(HEAD -> develop, origin/develop, …)`)
- Relative/absolute dates (`27 hours ago`, `6 weeks ago`)
- Author names (`<saraojelind>`, `<Emma Fresk>`)

## Example

Input (raw `git log --graph --oneline` style):

```
* 439edcf - (HEAD -> develop) Change port for vite hot reload (27 hours ago) <saraojelind>
* 4dca6d4 - Update wp with composer (6 weeks ago) <Emma Fresk>
* 70da181 - Fix npm audit security vulnerabilities (6 weeks ago) <Emma Fresk>
* 1abc01e - Add slack notification to deploy (2 months ago) <saraojelind>
* 3575f69 - Allow custom color selector in gutenberg blocks (5 months ago) <saraojelind>
* 83a8901 - Update language files (6 weeks ago) <Emma Fresk>
```

Output:

```
- New: Add Slack notification to deploy
- New: Allow custom color selector in Gutenberg blocks
- Fix: Update WordPress and plugins via Composer
- Fix: Resolve npm audit security vulnerabilities
- Other: Change Vite hot reload port
- Other: Update language files
```

## Common Mistakes

- **Inventing categories** (Chore, Docs, Refactor) — there are only three: New, Fix, Other.
- **Adding category headers** ("## New") — the per-line prefix is the only label.
- **Dropping chore commits** — every commit in the range gets a line; tooling goes under Other.
- **Keeping hashes/dates/authors** — strip all metadata; the bullet is the change only.
- **Reordering within a category by date** — order within a category is not significant; group order (New → Fix → Other) is.
