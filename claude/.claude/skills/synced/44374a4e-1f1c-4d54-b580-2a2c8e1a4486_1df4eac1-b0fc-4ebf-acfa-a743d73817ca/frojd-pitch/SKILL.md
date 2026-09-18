---
name: frojd-pitch
description: Skapar säljande offerter, pitchar och projektupplägg i Fröjd Interactive ABs stil och tonalitet — som scrollbar webb-offert eller Reveal.js-presentation. Använd denna skill när användaren vill ta fram säljmaterial som ska övertyga och presenteras: pitch, deck, slides, webb-offert, projektupplägg, scope, approach. Trigga även på kund, uppdrag, förslag, investering/pris som argument, Shape/Ship/Scale eller faser. Trigga INTE på dokument som ska signeras (avtal, konsultavtal, offert för underskrift, villkor) — då används frojd-avtal. Genererar HTML med inbäddade fonter.
---

# Fröjd Pitch Skill

Skapar professionella pitchar och offerter som **självständiga HTML-sidor** i Fröjd Interactive ABs visuella identitet.

**Huvudleverans: en scrollbar HTML-sida** — ett pitch-deck/offert som skickas till kund eller visas på skärm (se Roschier- och RFSL-referenserna). Sidan är självständig med inbäddade fonter och fungerar offline. Samma innehåll kan även levereras som Reveal.js-slides när det ska presenteras live i möte.

- **Scrollbar sida (LÄGE 1)** — standard. Bäst att skicka, läsa på skärm och exportera till PDF.
- **Reveal.js-slides (LÄGE 2)** — när det ska presenteras live; valbart tillägg.

Default är en scrollbar sida — fråga bara om slides när det är oklart.

---

## Beroenden — relaterade skills

- **`frojd-identity`** — den grafiska profilen (färg, typografi, logotyp). Kanonisk källa för det visuella. Fonter och logotyper finns även inbäddade i den här skillens `assets/` så den fungerar fristående.
- **`frojd-fakta`** — hårda fakta (org.nr, adress, timpriser, betalvillkor). Läs in när du behöver priser eller företagsuppgifter.
- **`frojd-avtal`** — för dokument som ska signeras (offert med villkor, konsultavtal). Den här skillen gör säljmaterialet; avtal-skillen gör det signerbara.

---

## FONTER — VIKTIGT

Båda typsnitten är inbäddade i assets-mappen. **Läs alltid båda CSS-filerna och inkludera hela innehållet i `<style>`-taggen** — då fungerar fonterna offline, utan externa beroenden.

1. **`assets/sofia_pro_embedded.css`** — Sofia Pro, alla vikter (300–700), inbäddad som base64
2. **`assets/libre_caslon_embedded.css`** — Libre Caslon Text Regular (font-weight: 400) inbäddad som base64. Använd ALDRIG bold eller italic — Libre Caslon används uteslutande i Regular.

```html
<style>
  /* Klistra in hela sofia_pro_embedded.css här */
  /* Klistra in hela libre_caslon_embedded.css här */
  
  /* övrig CSS... */
</style>
```

Båda typsnitten är **100% inbäddade** — alla dokument fungerar offline utan externa beroenden.

---

## Fröjds varumärkesidentitet

### Färgpalett
| Namn | Hex | Användning |
|------|-----|-----------|
| Fröjd Lila (primär) | `#36017A` | Logotyp på ljus bakgrund, accentfärg |
| Accent lila ljus | `#E6C4F3` | Rubrikfärg i hero, highlights på mörk bakgrund |
| Accent mid | `#c48edb` | Sekundär accent |
| Off-white | `#F9F9F9` | Bakgrund ljusa sektioner |
| Mörk | `#111111` | Hero, mörka sektioner |
| Mörk yta | `#1a1a1a` | Sekundär mörk bakgrund |
| Vit | `#FFFFFF` | Text på mörk, kortbakgrund |
| Gradient cover | `#E8C8F0 → #FFF8E1` | Cover-bakgrund (lila→gul) |

### Typografi
- **Rubriker (display/h1/h2):** `Libre Caslon Text` — serif, editorial. Alltid `font-weight: 400` (Regular). Aldrig bold, aldrig italic.
- **UI / brödtext / labels:** `Sofia Pro` — clean sans-serif
- **Viktigaste vikter:** Sofia Pro 300 (light), 400 (regular), 500 (medium), 600 (semibold), 700 (bold)

### Logotyp
SVG-logotyper finns i `assets/`:
- `fro_jd-lila.svg` — lila `#36017A`, för ljus bakgrund
- `fro_jd-vit.svg` — vit, för mörk bakgrund
- `fro_jd-svart.svg` — svart, för neutral bakgrund

Bädda alltid in som inline SVG — kopiera SVG-koden direkt från filen in i HTML:en.

---

## Fröjds tonalitet

- **Direkt och strategisk** — Expertperspektiv, förstår kundens affär
- **Insiktsdriven** — Analys av kundens situation före lösning. Spegla tillbaka kundens egen insikt innan lösningen ("Your pre-study is clear and self-aware…", "two tracks, one ambition")
- **Faktapåståenden som rubriker** — Stora, modiga meningar i Caslon
- **Partnerskap** — "Vi"-perspektiv, kunden är del av teamet
- **Självsäker och rättfram** — Plain-spoken, inga floskler. Säg saker rakt: "We'd rather name the risks now than meet them later", "Launch is a starting point, not a finish line"
- **Ärlig om avvägningar** — Namnge risker och teknikval öppet, och peka på var de löses (oftast i Shape). Bygger förtroende
- **Språk** — Svenska är default. Skriv på engelska när användaren ber om det eller när offerten riktar sig till en engelskspråkig mottagare (som Roschier-förslaget). Fråga om det är oklart
- **Avskalad när det passar** — Inte alltid marknad/approach, ibland rakt på scope och pris

---

## Fröjds erbjudande och positionering

**Övergripande:**
> Fröjd skapar hållbara digitala tjänster som driver tillväxt och håller för framtiden.
> Vårt team på 50 specialister hjälper er att skapa digitala tjänster som möter framtidens kundresor och driver er tillväxt.

**Tjänsteområden — använd rätt längd beroende på sammanhang:**

| Område | Kort | Medium | Lång |
|--------|------|--------|------|
| Teknik och utveckling | Skalbar och framtidssäkrad teknik | Skalbar och framtidssäkrad teknik som växer med er | Vi hjälper er tillvarata teknikens möjligheter och skapa skalbara och framtidssäkrade lösningar som växer med er |
| Innehåll och synlighet | Innehåll som träffar rätt | Innehåll som träffar rätt, skapar synlighet och konverterar | Med innehåll som träffar rätt genom hela kundresan hjälper vi er skapa synlighet och driva konvertering |
| Design och interaktion | Träffsäker design som lyfter ert varumärke | Träffsäker design som lyfter ert varumärke och användarupplevelsen | — |
| Skala och optimera | Kontinuerlig utveckling, mätbara resultat | Datadriven kontinuerlig utveckling ger mätbara resultat | En snabbfotad och datadriven process för vidareutveckling ger er mätbara resultat |

**Alternativa formuleringar för teknik:** "Teknik byggd för att växa med er" / "Teknik som skalar med er"

**Fler case och inspiration:** https://www.frojd.se/

**Använd frojd.se som källa** — sök alltid på frojd.se för:
- Aktuella case och kundberättelser (frojd.se/case)
- Vår tonalitet och hur vi beskriver oss själva
- Tjänster och erbjudanden (frojd.se/tjanster)
- Designmanér och visuell kommunikation
- Uppdaterad info om teamet och specialister

---

## Moduler — välj rätt kombination

| Modul | Full pitch | Offert | Snabb offert |
|-------|-----------|--------|-------------|
| Cover / Hero | Gradient cover-slide | Mörk hero med nav | Mörk hero enkel |
| Agenda | ✓ | Nav-ankarlänkar | — |
| Bakgrund / Uppdrag | ✓ | ✓ | Kort |
| Marknaden | ✓ | — | — |
| Vår approach (Shape/Ship/Scale) | ✓ | — | — |
| Faser / Projektupplägg | Shape/Ship/Scale | Custom fas-struktur med timeline | Lista |
| Team | ✓ | ✓ | — |
| Investering | Tabell per fas | Tabell per fas + allokeringsstaplar | Summa |
| Hur vi hjälpt andra | 2–4 case | — | — |
| Avslutning / CTA | Tack-slide med gradient | "Redo att köra?"-sektion | Footer |

---

## LÄGE 1: Scrollbar offert (webbsida)

Webbsida med fast nav-bar, ankarnavigation och scrollbara sektioner.

### Struktur
```
nav (fast, mörk, Fröjd-logotyp + ankarlänkar)
section.hero (mörk, full-height, h1 i Caslon med accent-span, meta-rad med klient/budget/tid)
div.dark-section (rubrik per avsnitt, id för ankar)
div.light-section (innehåll per avsnitt)
...
section.cta-section ("Redo att köra?" med mailto-länk)
footer
```

