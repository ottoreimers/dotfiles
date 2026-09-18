---
name: figma2clickup
description: Turn a Figma design file into a structured ClickUp backlog. Use whenever the user has a Figma link (or design-system mockup) and wants tasks, tickets, or cards created in ClickUp for each page type and its blocks/modules/global elements. Trigger on any combination of "Figma" + "ClickUp" with "backlog/tasks/tickets/cards/sprint", or phrases like "catalogue these designs", "build a backlog from this mock", "create tickets for each module/block in this Figma", "make ClickUp cards for the page types in this design system", "extract artefacts from Figma into ClickUp". Also trigger whenever the user pastes a Figma node URL alongside any task-creation intent, even if they don't say ClickUp explicitly — ask for the list.
---

# Figma → ClickUp backlog builder

Take a Figma node (typically a page-type mockup, or a section that contains multiple page-type mockups) and produce a structured ClickUp backlog: one parent task per artefact, each with an inline screenshot, short description, Figma component link, BE/FE subtasks, and a taxonomy tag.

## What "artefact" means here

The user works with four buckets. They drive the card title, the description template, and the tag:

- `page` — a page type (Home page, News listing, Property listing, …). In the CMS this is a page document. **Has** a CMS name + alias ending in `Page`.
- `block` — an editorial block the editor can place and reorder on a page (hero, USP cards, news teasers, video player, download CTA, quotes, stats, …). **Has** a CMS name + alias ending in `Block`.
- `global` — a fixed site-wide element (header / menu, footer, primary navigation). Not editorially movable. **No** CMS name/alias.
- `module` — content with a fixed position on a specific page (rich-text body, news/event/property listing, pagination band, sustainability strip). Not editorially movable. **No** CMS name/alias.

If you can't decide between `block` and `module`: would an editor want to drag this around between pages? Yes → `block`. No, it's always in the same slot → `module`. When unsure, ask once before creating.

## Inputs to gather first

Before doing anything else, get from the user:

1. **Figma node URL** pointing at the page type(s) to catalogue — format `https://www.figma.com/design/<fileKey>/<filename>?node-id=<id>`. Extract `fileKey` and `nodeId` from the URL (convert `node-id=1356-7827` to `1356:7827` for tool calls).
2. **ClickUp list URL** for the destination list — format `https://app.clickup.com/<workspace>/v/l/li/<listId>`. The numeric `listId` at the end is what the ClickUp MCP needs.
3. **Mobile Figma node URL** (optional). If supplied, use it to fill the `(mobile)` Figma link line. If not, the mobile line stays as plain text — surface this in the final report so the user can paste a mobile section later.

If the user's first link points at a foundations/style-guide page (colour swatches, typography specimens, button styles, spacing tokens, icons) or an inspiration/mood board, that's not a catalogue target. Tell them what you see and ask for a different node — typically the parent section that holds the actual page-type mockups.

## Workflow

### 1. Verify ClickUp prerequisites

Call `clickup_get_list` with the list id to confirm access. Then check that the four taxonomy tags exist in the Space — try `clickup_add_tag_to_task` against any existing task with `page` (or a throwaway probe). If you get `"tag … does not exist in the space"`, stop and ask the user to create the four tags once (ClickUp → Space settings → Tags → add `page`, `block`, `global`, `module` — any colour). The MCP wrapper can apply existing tags but cannot create new ones.

### 2. Pull the Figma metadata — always fresh

Call `get_metadata` with `fileKey` and `nodeId`. **Always pull fresh metadata at the start of every run** — never trust prior enumeration from earlier in the same session. Figma files get updated between runs: new screens are added, frames renamed, components retired. When the user says *"now do the X page"*, **re-list the top-level screens first** (`get_metadata` without a `nodeId`, or the section container) — there may be a new screen you didn't see last time. The cost of one extra metadata call is negligible compared to the cost of working from stale data.

Three things to watch for in the response:

- **Timeout.** If the call times out, the subtree is too deep. Step one level up, or ask the user to click a tighter container and resend the link.
- **Style-guide content.** If the returned children are all named like `Color`, `Typography`, `Buttons`, `Spacing`, `Icons`, `Effects`, `Logo` — it's a foundation page. Don't catalogue it.
- **Truncation.** If the result is too big to return inline and gets saved to disk, don't try to read the whole file. Use `Grep` with structural patterns (`name="…"`, `id="…"`) and the `head_limit`/`offset` knobs to extract just the direct children of the page frame you care about. Reading huge XML linearly is wasted work.

### 3. Surface the screens you found — ask the user which to catalogue

Walk the metadata one level deep to identify **page-type frames** — top-level frames whose names read like pages (`Desktop / Startsida`, `Desktop · Lediga lokaler / Listning`, `Mobile · News article`, etc). Ignore raw rectangles named like screenshots (`Skärmavbild 2026-…`), brand mood boards, foundation panels, and other non-screen content.

**Acknowledge what you found and ask which screens to process.** Never assume "all" — the user might want to start with one, or skip some. Example:

> I found 3 screens in this section:
> - `Desktop / Startsida`
> - `Desktop · Lediga lokaler / Listning`
> - `Mobile · Startsida`
>
> Which would you like to catalogue right now?

Wait for the answer before moving on. If the user provides a list, only process those screens. If they say "all", confirm once before going wide.

### 4. For each selected screen — propose the catalogue and confirm

Work **one screen at a time**, in the order the user listed them. For each screen:

1. Walk its direct children. Treat library instances (names starting with `L / …`), explicit containers (`BLOCK n: …`, `Section - …`), and the page frame itself as candidate artefacts. **Descend through anonymous wrappers** (`Frame 427321407`, `Container`) — they're layout scaffolding, not artefacts. **Dedupe** instances of the same component within the screen (four `L / USP-card` instances = one `USP cards` artefact). **Skip** style swatches, screenshot-named rectangles, and reference imagery.
2. Apply the categorisation heuristics from step 5 below.
3. Generate friendly CMS names + aliases for pages/blocks per the rules in step 6.
4. **Dedupe against the existing ClickUp board.** Before showing the catalogue, list parent tasks already in the destination list (`clickup_filter_tasks` against `list_id`, or `clickup_search`). For every candidate, mark it as either `new` or `reused → <existing task URL>`. Match by friendly name first, then by alias for blocks/pages, then by Figma component name as a fallback. Globals (Menu, Footer, Breadcrumb) and shared blocks (Stats small, USP cards, etc.) almost always come back as reused on the second screen onwards — don't recreate them; reference them from the new page's description instead.
5. **Check for naming collisions.** If a proposed friendly name (or alias) is already on the board but represents a *different* artefact — e.g. you propose `Pagination` for a numeric pager but a card with that name already represents a kinetic title band — surface the collision and propose disambiguating renames before continuing. The board should never have two cards with the same name pointing at different concepts.
6. **Present the proposed catalogue as a short table** so the user can scan it quickly. Columns: artefact name, category, alias (or `—` for global/module), status (`new` or `reused → <url>`). Example:

   | Name | Category | Alias | Status |
   |------|----------|-------|--------|
   | Våra fastigheter | page | `propertiesPage` | new |
   | Primary Navigation | global | — | reused → https://app.clickup.com/t/… |
   | Page header hero | block | `pageHeaderHeroBlock` | new |
   | Property listing | module | — | new |
   | Pagination | global | — | new (⚠ rename existing `Pagination` card first) |
   | Footer | global | — | reused → https://app.clickup.com/t/… |