### Hero-struktur
```html
<section class="hero">
  <div class="hero-inner">
    <span class="tag">OFFERT — [KLIENTNAMN]</span>
    <h1>[Stor rubrik i Caslon med <span>accentfärgad del</span>]</h1>
    <p class="hero-lead">[Kort ingress, max 2 meningar]</p>
    <div class="hero-meta">
      <div class="meta-item">
        <span class="meta-label">KLIENT</span>
        <span class="meta-value">[Namn]</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">TOTAL BUDGET</span>
        <span class="meta-value">[X XXX XXX SEK]</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">PROJEKTTID</span>
        <span class="meta-value">[X veckor]</span>
      </div>
    </div>
  </div>
</section>
```

### Fas-timeline
```html
<div class="timeline">
  <div class="timeline-item">
    <div class="timeline-dot"></div>
    <span class="timeline-duration">Fas 1 — ca X veckor</span>
    <h3>Fasnamn</h3>
    <p>Beskrivning...</p>
    <div class="timeline-outcome">Utkomst: ...</div>
  </div>
</div>
```

### Allokeringstabeller med staplar
```html
<div class="alloc-bar">
  <div class="bar-bg"><div class="bar-fill" style="width:75%"></div></div>
  <span class="alloc-pct">75%</span>
</div>
```

### Nyckel-CSS för offert
```css
nav { position:fixed; top:0; width:100%; background:rgba(17,17,17,0.97);
      backdrop-filter:blur(12px); z-index:100; padding:0 3rem; }
.nav-inner { max-width:1200px; margin:0 auto; display:flex;
             align-items:center; justify-content:space-between; height:60px; }
.hero { background:#111; color:#fff; padding:11rem 3rem 6rem;
        min-height:70vh; display:flex; align-items:flex-end; position:relative; }
.hero h1 { font-family:'Libre Caslon Text',Georgia,serif;
           font-size:clamp(2.5rem,6vw,4.5rem); font-weight:400; /* Caslon ALLTID 400 */
           letter-spacing:-0.02em; line-height:1.1; max-width:900px; }
.hero h1 span { color:#E6C4F3; }
.hero-meta { display:flex; gap:4rem; margin-top:4rem; padding-top:3rem;
             border-top:1px solid rgba(255,255,255,0.1); flex-wrap:wrap; }
.meta-label { font-size:.65rem; text-transform:uppercase; letter-spacing:.12em;
              color:rgba(255,255,255,.35); font-weight:600; display:block; margin-bottom:.4rem; }
.meta-value { font-size:1.3rem; font-weight:700; color:#fff; display:block; }
.dark-section { background:#111; color:#fff; padding:4rem 3rem; }
.dark-section h2 { font-family:'Libre Caslon Text',Georgia,serif;
                   font-size:clamp(2rem,4.5vw,3.2rem); font-weight:400; /* Caslon ALLTID 400 */
                   letter-spacing:-0.02em; max-width:700px; line-height:1.15; }
.dark-section p.subtitle { font-size:1.1rem; color:rgba(255,255,255,.55);
                           max-width:600px; margin-top:1.5rem; line-height:1.75; }
.light-section { padding:5rem 3rem; background:#fff; }
.section-inner { max-width:1200px; margin:0 auto; }
.timeline { display:flex; flex-direction:column; gap:3rem; }
.timeline-item { position:relative; padding-left:2rem; }
.timeline-dot { position:absolute; left:0; top:.5rem; width:10px; height:10px;
                border-radius:50%; background:#E6C4F3; }
.timeline-duration { font-size:.75rem; font-weight:700; color:#36017A;
                     letter-spacing:.05em; display:block; margin-bottom:.5rem; }
.timeline-outcome { background:#f9f9f9; border-left:3px solid #E6C4F3;
                    padding:1rem 1.5rem; margin-top:1rem; font-size:.9rem; color:#444; }
.bar-bg { background:rgba(0,0,0,.07); border-radius:2px; height:6px; flex:1; }
.bar-fill { background:#36017A; height:100%; border-radius:2px; }
.alloc-bar { display:flex; align-items:center; gap:1rem; }
.alloc-pct { font-size:.8rem; font-weight:600; min-width:2.5rem; }
.cta-section { background:linear-gradient(135deg,#E8C8F0,#FFF8E1);
               padding:8rem 3rem; text-align:center; }
.cta-section h2 { font-family:'Libre Caslon Text',Georgia,serif;
                  font-size:clamp(2rem,4vw,3.5rem); color:#36017A; margin-bottom:1rem; }
.cta-btn { display:inline-block; background:#36017A; color:#fff;
           padding:1rem 2.5rem; font-weight:700; text-decoration:none;
           border-radius:2px; margin-top:2rem; font-family:'Sofia Pro',sans-serif; }
footer { background:#111; color:rgba(255,255,255,.4); padding:2rem 3rem;
         display:flex; justify-content:space-between; font-size:.8rem; }
```

---

## LÄGE 2: Reveal.js presentation (slides)

Slideshow med tangentbordsnavigation. Varje slide = en `<section>`.

### HTML-skelett
```html
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@4.6.1/dist/reveal.css">
  <link href="https://fonts.googleapis.com/css2?family=Libre+Caslon+Text:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
  <style>
    /* === INBÄDDAD SOFIA PRO (från assets/sofia_pro_embedded.css) === */
    [KLISTRA IN HELA INNEHÅLLET FRÅN sofia_pro_embedded.css HÄR]

    .reveal, .reveal * { font-family: 'Sofia Pro', sans-serif !important; }
    .reveal section { height: 100%; }
    .reveal .caslon { font-family: 'Libre Caslon Text', serif !important; }
    /* Reveal overrides */
    .reveal { background: #F9F9F9; }
    .reveal .slides section { padding: 0; }
  </style>
</head>
<body>
<div class="reveal">
  <div class="slides">
    <!-- slides här -->
  </div>
</div>
<script type="module">
  import Reveal from 'https://cdn.jsdelivr.net/npm/reveal.js@4.6.1/dist/reveal.esm.js';
  Reveal.initialize({ hash: true, transition: 'fade', transitionSpeed: 'fast',
                      controls: true, progress: false, slideNumber: false });
</script>
<!-- Nav-tips -->
<div style="position:fixed;bottom:1rem;right:1rem;font-size:.65rem;
            color:rgba(0,0,0,.25);z-index:999;pointer-events:none;
            font-family:'Sofia Pro',sans-serif">
  ← → för att navigera · F för fullskärm · ESC för översikt
</div>
</body>
</html>
```

### Slide-typer

**Cover (gradient):**
```html
<section style="background:linear-gradient(135deg,#E8C8F0 0%,#FFF8E1 100%);
                display:flex;flex-direction:column;align-items:center;
                justify-content:center;min-height:100vh;text-align:center;padding:4rem">
  [INLINE LOGO SVG LILA, width:180px, margin-bottom:3rem]
  <div style="font-size:.9rem;font-weight:700;color:#36017A;margin-bottom:1.5rem;
              letter-spacing:.05em">[KLIENTNAMN]</div>
  <h1 style="font-family:'Sofia Pro',sans-serif;font-size:clamp(3rem,7vw,6rem);
             font-weight:700;color:#36017A;line-height:1;max-width:900px">[Titel]</h1>
</section>
```

**Mörk section-header:**
```html
<section style="background:#111;min-height:100vh;display:flex;
                align-items:flex-end;padding:4rem;position:relative">
  <div style="position:absolute;top:2.5rem;left:3rem">
    [INLINE LOGO VIT, width:90px]
  </div>
  <h2 style="font-family:'Sofia Pro',sans-serif;font-size:clamp(3rem,6vw,5rem);
             font-weight:700;color:#E6C4F3;line-height:1.05">[Sektionsrubrik]</h2>
</section>
```

**Ljus tvåkolumn-slide:**
```html
<section style="background:#F9F9F9;min-height:100vh">
  <div style="display:grid;grid-template-columns:1fr 1.4fr;gap:5rem;
              height:100vh;align-items:start;padding:5rem 4rem">
    <div>
      <div style="font-size:.75rem;font-weight:700;color:#36017A;
                  margin-bottom:1.5rem;letter-spacing:.05em">[ETIKETT]</div>
      <h2 class="caslon" style="font-size:clamp(1.8rem,3vw,2.8rem);font-weight:400; /* alltid 400, aldrig 700 */
                                 line-height:1.15;color:#111;letter-spacing:-.02em">[Rubrik.]</h2>
    </div>
    <div style="padding-top:2.5rem">
      [innehåll: check-list, brödtext, tabell etc]
    </div>
  </div>
</section>
```

**Mörk tvåkolumn-slide:**
```html
<section style="background:#1a1a1a;color:#fff;min-height:100vh">
  <!-- samma layout, rubriker i #E6C4F3, brödtext rgba(255,255,255,.7) -->
</section>
```

**Investerings-slide:**
```html
<section style="background:#F9F9F9;min-height:100vh;padding:4rem">
  <div style="max-width:900px;margin:0 auto">
    <div style="font-size:.75rem;font-weight:700;color:#36017A;margin-bottom:1rem">Investering</div>
    <h2 class="caslon" style="font-size:2.5rem;font-weight:400;margin-bottom:3rem">[Rubrik]</h2>
    <table style="width:100%;border-collapse:collapse;font-family:'Sofia Pro',sans-serif">
      <thead>
        <tr><th style="text-align:left;padding:.75rem 1rem;border-bottom:2px solid #36017A;
                       font-size:.75rem;font-weight:700;color:#36017A;letter-spacing:.05em">FAS</th>
            <th style="text-align:right;...">KOSTNAD</th></tr>
      </thead>
      <tbody>
        <tr><td style="padding:.9rem 1rem;border-bottom:1px solid #eee">Fas 1</td>
            <td style="text-align:right">XXX 000 SEK</td></tr>
        <tr style="font-weight:700;color:#36017A">
            <td style="padding:.9rem 1rem">Totalt</td>
            <td style="text-align:right">X XXX XXX SEK</td></tr>
      </tbody>
    </table>
  </div>
</section>
```

**Avslutnings-slide (gradient):**
```html
<section style="background:linear-gradient(135deg,#E8C8F0,#FFF8E1);
                display:flex;flex-direction:column;align-items:center;
                justify-content:center;text-align:center;padding:4rem">
  [INLINE LOGO SVG LILA, width:160px, margin-bottom:3rem]
  <h2 style="font-family:'Sofia Pro';font-size:clamp(4rem,10vw,8rem);
             font-weight:700;color:#36017A;margin-bottom:3rem">Tack!</h2>
  <div style="display:grid;grid-template-columns:1fr 1fr;gap:4rem;
              text-align:left;max-width:600px;width:100%">
    <div style="color:#36017A;font-size:.9rem;line-height:2;font-weight:500">
      Instagram: @FrojdAgency<br>LinkedIn: Fröjd Agency<br>Facebook: @FrojdAgency
    </div>
    <div style="color:#36017A;font-size:.9rem;line-height:2;font-weight:500">
      Fröjd Interactive AB<br>Grev Turegatan 1<br>114 46 Stockholm
    </div>
  </div>
</section>
```

---

## PDF-dokument & avtal → egen skill

Dokument som ska **signeras** — offert med villkor, konsultavtal, uppdragsavtal, bilagor i A4-PDF (Pages-stil) — har flyttat till skillen **`frojd-avtal`**. Använd den för allt transaktionellt/juridiskt. Den här skillen fokuserar på säljande webb-offert och pitch.

## REFERENSEXEMPEL — Roschier (PRIMÄRT, senaste stilen)

Filen `assets/Roschier_Proposal_referens.html` är det **ledande exemplet** för Fröjds nuvarande ton, visuella språk, fotoanvändning och case-presentation. Utgå från denna för längre, premiumkänsliga offerter och pitchar. Den bygger vidare på samma CSS-grund som RFSL men tillför flera nya grepp — studera och återanvänd den rakt av.

### Vad Roschier tillför utöver RFSL

- **Kapitel-avdelare** — helbredds-foto med mörk gradient som delar offerten i akter ("How we'll build it." / "After the initial launch." / "Who you'll work with."). Rubrik i **Sofia Pro 700** — detta är det enda stället rubriker INTE är Caslon.
- **Foton genomgående** — bilder hämtas från `showroom.frojd.se` och används i kapitel-avdelare, about-bildspel, design-boards och foto-case.
- **Hero med signatur** — extra meta-fält ("Platform"), kursiv avslutningsrad ("— The team at Fröjd").
- **Innehållstunga sektioner** — AI-migrering, Risks & dependencies, funktionskrav som accordion, two-tracks, AI-search/GEO, thought leadership, ongoing support. Färdiga HTML-block finns under **Standardmoduler**.
- **Foto-case med referenskontakter** — riktiga case med bild och namngiven referensperson, istället för en text-tabell.

### Dokumentstruktur — Roschier-modellen (lång premium-offert)
```
nav (fast, mörk, logo + ankarlänkar)
hero (mörk, h1 Caslon med accent-span, hero-lead, hero-sig kursiv, hero-meta: Klient/Investering/Projekttid/Platform)
section "The assignment" / Uppdraget (muted) — speglar kundens insikt
section "Approach" (dark) — two-tracks
section "AI / shift in behaviour" (light/muted) — searching → asking (GEO)
section "Thought leadership" — möjligheten
chapter-divider ("Så bygger vi det." / "How we'll build it.")
section "Technology" (light) — WordPress-modulen
section "Visual design" (dark) — design-boards
section "AI-assisterad innehållsmigrering"
section "Methodology" — Shape/Ship/Scale
section "Timeline & phases" — interaktiv Gantt
section "Commercials" / Investering — invest-table + allokering
section "Functional requirements" — accordion
section "Risks & dependencies" — numrerad lista med Recommendation
chapter-divider ("Efter lansering." / "After the initial launch.")
section "Ongoing development & support" — fyra områden
chapter-divider ("Vilka du jobbar med." / "Who you'll work with.")
section "Team"
section "Relevant experience & references" — foto-case
section "About Fröjd" (dark) — standardmodul
cta-section + footer (standardmoduler)
```