7. **Ask the user to confirm or correct.** This is the cheapest moment to fix names, categories, or aliases — once cards are created, every change is an update + a re-tag + possibly a rename. Pay particular attention to: any `module` candidate that came from a cryptic Figma name (per step 5's guidance), any block/page where the alias might collide with existing CMS names, and any artefact the user might want to skip (e.g. WIP placeholders, blank frames).
8. **Only after confirmation, run steps 8-10 for that screen** (render descriptions, create parent tasks, attach tags, create BE/FE subtasks) — **for the `new` rows only**. Skip the `reused` rows; their existence is enough. Then loop back to the next screen and repeat from step 4.1. Save the final report (step 11) for after all selected screens are done.

If the user wants to deviate from this flow — e.g. "just create everything, I'll fix names later" — that's their call, do as asked. But the default is screen-by-screen confirmation.

### 5. Categorise each artefact (heuristics referenced from step 4)

Apply the taxonomy. Helpful priors:

- Names containing `Menu`, `Header`, `Footer`, `Nav` → `global`.
- Names suggesting pagination, marquees, kinetic carousels used as section openers, listings on content pages, body-text wrappers for content pages, sustainability/certifications strips → `module`.
- Containers explicitly prefixed `BLOCK n:` → `block`.
- Hero/teaser/USP/stats/quotes/feature/video/download patterns → `block`.
- The page frame itself → `page`.

`module` is the category that's hardest to spot from the Figma name — the visual cue is "fixed-position content widget", not "editorially movable building block". If you're not sure, surface it and let the user decide before creating the card.

**When a Figma name is cryptic, ask before titling.** Names like `text-animation-carousel` for what turns out to be a section pagination band, or generic labels like `Section 2` / `Component 2`, are designer working labels — not production names. Don't blindly clean them into a card title. When the name doesn't read as a clear CMS concept (especially common for modules), pause and ask the user what the component actually is, then propose a better title based on the answer. One quick question now saves a rename later.

### 6. Generate the CMS name + alias — page and block only (referenced from step 4)

Skip this for `global` and `module` — they don't get a `Name in CMS` line.

- Strip the `L /` library prefix from the component name.
- Drop slashes, `+`, punctuation; keep the meaningful words.
- **Friendly name**: title-case the words. Example: `L / Hero / Text + List + CTA` → `Hero text list CTA`.
- **Alias**: camelCase of the same words, suffixed:
  - `page` → ends in `Page` — `homePage`, `newsListingPage`, `propertyListingPage`.
  - `block` → ends in `Block` — `introMovieBlock`, `heroTextListCtaBlock`, `objectFeaturesBlock`.
- **Pluralise card-style collections.** If the Figma name contains `card`, `item`, or `tile`, pluralise the noun in both the friendly name and the alias: `USP-card` → `USP cards` (`uspCardsBlock`). Carousels, grids, strips, bars, marquees stay singular — they're a single band, even if they hold many children inside.

### 7. Write the short description

One or two sentences. What the component is, and how it's typically used. If a card-style component is going to be implemented as a collection block, say so — it's the answer to the engineer's first "wait, is this a single card or a list of cards?" question.

Look at the Figma screenshot when in doubt.

### 8. Render the markdown description

Use this exact template. The trailing two spaces on each line are intentional — that's the markdown hard break that puts each item on its own row in ClickUp.

**For `page` and `block`:**

```
![<Name> preview](<figma asset URL>)

<short description>

Name in CMS: <Friendly name> (`<alias>`)  
Link to demo page  
Link to CMS  
[Link to <componentName> component](<figma desktop node URL>) in Figma (desktop)  
[Link to <componentName> component](<figma mobile node URL>) in Figma (mobile)
```

**For `global` and `module`** — drop the `Name in CMS` line:

```
![<Name> preview](<figma asset URL>)

<short description>

Link to demo page  
Link to CMS  
[Link to <componentName> component](<figma desktop node URL>) in Figma (desktop)  
[Link to <componentName> component](<figma mobile node URL>) in Figma (mobile)
```

Rules for the Figma link lines:
- When a URL is available, the line is a markdown link with anchor text `Link to <componentName> component` and the suffix `in Figma (desktop)` or `in Figma (mobile)` outside the link.
- When the URL is **not** available (typically mobile), drop the markdown link syntax and leave the line as plain text: `Link to <componentName> component in Figma (mobile)`.
- `<componentName>` is the **friendly CMS name** — the same value used as the task title. For pages and blocks that's the camel-stripped friendly form (`Intro movie`, `USP cards`). For globals and modules it's the friendly artefact name you settled on with the user (`Menu`, `Section pagination`). Using the friendly name keeps the description reading coherently — `Link to USP cards component in Figma (desktop)`, not the raw-Figma `Link to USP-card component...`. If the node has no underlying component (just a plain frame) and you have no good friendly name either, drop the `<componentName>` token entirely: `Link to component in Figma (desktop)`.

The desktop Figma node URL takes the form `https://www.figma.com/design/<fileKey>/<filename>?node-id=<id-with-hyphen>` (note the hyphen — the URL form uses `643-2099`, not `643:2099`).

### 9. Create the ClickUp parent task

- `name` = the CMS block name for `page`/`block`, or the friendly artefact name for `global`/`module`. Pluralised where the card rule applies. **Task title = CMS block name** — this is the convention the user picked, so it stays consistent across the board and in dev references.
- `list_id` = the user's list.
- `markdown_description` = the rendered template above.

Immediately after creation, call `clickup_add_tag_to_task` with the category tag.

### 10. Create the BE/FE subtasks

For each parent, create two subtasks in the same list, both with `parent: <parent_task_id>`:

- `BE: Implement <name>`
- `FE: Implement <name>`

`<name>` matches the parent's name exactly (including any pluralisation).

### 11. Report back (after all selected screens are done)

List the created tasks (names + URLs), grouped by category. Call out:
- Anything skipped and why.
- Any artefact you categorised by a borderline heuristic — give the user a one-line invitation to re-tag it.
- The mobile pairing status: if no mobile section was supplied, mention the `(mobile)` lines are plain text placeholders and offer to do a second pass when the user provides the mobile section.

## Image durability — choose the right path

Figma's `get_screenshot` returns a short-lived asset URL (~15 minutes). Two paths from there, depending on where the skill is running:

- **Cowork / hosted environments.** The workspace proxy blocks figma.com, and `get_screenshot`'s base64 output is rendered as image content rather than text you can pipe. The cleanest move is to **embed the asset URL inline in the markdown description** (`![preview](url)`) and tell the user the inline preview will break after ~15 minutes. Don't bother with `clickup_attach_task_file` via `file_url` — ClickUp will name the file `<uuid>.bin` because the URL has no extension, and most setups won't preview those as images.
- **Local Claude Code.** No proxy block. Generate the screenshot, `curl` the asset URL to disk as `<artefactName>.png`, base64-encode the file, then call `clickup_attach_task_file` with `file_data` + `file_name=<artefactName>.png`. That gives durable image attachments with proper filenames. This is the recommended path when image durability matters.

If you're not sure which environment you're in, ask once at the start: "Are you running this locally (Claude Code) or in Cowork? It affects whether the screenshot previews stick around."

## Defaults baked in from the user's conventions

- Library prefix `L /` is internal grouping — strip it from displayed names everywhere.
- Aliases use camelCase, suffixed `Page` or `Block`.
- Card-style components become plural collection blocks (`uspCardsBlock`, not `uspCardBlock`).
- Subtask titles are exactly `BE: Implement <name>` and `FE: Implement <name>`.
- Task title = CMS block name (plural form for card collections).
- The four-category taxonomy (`page` / `block` / `global` / `module`) is canonical. Don't invent a fifth.