### Nya CSS-komponenter (kopiera till `<style>`)
```css
/* HERO-signatur + Platform-meta (utöver befintlig hero-CSS) */
.hero-sig { font-size:1rem; color:rgba(255,255,255,0.45); margin-top:1rem; font-style:italic; }

/* KAPITEL-AVDELARE (helbredds-foto, Sofia Pro bold-rubrik) */
.chapter { position:relative; min-height:70vh; display:flex; align-items:flex-end;
           background-size:cover; background-position:center; padding:0 2rem; }
.chapter::before { content:''; position:absolute; inset:0;
                   background:linear-gradient(to top, rgba(0,0,0,0.7), rgba(0,0,0,0.15)); }
.chapter-inner { position:relative; max-width:1280px; margin:0 auto; width:100%; padding-bottom:4rem; }
.chapter-label { font-size:0.7rem; font-weight:700; letter-spacing:0.16em; text-transform:uppercase;
                 color:#E6C4F3; display:block; margin-bottom:0.8rem; }
.chapter h2 { font-family:'Sofia Pro',-apple-system,sans-serif; font-weight:700; /* undantag: Sofia, inte Caslon */
              font-size:clamp(2.2rem,5.5vw,4rem); color:#fff; line-height:1.05; letter-spacing:-0.01em; max-width:900px; }

/* TWO TRACKS */
.tracks-grid { display:grid; grid-template-columns:1fr 1fr; gap:2rem; margin-top:3rem; }
@media (max-width:760px){ .tracks-grid { grid-template-columns:1fr; } }
.track-box { background:#1a1a1a; border:1px solid rgba(255,255,255,0.07); border-radius:8px; padding:2rem 1.9rem; }
.track-box h3 { font-family:'Libre Caslon Text',Georgia,serif; font-weight:400; font-size:1.45rem;
                color:#fff; line-height:1.2; letter-spacing:-0.01em; margin:0.4rem 0 0; }
.track-label { font-size:0.7rem; font-weight:700; letter-spacing:0.14em; text-transform:uppercase;
               color:#E6C4F3; margin-bottom:1rem; display:block; }

/* CONTEXT-CARD med stor stat-siffra */
.context-card .stat { font-family:'Libre Caslon Text',serif; font-size:2.2rem; color:#36017A;
                      display:block; margin-bottom:0.3rem; }
.dark .context-card .stat { color:#E6C4F3; }

/* AI-MIGRERING — tvåkolumn + numrerad process */
.migrate-cols { display:grid; grid-template-columns:1.1fr 0.9fr; gap:3.5rem; margin-top:3rem; align-items:start; }
@media (max-width:760px){ .migrate-cols { grid-template-columns:1fr; gap:2rem; } }
.num-list { list-style:none; counter-reset:n; }
.num-list li { counter-increment:n; position:relative; padding:0.55rem 0 0.55rem 2.2rem; font-size:0.95rem;
               color:#333; border-bottom:1px solid #eee; line-height:1.5; }
.num-list li:before { content:counter(n) "."; position:absolute; left:0; color:#36017A; font-weight:700; }

/* RISKS & DEPENDENCIES */
.risk-list { display:flex; flex-direction:column; gap:1.6rem; margin-top:3rem; max-width:880px; }
.risk-item { display:grid; grid-template-columns:auto 1fr; gap:1.4rem; align-items:start;
             padding-bottom:1.6rem; border-bottom:1px solid #eee; }
.risk-item:last-child { border-bottom:none; }
.risk-num { font-family:'Libre Caslon Text',serif; font-size:1.6rem; color:#36017A; line-height:1; }
.risk-item h3 { font-size:1.2rem; margin-bottom:0.4rem; color:#111; }
.risk-item p { font-size:0.94rem; color:#555; line-height:1.65; }
.risk-item .rec { font-size:0.9rem; color:#36017A; margin-top:0.5rem; }
.risk-item .rec strong { font-weight:700; }

/* FUNKTIONSKRAV — accordion (details/summary) */
.req-grid { display:block; margin-top:2.5rem; max-width:900px; }
.req-group { border-top:1px solid #e2e2e2; }
.req-group:last-child { border-bottom:1px solid #e2e2e2; }
.req-group > summary { list-style:none; cursor:pointer; display:flex; align-items:center; justify-content:space-between;
                       gap:1rem; padding:1.05rem 0; font-size:0.72rem; font-weight:700; letter-spacing:0.12em;
                       text-transform:uppercase; color:#36017A; transition:color 0.2s ease; }
.req-group > summary::-webkit-details-marker { display:none; }
.req-group > summary::after { content:'+'; font-size:1.15rem; font-weight:400; line-height:1; color:#36017A; transition:transform 0.25s ease; }
.req-group[open] > summary::after { content:'\2013'; }
.req-list { list-style:none; padding-bottom:0.9rem; }
.req-list li { position:relative; padding:0.35rem 0 0.35rem 1.3rem; font-size:0.86rem; color:#333;
               border-bottom:1px solid #eee; line-height:1.45; }
.req-list li:last-child { border-bottom:none; }
.req-list li:before { content:'→'; position:absolute; left:0; color:#36017A; font-weight:700; font-size:0.8rem; }
@media print { .req-group > summary::after { display:none; } } /* visa allt i PDF */

/* DESIGN-BOARDS */
.design-figure { margin:2.6rem 0; }
.design-board { width:100%; height:auto; display:block; border-radius:4px; }
.design-figure figcaption { margin-top:0.85rem; font-size:0.8rem; letter-spacing:0.03em; color:rgba(255,255,255,0.55); }

/* FOTO-CASE med referenskontakt */
.cases-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:2rem; margin-top:3rem; }
@media (max-width:900px){ .cases-grid { grid-template-columns:repeat(2,1fr); } }
@media (max-width:600px){ .cases-grid { grid-template-columns:1fr; } }
.case-card { background:#fff; border-radius:4px; overflow:hidden; border:1px solid rgba(0,0,0,0.06);
             display:flex; flex-direction:column; }
.case-image { aspect-ratio:16/10; width:100%; display:block; overflow:hidden; background:#e9e9ee; }
.case-image img { width:100%; height:100%; display:block; object-fit:cover; }
.case-body { padding:1.5rem 1.5rem 1.6rem; flex:1; display:flex; flex-direction:column; }
.case-name { font-size:0.7rem; font-weight:700; letter-spacing:0.14em; text-transform:uppercase; color:#36017A; margin-bottom:0.6rem; }
.case-title { font-family:'Libre Caslon Text',serif; font-size:1.2rem; font-weight:400; letter-spacing:-0.01em;
              line-height:1.25; color:#111; margin-bottom:0.75rem; }
.case-desc { font-size:0.9rem; color:#555; line-height:1.6; }
.case-contact { margin-top:1.1rem; padding-top:1rem; border-top:1px solid rgba(0,0,0,0.08); font-size:0.82rem; color:#555; line-height:1.5; }
.case-contact .clabel { font-size:0.62rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:#999; display:block; margin-bottom:0.35rem; }
.case-link { font-size:0.72rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:#36017A;
             text-decoration:none; margin-top:1.1rem; display:inline-flex; align-items:center; gap:0.4rem; align-self:flex-start; }
.case-link::after { content:'→'; }

/* INTERAKTIV GANTT — tooltips + hover-dim (utöver gantt-CSS i RFSL-avsnittet) */
.gantt:hover .gantt-bar { opacity:0.35; }
.gantt .gantt-bar:hover { opacity:1; }
.gantt-bar[data-tip]:hover::after {
  content:attr(data-tip); position:absolute; bottom:calc(100% + 9px); left:0;
  background:#fff; color:#111; padding:0.55rem 0.75rem; border-radius:5px;
  font-size:0.72rem; font-weight:500; line-height:1.4; width:max-content; max-width:260px;
  white-space:normal; text-align:left; box-shadow:0 8px 28px rgba(0,0,0,0.35); z-index:90; pointer-events:none; }
```

### Platshållar-konvention (VIKTIGT vid leverans)

Markera allt som måste justeras innan offerten skickas:
- **Section-tag med prefix `JUSTERA`** — t.ex. `<span class="section-tag">JUSTERA Relevant experience &amp; references</span>` flaggar att case/innehåll ska bytas ut.
- **Lila platshållartext `#c48edb` / `#b07fd0`** (`.ph`, `.ph-cell`) — för värden som ska fyllas i (namn, pris, bild).
- **Röd text `#c0392b`** — för punkter som måste bekräftas med kund/internt (t.ex. en funktion vars omfattning är öppen).

Ta bort alla `JUSTERA`-flaggor och färgmarkeringar i den slutgiltiga, godkända versionen.

### Bildkälla
Foton hämtas från `showroom.frojd.se` (t.ex. `https://showroom.frojd.se/wp-content/uploads/...`). Be användaren om specifika bild-URL:er, eller använd showroom-bilder som platshållare och flagga dem med `JUSTERA`.

---

## REFERENSEXEMPEL — RFSL-offerten (komplement: ren, avskalad offert-stil)

Filen `assets/RFSL_Offert_referens.html` är ett perfekt exempel på Fröjds **avskalade** offert-stil — använd den för kortare, renodlade offerter utan foton och tunga sektioner. Studera och återanvänd CSS och struktur därifrån. Nedan är nyckelkomponenter att använda:

### Exakt typografi från RFSL-offerten
```css
/* Hero h1 */
font-family: 'Libre Caslon Text', Georgia, serif;
font-size: clamp(2.5rem, 6.2vw, 5rem);
font-weight: 400; /* ALLTID 400 */
letter-spacing: -0.02em;
line-height: 1.05;

/* h2 (sektionsrubriker) */
font-family: 'Libre Caslon Text', Georgia, serif;
font-size: clamp(2rem, 4.5vw, 3.4rem);
font-weight: 400; /* ALLTID 400 */
letter-spacing: -0.02em;
line-height: 1.1;

/* h3 (kortrubriker, teamroller etc) */
font-family: 'Libre Caslon Text', serif;
font-size: 1.2–1.8rem;
font-weight: 400; /* ALLTID 400 */
letter-spacing: -0.01em;

/* section-tag (etikett ovanför h2) */
font-size: 0.7rem; font-weight: 700; letter-spacing: 0.14em;
text-transform: uppercase; color: #36017A;

/* hero .tag (klient + datum) */
font-size: 0.72rem; font-weight: 700; letter-spacing: 0.18em;
color: #E6C4F3; text-transform: uppercase;
```

### Sektionsbakgrunder
```css
.dark  { background: #111; color: #fff; }
.light { background: #fff; color: #111; }
.muted { background: #F9F9F9; color: #111; }

/* Sektion-padding */
.section { padding: 6rem 3rem; }
.section-inner { max-width: 1280px; margin: 0 auto; }
```

### Komponenter

**Context-cards (grid med insikter/bakgrundspunkter):**
```html
<div class="context-grid"> <!-- grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)) -->
  <div class="context-card">
    <h3>[Rubrik]</h3>
    <p>[Text]</p>
  </div>
</div>
```
Mörk variant: `background: #1a1a1a; border: 1px solid rgba(255,255,255,0.06);`
Ljus variant: `background: #F9F9F9; border: 1px solid rgba(0,0,0,0.05);`

**Insights (vänsterkant + Caslon-rubrik):**
```html
<div class="insights">
  <div class="insight"> <!-- border-left: 3px solid #36017A; padding-left: 1.5rem -->
    <h3>[Caslon Regular 1.4rem]</h3>
    <p>[Text]</p>
  </div>
</div>
```

**Shape/Ship/Scale — approach-flow:**
```html
<div class="approach-flow">
  <!-- grid-template-columns: 1fr auto 1fr auto 1fr -->
  <div class="phase-pill">Shape</div>
  <div class="phase-arrow">→</div>
  <div class="phase-pill">Ship</div>
  <div class="phase-arrow">→</div>
  <div class="phase-pill">Scale</div>
</div>
<!-- phase-pill: background: #E6C4F3; color: #111; border-radius: 100px; font-weight: 600 -->
```

**Timeline (projektfaser med linje):**
```html
<div class="timeline">
  <div class="timeline-item"> <!-- padding-left: 3rem; ::before = lila punkt; ::after = vertikal linje -->
    <span class="timeline-duration">SHAPE — CA 4 VECKOR</span>
    <h3>[Caslon Regular 1.8rem]</h3>
    <p class="timeline-desc">[Beskrivning]</p>
    <div class="timeline-activities">
      <div class="act-col">
        <h4>[KOLUMNRUBRIK]</h4>
        <ul><li>[Aktivitet]</li></ul>
      </div>
    </div>
    <div class="timeline-outcome">
      <strong>Utkomst</strong>
      [Text]
    </div>
  </div>
</div>
```

**Allokerings-staplar:**
```html
<div class="alloc-row"> <!-- grid: 220px 1fr 80px -->
  <span class="alloc-label">Projektledning</span>
  <div class="alloc-bar-bg"><div class="alloc-bar-fill" style="width:30%"></div></div>
  <span class="alloc-pct">30%</span>
</div>
```

**Investerings-tabell:**
```html
<table class="invest-table">
  <thead><tr>
    <th>Fas</th><th>Veckor</th><th>Allokering</th><th>Kostnad</th>
  </tr></thead>
  <tbody>
    <tr><td>Shape<span class="sub">Förstudien</span></td>...</tr>
    <tr class="total"><td>Totalt</td>...<td>808 000 SEK</td></tr>
  </tbody>
</table>
```

**Gantt-diagram (tidplan):**
```html
<div class="gantt">
  <div class="gantt-grid">
    <div class="gantt-header">
      <div></div>
      <div class="gantt-months"><span>Jun</span><span>Jul</span>...</div>
    </div>
    <div class="gantt-row">
      <div class="gantt-label"><strong>Shape</strong><small>Förstudie</small></div>
      <div class="gantt-track">
        <div class="gantt-bar" style="grid-column: 1/3">SHAPE</div>
      </div>
    </div>
  </div>
</div>
```

**Maintenance-cards (efter lansering):**
```html
<div class="maint-card featured"> <!-- featured = lila bakgrund #36017A -->
  <span class="level">Rekommenderat</span>
  <h3>[Caslon Regular]</h3>
  <ul><li>[Ingår]</li></ul>
  <div class="price">[Pris]<small>[Frekvens]</small></div>
</div>
```

**CTA-sektion (avslutning):**
```html
<section class="cta-section"> <!-- gradient: #E8C8F0 → #FFF8E1 -->
  <div class="cta-inner">
    <h2>[Caslon Regular, inbjudande]</h2>
    <p>[Ingress]</p>
    <a href="mailto:..." class="cta-btn">Kontakta oss</a>
  </div>
</section>
```

**Footer (mörk, tre kolumner):**
```html
<footer> <!-- background: #111 -->
  <div class="footer-inner">
    <div class="footer-col">[Logotyp vit] + kontaktinfo</div>
    <div class="footer-col"><p><strong>Kontakt</strong><br>...</p></div>
    <div class="footer-col"><p><strong>Följ oss</strong><br>frojd.se · @FrojdAgency<br>Del av Eidra</p></div>
  </div>
</footer>
```

### Hero-struktur (RFSL-modellen)
```html
<section class="hero" id="top">
  <div class="hero-inner">
    <span class="tag">[KLIENTNAMN] — [DATUM]</span>
    <h1>[Stor rubrik med <span>accentfärgad del</span>.</h1>
    <p class="hero-lead">[Inledning, vad offerten är]</p>
    <p class="hero-lead">/Teamet på Fröjd</p>
    <div class="hero-meta">
      <div class="meta-item">
        <span class="meta-label">Investering</span>
        <span class="meta-value">[XXX 000 SEK]</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">Projekttid</span>
        <span class="meta-value">ca XX veckor</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">Lansering</span>
        <span class="meta-value">[Q1 20XX]</span>
      </div>
    </div>
  </div>
</section>
```

---

## Standardmoduler (SV + EN)

Återanvändbara standardmoduler. Använd dem rakt av och välj språkversion (svenska eller engelska) efter offerten. De bygger på CSS-klasserna nedan (lägg in i `<style>` tillsammans med övrig CSS).

### Modul-CSS

```css
/* Om Fröjd — text + bild-bildspel */
.about-grid { display:grid; grid-template-columns:1.1fr 0.9fr; gap:3.5rem; align-items:center; margin-top:1rem; }
.about-image { position:relative; overflow:hidden; border-radius:10px; min-height:360px; background:#2a2a2a; border:1px solid rgba(255,255,255,0.1); }
.about-image .slide { position:absolute; inset:0; background-size:cover; background-position:center; opacity:0; animation:aboutfade 18s infinite; }
.about-image .slide:nth-child(2){ animation-delay:6s; }
.about-image .slide:nth-child(3){ animation-delay:12s; }
@keyframes aboutfade { 0%{opacity:0;} 4%{opacity:1;} 30%{opacity:1;} 38%{opacity:0;} 100%{opacity:0;} }
@media (max-width:860px){ .about-grid { grid-template-columns:1fr; gap:2rem; } .about-image { min-height:240px; } }

/* Feature-kort (topp-border) — t.ex. WordPress-modulen */
.feature-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(280px,1fr)); gap:2rem; margin-top:3.5rem; }
.feature-card { background:#fff; border:1px solid rgba(0,0,0,0.08); border-top:2px solid #36017A; border-radius:0 0 4px 4px; padding:2rem 1.8rem; }
.feature-label { font-size:0.7rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:#36017A; display:block; margin-bottom:1rem; }
.feature-card h3 { font-size:1.5rem; color:#111; margin-bottom:0.8rem; line-height:1.2; }
.feature-card p { font-size:0.95rem; color:#555; line-height:1.7; }
.feature-note { border-left:3px solid #36017A; padding-left:1.6rem; margin-top:3rem; max-width:880px; }
.feature-note h3 { font-size:1.4rem; color:#111; margin-bottom:0.6rem; }
.feature-note p { font-size:0.98rem; color:#555; line-height:1.7; }
.dark .feature-note { border-left-color:#E6C4F3; }
.dark .feature-note h3 { color:#fff; }
.dark .feature-note p { color:rgba(255,255,255,0.7); }

/* Shape–Ship–Scale: pills med beskrivning under */
.approach-flow { display:flex; align-items:flex-start; gap:1.25rem; margin-top:3.5rem; }
.phase-step { flex:1; display:flex; flex-direction:column; gap:1.6rem; }
.phase-pill { background:#E6C4F3; color:#111; border-radius:100px; padding:1.1rem 1.5rem; font-weight:600; font-size:1.05rem; text-align:center; }
.phase-arrow { color:#E6C4F3; font-size:1.4rem; font-weight:700; height:3.4rem; display:flex; align-items:center; flex:0 0 auto; }
.phase-desc { font-size:0.92rem; line-height:1.65; text-align:center; color:#555; }
.dark .phase-desc { color:rgba(255,255,255,0.65); }
@media (max-width:760px){ .approach-flow { flex-direction:column; align-items:stretch; } .approach-flow .phase-arrow { display:none; } }
```

### 1. Om Fröjd / About Fröjd (standard)

Standardstycket om Fröjd — använd exakt så här. Mörk sektion, text till vänster och ett mjukt korsfadande bildspel till höger (byt ut bild-URL:erna). Service-korten är generiska och ska normalt stå oförändrade.

**Engelska:**
```html
<section class="section dark" id="overview">
  <div class="section-inner">
    <span class="section-tag">About Fröjd</span>
    <h2>We build digital services that drive growth and last.</h2>
    <div class="about-grid">
      <div>
        <p class="lead">Fröjd is a Stockholm-based digital agency that is part of <strong>Eidra</strong>, a collective of leading Nordic agencies.</p>
        <p class="lead">With 20 years of experience, our 50 specialists design, build and continuously improve content-rich, high-traffic websites for brands that care about both craft and measurable results.</p>
        <p class="lead">We have strong client relationships and documented high client satisfaction, and we've been awarded Excellence in Customer Relations by Regi. Both our clients and our people stay with us for a long time.</p>
      </div>
      <div class="about-image">
        <div class="slide" style="background-image:url('[BILD 1]')"></div>
        <div class="slide" style="background-image:url('[BILD 2]')"></div>
        <div class="slide" style="background-image:url('[BILD 3]')"></div>
      </div>
    </div>
    <div class="context-grid">
      <div class="context-card"><h3>Technology &amp; development</h3><p>Scalable, future-proof technology that grows with you — built with the engineering discipline to stay fast, secure and easy to maintain. We help you make the most of what the technology can do, on a foundation that's ready for whatever comes next.</p></div>
      <div class="context-card"><h3>Design &amp; interaction</h3><p>Precise design that elevates your brand and the user experience across every touchpoint. We design with intent — balancing craft, clarity and conversion so the experience both looks right and performs.</p></div>
      <div class="context-card"><h3>Content &amp; visibility</h3><p>Content that lands across the whole journey, building organic visibility and converting attention into action — including SEO and the new frontier of AI-driven search (GEO).</p></div>
      <div class="context-card"><h3>Scale &amp; optimise</h3><p>A nimble, data-driven process for continuous improvement after launch, so the site keeps getting measurably better — not frozen at go-live.</p></div>
    </div>
  </div>
</section>
```

**Svenska:**
```html
<section class="section dark" id="overview">
  <div class="section-inner">
    <span class="section-tag">Om Fröjd</span>
    <h2>Vi skapar digitala tjänster som driver tillväxt och håller över tid.</h2>
    <div class="about-grid">
      <div>
        <p class="lead">Fröjd är en Stockholmsbaserad digitalbyrå och en del av <strong>Eidra</strong>, ett kollektiv av ledande nordiska byråer.</p>
        <p class="lead">Med 20 års erfarenhet designar, bygger och vidareutvecklar våra 50 specialister innehållsrika webbplatser med hög trafik — för varumärken som bryr sig om både hantverk och mätbara resultat.</p>
        <p class="lead">Vi har starka kundrelationer och dokumenterat hög kundnöjdhet, och har tilldelats Excellence in Customer Relations av Regi. Både våra kunder och våra medarbetare stannar länge hos oss.</p>
      </div>
      <div class="about-image">
        <div class="slide" style="background-image:url('[BILD 1]')"></div>
        <div class="slide" style="background-image:url('[BILD 2]')"></div>
        <div class="slide" style="background-image:url('[BILD 3]')"></div>
      </div>
    </div>
    <div class="context-grid">
      <div class="context-card"><h3>Teknik och utveckling</h3><p>Skalbar och framtidssäkrad teknik som växer med er — byggd med den ingenjörsdisciplin som krävs för att hålla sajten snabb, säker och enkel att förvalta. Vi hjälper er tillvarata teknikens möjligheter, på en grund som är redo för det som komma skall.</p></div>
      <div class="context-card"><h3>Design och interaktion</h3><p>Träffsäker design som lyfter ert varumärke och användarupplevelsen i varje kontaktyta. Vi designar med avsikt — och balanserar hantverk, tydlighet och konvertering så att upplevelsen både ser rätt ut och presterar.</p></div>
      <div class="context-card"><h3>Innehåll och synlighet</h3><p>Innehåll som träffar rätt genom hela kundresan, bygger organisk synlighet och omvandlar uppmärksamhet till handling — inklusive SEO och nästa steg: AI-driven sökning (GEO).</p></div>
      <div class="context-card"><h3>Skala och optimera</h3><p>En snabbfotad, datadriven process för kontinuerlig förbättring efter lansering — så att sajten fortsätter bli mätbart bättre, inte fryst vid go-live.</p></div>
    </div>
  </div>
</section>
```

### 2. Sidfot / Footer (standard)

Standardsidfoten. **Kontaktkolumnen hämtar ALLTID uppgifter från den person som är avsändare för offerten** — namn, e-post och telefonnummer. Office (Grev Turegatan 1) och Follow är fasta. Logotypen bäddas in som inline vit SVG (se `assets/fro_jd-vit.svg`).

**Engelska:**
```html
<footer>
  <div class="footer-inner">
    <div class="footer-col">[INLINE VIT LOGO-SVG]</div>
    <div class="footer-col">
      <p><strong>Contact</strong><br>
      [AVSÄNDARENS NAMN]<br>
      <a href="mailto:[AVSÄNDARENS E-POST]">[AVSÄNDARENS E-POST]</a><br>
      [AVSÄNDARENS TELEFON]</p>
    </div>
    <div class="footer-col">
      <p><strong>Office</strong><br>
      Grev Turegatan 1<br>
      114 46 Stockholm</p>
    </div>
    <div class="footer-col">
      <p><strong>Follow</strong><br>
      <a href="https://www.frojd.se">frojd.se</a> · @FrojdAgency<br>
      Part of Eidra</p>
    </div>
  </div>
</footer>
```

**Svenska:** samma struktur, men rubrikerna `Kontakt`, `Kontor` och `Följ oss` (kontaktuppgifterna är fortfarande avsändarens).

### 3. WordPress (valfri modul — när WordPress är aktuellt)

Använd när uppdraget gäller WordPress. Ljus sektion med tre feature-kort + en ärlig "honest opinion"-not som även nämner headless-alternativ (Payload/Umbraco).

**Engelska:**
```html
<section class="section light" id="technology">
  <div class="section-inner">
    <span class="section-tag">Technology</span>
    <h2>We build in WordPress to last.</h2>
    <p class="lead">WordPress is a flexible platform that can perform very differently depending on how the solution is built. With nearly 20 years of experience, we know what it takes to make WordPress perform at its very best.</p>
    <div class="feature-grid">
      <div class="feature-card"><span class="feature-label">Modular page templates in Gutenberg</span><p>We build flexible, module-based page templates in Gutenberg where the editor experience sits as close as possible to the public site. That makes it easy for you to create and update content on your own — without risking that the layout breaks.</p></div>
      <div class="feature-card"><span class="feature-label">Security and performance</span><p>We follow WordPress standards and keep the number of plugins down, since they can have a major impact on both security and performance. Custom functionality is built into the theme, not stacked on through third-party plugins.</p></div>
      <div class="feature-card"><span class="feature-label">Maintainable for the long term</span><p>We build so the solution can live and evolve for many years. Code in version control, clear documentation and an architecture that makes it easy for us — or anyone else — to take over.</p></div>
    </div>
    <div class="feature-note">
      <h3>Our honest opinion — and the future-proof alternatives.</h3>
      <p>We can absolutely give you an excellent website in WordPress. That said, we want to be open about the trade-offs. WordPress doesn't sit on the most modern technology stack, and it isn't headless. For this project that trade-off is reasonable: it's what you already run, and it gives your editors real autonomy on a proven foundation. If you want a more future-proofed, decoupled architecture, we also design and build headless solutions in, for example, Payload or Umbraco. We're happy to weigh WordPress against those options together, so the platform decision is made deliberately.</p>
    </div>
  </div>
</section>
```

**Svenska:**
```html
<section class="section light" id="technology">
  <div class="section-inner">
    <span class="section-tag">Teknik</span>
    <h2>Vi bygger i WordPress för att hålla över tid.</h2>
    <p class="lead">WordPress är en flexibel plattform som kan prestera väldigt olika beroende på hur lösningen byggs. Med snart 20 års erfarenhet vet vi vad som krävs för att WordPress ska prestera på sitt allra bästa.</p>
    <div class="feature-grid">
      <div class="feature-card"><span class="feature-label">Modulära sidmallar i Gutenberg</span><p>Vi bygger flexibla, modulbaserade sidmallar i Gutenberg där redaktörsupplevelsen ligger så nära den publika sajten som möjligt. Det gör det enkelt för er att skapa och uppdatera innehåll på egen hand — utan att riskera att layouten går sönder.</p></div>
      <div class="feature-card"><span class="feature-label">Säkerhet och prestanda</span><p>Vi följer WordPress-standarder och håller nere mängden plugins, eftersom de kan ha stor inverkan på både säkerhet och prestanda. Specialfunktioner byggs in i temat, inte staplas på via tredjepartsplugins.</p></div>
      <div class="feature-card"><span class="feature-label">Långsiktigt förvaltbart</span><p>Vi bygger för att lösningen ska kunna leva och utvecklas i många år. Kod i versionshantering, tydlig dokumentation och en arkitektur som gör det enkelt för oss — eller någon annan — att ta vid.</p></div>
    </div>
    <div class="feature-note">
      <h3>Vår ärliga åsikt — och de framtidssäkra alternativen.</h3>
      <p>Vi kan absolut ge er en riktigt bra webbplats i WordPress. Med det sagt vill vi vara öppna med avvägningarna. WordPress vilar inte på den mest moderna teknikstacken, och det är inte headless. För det här projektet är den avvägningen rimlig: det är vad ni redan kör, och det ger era redaktörer verklig autonomi på en beprövad grund. Vill ni ha en mer framtidssäkrad, frikopplad arkitektur bygger vi även headless-lösningar i exempelvis Payload eller Umbraco. Vi väger gärna WordPress mot de alternativen tillsammans, så att plattformsbeslutet fattas medvetet.</p>
    </div>
  </div>
</section>
```

### 4. Shape – Ship – Scale (valfri modul — processöversikt)

Standardmodulen för att presentera processen. Mörk sektion med tre pills och en kort beskrivning under varje, pilar emellan. **Den projektspecifika meningen "Because your pre-study has already done the heavy lifting on insight, we plug straight into it and move fast to a prototype." ska INTE vara med i standardutförandet.**

**Engelska:**
```html
<section class="section dark" id="approach">
  <div class="section-inner">
    <span class="section-tag">Approach &amp; methodology</span>
    <h2>Shape, Ship, Scale.</h2>
    <p class="lead">Our process is built to reduce risk early and keep improving after launch. We want something concrete to rally around early — something we can iterate until it lands right. That reduces risk, makes decisions easier, and ensures we build the right thing from the start.</p>
    <div class="approach-flow">
      <div class="phase-step"><div class="phase-pill">Shape</div><p class="phase-desc">We understand the why and form the how.</p></div>
      <div class="phase-arrow">→</div>
      <div class="phase-step"><div class="phase-pill">Ship</div><p class="phase-desc">We detail, build and launch.</p></div>
      <div class="phase-arrow">→</div>
      <div class="phase-step"><div class="phase-pill">Scale</div><p class="phase-desc">We track, analyze and optimise.</p></div>
    </div>
  </div>
</section>
```

**Svenska:**
```html
<section class="section dark" id="approach">
  <div class="section-inner">
    <span class="section-tag">Vår approach</span>
    <h2>Shape, Ship, Scale.</h2>
    <p class="lead">Vår process är byggd för att minska risken tidigt och fortsätta förbättra efter lansering. Vi vill tidigt ha något konkret att samlas kring — något som kan itereras tills det landar rätt. Det minskar risken, gör besluten enklare och säkerställer att vi bygger rätt sak från start.</p>
    <div class="approach-flow">
      <div class="phase-step"><div class="phase-pill">Shape</div><p class="phase-desc">Vi förstår varför och formar hur.</p></div>
      <div class="phase-arrow">→</div>
      <div class="phase-step"><div class="phase-pill">Ship</div><p class="phase-desc">Vi detaljerar, bygger och lanserar.</p></div>
      <div class="phase-arrow">→</div>
      <div class="phase-step"><div class="phase-pill">Scale</div><p class="phase-desc">Vi följer upp, analyserar och optimerar.</p></div>
    </div>
  </div>
</section>
```

---

### 5. AI-assisterad innehållsmigrering (differentiator)

Stark säljmodul när uppdraget innehåller migrering. Vänsterkolumn = berättelse, högerkolumn = numrerad process. CSS: `.migrate-cols`, `.num-list`. **Engelsk förlaga finns i Roschier-referensen (id="migration").**

**Svenska:**
```html
<section class="section light" id="migration">
  <div class="section-inner">
    <span class="section-tag">AI-assisterad innehållsmigrering</span>
    <h2>En migrering som förbättrar innehållet — inte bara flyttar det.</h2>
    <div class="migrate-cols">
      <div>
        <p class="lead">En klassisk migrering är beroende av att det gamla systemet exporterar rena data av god kvalitet — en komplex, tidskrävande process som ofta innebär manuellt arbete för allt som inte exporteras snyggt.</p>
        <p class="body">Med modern AI-tooling bygger vi intelligenta, automatiserade flöden som extraherar, strukturerar och migrerar innehåll mellan system — även från äldre plattformar där en ren export inte är ett alternativ. AI:n gör grovjobbet, men människor har kontrollen hela vägen: varje ändring granskas av oss, och inget ändras eller publiceras utan ert godkännande.</p>
        <h3 style="margin-top:2rem;font-size:1.3rem">Vad det tillför</h3>
        <ul class="check-list">
          <li>En AI-genererad SEO-analys rekommenderar vilket innehåll som ska behållas, slås ihop eller tas bort.</li>
          <li>AI förbättrar innehållet medan det flyttas — tonalitet, stavning, läsbarhet och tillgänglighet.</li>
          <li>AI genererar och förbättrar SEO och strukturerad metadata — titlar, beskrivningar, Open Graph och JSON-LD — så att sajten blir lättare för AI-driven sök att läsa (GEO).</li>
        </ul>
      </div>
      <div>
        <h4 class="col-label" style="margin-bottom:1rem">Processen</h4>
        <ol class="num-list">
          <li>Inventering &amp; innehållsanalys</li>
          <li>Strukturering av innehållet</li>
          <li>Mappning &amp; designförutsättningar</li>
          <li>Innehållsoptimering &amp; testmigrering</li>
          <li>Migrering &amp; redirect-plan</li>
          <li>Genomförande &amp; lansering</li>
        </ol>
      </div>
    </div>
  </div>
</section>
```

### 6. Risks & dependencies — risker med rekommendation

Bygger förtroende. Varje risk får en kort beskrivning + en `Recommendation:` (oftast "löses i Shape"). CSS: `.risk-list`, `.risk-item`, `.risk-num`, `.rec`.

**Svenska:**
```html
<section class="section light" id="risks">
  <div class="section-inner">
    <span class="section-tag">Risker &amp; beroenden</span>
    <h2>Riskerna vi ser — och hur vi hanterar dem.</h2>
    <p class="lead">Varje innehållstung migrering bär på ett par förutsägbara risker. Vi namnger dem hellre nu än möter dem senare — och de flesta är lösta, eller tydligt minskade, redan i Shape-fasen.</p>
    <div class="risk-list">
      <div class="risk-item">
        <div class="risk-num">01</div>
        <div>
          <h3>[Riskens rubrik]</h3>
          <p>[Kort beskrivning av risken och varför den spelar roll.]</p>
          <p class="rec"><strong>Rekommendation:</strong> [hur vi hanterar den, oftast i Shape].</p>
        </div>
      </div>
      <!-- upprepa risk-item 02, 03, ... -->
    </div>
  </div>
</section>
```

### 7. Kapitel-avdelare (full-bredd foto)

Delar längre offerter i akter. **Rubrik i Sofia Pro 700, inte Caslon** (enda undantaget). Byt ut bild-URL (showroom.frojd.se). CSS: `.chapter`.

```html
<section class="chapter" id="chapter-build"
         style="background-image:url('https://showroom.frojd.se/wp-content/uploads/.../bild.webp')">
  <div class="chapter-inner">
    <span class="chapter-label">[VALFRI ETIKETT]</span>
    <h2>Så bygger vi det.</h2>  <!-- EN: "How we'll build it." -->
  </div>
</section>
```
Vanliga avdelare: "Så bygger vi det." · "Efter lansering." · "Vilka du jobbar med." (EN: "How we'll build it." · "After the initial launch." · "Who you'll work with.")

### 8. AI-search / GEO — "från att söka till att fråga"

Tematisk sektion om skiftet i sökbeteende. Använd context-cards med `.stat` för siffror.

**Svenska:**
```html
<section class="section muted" id="ai">
  <div class="section-inner">
    <span class="section-tag">Ett tydligt skifte i beteende</span>
    <h2>Användare går från att söka till att fråga.</h2>
    <p class="lead">Sättet människor hittar information förändras i grunden: allt fler börjar i en AI-assistent istället för en sökruta, och svaret kommer som ett samtal snarare än en sida med länkar. Vi bygger innehåll och struktur så att Roschier syns även där — det vi kallar GEO (AI-driven sökning).</p>
  </div>
</section>
```

### 9. Thought leadership som möjlighet

**Svenska:**
```html
<section class="section light" id="thought-leadership">
  <div class="section-inner">
    <span class="section-tag">En möjlighet</span>
    <h2>Den nya sajten är en plattform för thought leadership.</h2>
    <p class="lead">Utöver att förnya det som finns är den nya sajten en chans att göra mer: producera innehåll som drar in människor, bygger varumärket och ger [klient] något att prata om — och sedan omvandlar den uppmärksamheten till handling.</p>
  </div>
</section>
```

### 10. Visual design med design-boards

Mörk sektion där design-riktningen visas med bilder. CSS: `.design-figure`, `.design-board`, `figcaption`.

```html
<section class="section dark" id="design">
  <div class="section-inner">
    <span class="section-tag">Visuell design</span>
    <h2>En tydlig riktning: redaktionell &amp; samtida.</h2>
    <p class="lead">[Beskrivning av designriktningen utifrån kundens referenser.]</p>
    <figure class="design-figure">
      <img class="design-board" src="https://showroom.frojd.se/wp-content/uploads/.../board.webp" alt="">
      <figcaption>[Bildtext som beskriver riktningen]</figcaption>
    </figure>
  </div>
</section>
```

### 11. Funktionskrav som accordion

Hopfällbara grupper av krav. Fälls ut på skärm, visas helt i PDF (via `@media print`). CSS: `.req-grid`, `.req-group`, `.req-list`. Markera öppna/osäkra punkter med `style="color:#c0392b"`.

```html
<section class="section light" id="requirements">
  <div class="section-inner">
    <span class="section-tag">Förutsättningar</span>
    <h2>Funktionskrav &amp; kommersiella antaganden</h2>
    <p class="lead">En samlad bild av funktionerna från er brief och förstudie — det vi designar, bygger och prissätter mot.</p>
    <div class="req-grid">
      <details class="req-group" open>
        <summary>[Gruppnamn, t.ex. Personer &amp; profiler]</summary>
        <ul class="req-list">
          <li>[Krav]</li>
          <li style="color:#c0392b">[Krav som måste bekräftas — öppen omfattning]</li>
        </ul>
      </details>
      <!-- fler details.req-group -->
    </div>
  </div>
</section>
```

### 12. Ongoing development & support (fyra områden)

Efter lansering — använd context-grid med fyra kort. "Launch is a starting point, not a finish line."

**Svenska:**
```html
<section class="section muted" id="post-launch">
  <div class="section-inner">
    <span class="section-tag">Vidareutveckling &amp; förvaltning</span>
    <h2>Fyra sätt vi håller sajten igång efter lansering.</h2>
    <p class="lead">Lansering är en startpunkt, inte en mållinje. Vi stannar nära och hjälper er driva, vässa och utveckla sajten över tid — inom fyra områden.</p>
    <div class="context-grid">
      <div class="context-card"><h3>[Område 1]</h3><p>[Beskrivning]</p></div>
      <div class="context-card"><h3>[Område 2]</h3><p>[Beskrivning]</p></div>
      <div class="context-card"><h3>[Område 3]</h3><p>[Beskrivning]</p></div>
      <div class="context-card"><h3>[Område 4]</h3><p>[Beskrivning]</p></div>
    </div>
  </div>
</section>
```

### 13. Foto-case med referenskontakt

Ersätter text-tabellen för case i premium-offerter. Tre kort med bild, rubrik, beskrivning och (valfritt) namngiven referensperson. CSS: `.cases-grid`, `.case-card`, `.case-contact`. Flagga sektionen med `JUSTERA` tills rätt case valts.

```html
<section class="section light" id="experience">
  <div class="section-inner">
    <span class="section-tag">JUSTERA Relevant erfarenhet &amp; referenser</span>
    <h2>Innehållsrika sajter byggda för thought leadership och leadgenerering.</h2>
    <p class="lead">Ett urval av vårt arbete, valt för att spegla prioriteringarna bakom det här projektet.</p>
    <div class="cases-grid">
      <div class="case-card">
        <div class="case-image"><img src="https://showroom.frojd.se/wp-content/uploads/.../case.webp" alt=""></div>
        <div class="case-body">
          <div class="case-name">[Klient]</div>
          <div class="case-title">[Case-rubrik]</div>
          <p class="case-desc">[Kort beskrivning + resultat/nyckeltal]</p>
          <div class="case-contact">
            <span class="clabel">Referens</span>
            <strong>[Namn]</strong>, [Titel]<br>[E-post / telefon]
          </div>
          <a class="case-link" href="[URL]">Besök sajten</a>
        </div>
      </div>
      <!-- upprepa för 2–3 case -->
    </div>
  </div>
</section>
```

---

## Arbetsflöde

1. **Default är en scrollbar HTML-sida** (LÄGE 1). Bygg slides (LÄGE 2) bara när det ska presenteras live — fråga om det är oklart. (Ska dokumentet signeras — avtal eller offert för underskrift — använd skillen `frojd-avtal` istället.)
2. **Språk:** svenska som default. Engelska när användaren ber om det eller mottagaren är engelskspråkig — fråga om det är oklart.
3. **Välj referens:** Roschier (`assets/Roschier_Proposal_referens.html`) för längre premium-offerter med foto, case och tunga sektioner; RFSL för kortare, avskalade offerter.
4. **Samla** klient, uppdrag, faser, budget — be om brief om det behövs
5. **Läs** `assets/sofia_pro_embedded.css` och `assets/libre_caslon_embedded.css` — inkludera hela innehållet i `<style>`
6. **Läs** logotyp-SVG och bädda in inline i HTML
7. **Generera** HTML-fil enligt rätt läge. Markera platshållare med `JUSTERA`/färg och städa bort dem i slutversionen.
8. **För PDF:** konvertera med `weasyprint` direkt — spara både `.html` och `.pdf`
9. **Spara** till `/mnt/user-data/outputs/[klient]_[typ].html` och `.pdf`
10. **Presentera** PDF med `present_files`

---

## Fröjd-fakta

Hårda fakta — företagsuppgifter, org.nr, adress, timpriser och betalvillkor — bor i skillen **`frojd-fakta`**. Läs in den när du behöver priser eller kontaktuppgifter. Uppdatera fakta där, inte här.

Case-material bor i den här skillen: Roschier- och RFSL-referenserna samt det utförliga Zeta-caset nedan (teknikval, budgetmetodik, lärdomar) — eftersom det handlar om hur man resonerar i en pitch.

---

## Utförligt referenscase: Zeta (zeta.nu)

### Om uppdraget
- **Klient:** Zeta / Di Luca & Di Luca AB — en av Sveriges mest besökta matsajter
- **Bransch:** Livsmedel / FMCG (italiensk mat och medelhavsmat sedan 1971)
- **Nuvarande teknik:** WordPress 6.x med custom-tema (dijoy-b2c)
- **Innehåll:** Hundratals recept (strukturerad data: ingredienser, steg, tider), produktkatalog (~400 produkter), olivoljeguider, kunskapsartiklar
- **Uppdrag:** Ny webbplattform med headless arkitektur. Content first. Modern sökfunktion. Teknisk framtidssäkring — inte designomtag.
- **Format:** Både scrollbar offert (HTML-webbsida) och pitch (Reveal.js slides)
- **Budget:** 1 610 000 SEK exkl. moms / 1 155 timmar / 20 veckor

### Resonemang kring tekniska val

**Headless arkitektur — JA, men av rätt skäl:**
Motivet för Zeta är inte omnikanalsleverans. Det är prestanda (Next.js med ISR ger receptsidor på millisekunder istället för sekunder), bättre Core Web Vitals (direkt SEO-påverkan för en sajt som lever på organisk trafik), och redaktionell flexibilitet (modernt CMS med live preview, versionering, rollhantering).

**CMS-val — ÖPPET, utvärdera i Shape:**
Första utkastet låste sig vid Payload CMS. Det reviderades efter kritisk granskning:
- **Payload CMS:** TypeScript-native, öppen källkod, bra DX. Men yngre ekosystem och svagare redaktörsupplevelse för icke-tekniska användare.
- **Sanity:** Mogen strukturerad content-modell (perfekt för recept), stark redaktörsupplevelse. Men proprietärt med löpande kostnad.
- **Headless WordPress:** Redaktörerna slipper lära sig nytt, all content-modellering finns redan, minst migreringsrisk. Men fortfarande WP-beroende och begränsad DX.

**Slutsats:** CMS-valet bör göras i Shape-fasen baserat på redaktionens arbetssätt — inte i offerten. Det ökar trovärdigheten och minskar risken.

**Sök — ÖPPET, prototypa i Shape:**
Första utkastet lovade "AI-drivet sök med vektordatabas och embeddings". Det reviderades:
- Algolia/Typesense ger 80% av värdet till 20% av komplexiteten (instant search, fuzzy matching, facetterad filtrering)
- Semantisk AI-sök förstår kontext men kräver löpande underhåll och driftskostnader
- Offerten presenterar söklösningen som en utforskningsfråga i Shape. Prototypa med riktigt innehåll, välj baserat på data.

**Prestandaargumentet var nyckeln:**
Det starkaste säljargumentet: mätbar prestandaförbättring. Next.js med ISR, bättre Core Web Vitals, bättre SEO-ranking, bättre användarupplevelse. Konkret och mätbart — inte abstrakt "framtidssäkring".

### Budgetmetodik

**Timpris:** 1 325 SEK/h (enhetligt, alla roller)
**Marginal:** 5% på totalen
**Formel:** Timmar × 1 325 × 1,05 = Fasbudget

| Fas | Veckor | Timmar | Kostnad |
|-----|--------|--------|---------|
| Shape | 4 | 150 | 210 000 SEK |
| Ship | 12 | 885 | 1 230 000 SEK |
| Scale | 4 | 120 | 170 000 SEK |
| **Totalt** | **20** | **1 155** | **1 610 000 SEK** |

**Shape (150h):** Tech Lead 50h, Utvecklare 40h, UX 25h, PL 25h, SEO 10h
**Ship (885h):** Tech Lead 140h, Utvecklare 1 280h, Utvecklare 2 260h, UX 70h, PL 100h, SEO 35h
**Scale (120h):** Tech Lead 30h, Utvecklare 50h, SEO 25h, PL 15h

**Budgetjustering som gjordes:** Ship sattes först till 10 veckor / 900 tkr. Reviderades uppåt till 12 veckor / 1 230 tkr efter granskning — WordPress-migreringen (strukturerad data, relationer, media) och söklösningen kräver mer tid.

### Lärdomar

1. **Lås inte teknikval i offerten** om det finns genuina alternativ — lägg utvärdering i Shape.
2. **Tryck på prestanda** för sajter med organisk trafik — det är konkret och mätbart.
3. **Räkna baklänges från timmar.** Om siffrorna inte går ihop, justera scopet — inte timmarna.
4. **Migrering underskattas alltid.** WordPress-data har specialfält, relationer och inkonsistenser. Räkna 150–200h.
5. **Ship-fasen ska inte pressas.** Bättre 12 veckor med kvalitet än 10 veckor med budgetdiskussioner.
