---
name: frojd-avtal
description: Skapar offerter och avtal för underskrift som A4-PDF i Fröjd Interactive ABs faktiska dokumentstil (Pages-mall). Använd denna skill när användaren vill ta fram något som ska signeras — offert med villkor, konsultavtal, uppdragsavtal, samarbetsavtal, bilaga eller annat juridiskt/transaktionellt dokument. Trigga på avtal, konsultavtal, uppdragsavtal, offert för signering, villkor, betalvillkor, arvode, giltighetstid, signering, underskrift, bilaga. Trigga INTE på säljande pitch, deck, slides eller scrollbar webb-offert — då används frojd-pitch. Genererar HTML och konverterar till PDF med weasyprint.
---

# Fröjd Avtal — dokument för underskrift

Skapar offerter och avtal som ska **signeras**, som A4-PDF i Fröjds faktiska dokumentstil. För det säljande, presenterande materialet (pitch-deck, scrollbar webb-offert) — använd **`frojd-pitch`** istället.

**Avgränsning mot frojd-pitch:** Ska dokumentet undertecknas, eller innehåller det villkor/arvode/signaturrad → den här skillen. Ska det övertyga och presenteras (deck, webbsida) → frojd-pitch. En kommersiell offert kan tas fram i båda: frojd-pitch för presentationen, frojd-avtal för den signerbara versionen.

---

## Beroenden — läs in dessa först

- **Fonter & logo (i `assets/`)** — `assets/sofia_pro_embedded.css` och `assets/libre_caslon_embedded.css` (inbäddade som base64). Läs båda och inkludera hela innehållet i `<style>`. Logotyper: `assets/fro_jd-lila.svg`, `fro_jd-vit.svg`, `fro_jd-svart.svg` — bädda in som inline SVG. Då fungerar PDF:en offline. (Samma grafiska profil som `frojd-identity`.)
- **`frojd-fakta`** — org.nr (556712-0232), gällande adress (Grev Turegatan 1, 114 46 Stockholm), firmatecknare (Oskar Sparreljung, VD), arvode/timpriser och standardvillkor (betalning 20 dagar). Hämta ALLTID dessa härifrån — skriv inte egna kopior.

---

## Konvertering till PDF
```python
import weasyprint
weasyprint.HTML(filename='avtal.html').write_pdf('avtal.pdf')
```

---

## Fröjds dokumentstil (från Pages-mallar)

**Header:** Liten Fröjd-logotyp överst till vänster. Till höger: dokumenttyp + datum i liten grå text. Ingen horisontell linje under — bara luft (ca 64px) ner till titeln.

**Titel h1:** Libre Caslon Text **Regular** (`font-weight: 400`) — luftig, editorial. INTE bold. Storlek ca 2.5rem.

**Underrubriker h2:** Sofia Pro Bold, `font-size: 1rem`. Numrerade sektioner: "1. Uppdraget", "2. Avtalstid" etc.

**Underunderrubriker h3:** Sofia Pro Bold, `font-size: 0.9rem`.

**Brödtext:** Sofia Pro Regular, `font-size: 0.88rem`, `line-height: 1.7`. Luftig.

**Punktlistor:** Standard `•` bullet — ingen lila färg, inga custom symboler.

**Parter i löptext** — ingen färgad box. Skriv "Mellan KUND, ORG.NR, ADRESS, nedan Beställaren, och Fröjd Interactive AB, 556712-0232, Grev Turegatan 1, 114 46 Stockholm, nedan Byrån..." direkt som brödtext. Markera platshållare i lila/rödaktig färg.

**Arvode/budget:** Ren tabell utan lila vänsterkant. Kolumner: Aktivitet | Timmar | SEK exkl. moms. Totalt-rad i bold, border-top 2px.

**Signatur:** Två kolumner: "Oskar Sparreljung, VD, Fröjd" | "Namn, Titel" — ingen linje ovanför.

**Footer:** `www.frojd.se · info@frojd.se · Grev Turegatan 1 · 114 46 Stockholm` — liten text, vänsterjusterad, längst ner på varje sida. Fixed position.

**Vad som INTE finns i Fröjds dokumentstil:**
- Ingen partsruta med bakgrundsfärg eller grid
- Ingen lila vänsterkant på budgetblock
- Inga färgade checkmarks eller ✓-listor
- Inga mörka block eller gradient-bakgrunder
- Ingen lila rubrik-label ("OFFERT" i versaler med letter-spacing)

---

## Grundläggande CSS
```css
html { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
body {
  font-family: 'Sofia Pro', sans-serif;
  font-size: 14px; line-height: 1.7; color: #222;
  max-width: 800px; margin: 0 auto;
  padding: 48px 64px 100px;
  -webkit-font-smoothing: antialiased;
}
@media print { body { padding: 32px 48px 80px; max-width: 100%; } }

.doc-header { display: flex; justify-content: space-between;
              align-items: flex-start; margin-bottom: 64px; }
.doc-header svg { width: 80px; height: auto; }
.doc-header-meta { text-align: right; font-size: 0.75rem;
                   color: #999; line-height: 1.6; }

h1 { font-family: 'Libre Caslon Text', Georgia, serif;
     font-size: 2.5rem; font-weight: 400; /* Regular */
     letter-spacing: -0.01em; line-height: 1.15;
     color: #111; margin-bottom: 24px; }

h2 { font-family: 'Sofia Pro', sans-serif; font-size: 1rem;
     font-weight: 700; color: #111;
     margin-top: 36px; margin-bottom: 10px;
     break-after: avoid; page-break-after: avoid; }

h3 { font-family: 'Sofia Pro', sans-serif; font-size: 0.88rem;
     font-weight: 700; color: #111;
     margin-top: 20px; margin-bottom: 6px;
     break-after: avoid; page-break-after: avoid; }

p { margin-bottom: 10px; font-size: 0.88rem; color: #333; }

ul { padding-left: 1.2rem; margin-bottom: 14px; }
ul li { margin-bottom: 4px; line-height: 1.55; font-size: 0.88rem; }

table { width: 100%; border-collapse: collapse; margin: 20px 0;
        break-inside: avoid; page-break-inside: avoid; }
th { text-align: left; font-size: 0.78rem; font-weight: 700;
     padding: 8px 12px; border-bottom: 2px solid #111; }
td { padding: 9px 12px; font-size: 0.88rem;
     border-bottom: 1px solid #eee; vertical-align: top; }
tr { break-inside: avoid; page-break-inside: avoid; }
.total-row td { font-weight: 700; border-top: 2px solid #111;
                border-bottom: none; }

.doc-footer { position: fixed; bottom: 0; left: 0; right: 0;
              padding: 14px 64px; font-size: 0.72rem;
              color: #aaa; line-height: 1.6; background: #fff; }
/* Footer text: www.frojd.se · info@frojd.se · Grev Turegatan 1 · 114 46 Stockholm */
```

---

## Dokumentstruktur — offert (Pages-stil)
```
doc-header (logotyp vänster | dokumenttyp + datum höger, grå)
[64px luft]
h1 (Libre Caslon Regular — uppdragsnamn eller bara "Offert")
p (bakgrund/kontext, 1–2 stycken)
h2 Bakgrund & Uppdrag → p
h2 Projektupplägg → p
h2 Tidplan → p
h2 Arvode → p + table (Aktivitet | Timmar | SEK exkl. moms)
h2 Förutsättningar och avgränsningar
  h3 Kostnader → ul
  h3 Ansvar → ul
  h3 Feedback och korrektur → ul
  h3 Betalvillkor → ul (standard: 20 dagar från fakturadatum — se frojd-fakta)
  h3 Giltighetstid → p
  h3 Godkännande → p + signaturrad
doc-footer
```

## Dokumentstruktur — konsultavtal / uppdragsavtal
```
doc-header (logotyp | "Uppdragsavtal" + datum)
[64px luft]
h1 "Uppdragsavtal"
p (Mellan KUND, ORG.NR, ADRESS, nedan Beställaren, och Fröjd Interactive AB,
   556712-0232, Grev Turegatan 1, 114 46 Stockholm, nedan Byrån...)
h2 1. Uppdraget
  h3 Rollbenämning → p/X
  h3 Utförande → p
h2 2. Avtalstid och omfattning → p (Startdatum: X, Slutdatum: X...)
h2 3. Förtida uppsägning → ul
h2 4. Ersättning → p (Arvode: X SEK/h — se frojd-fakta för riktpriser)
h2 5. Betalningsvillkor → ul
  - Arvode debiteras månadsvis i efterskott.
  - Betalning sker inom **20 dagar** från fakturadatum (standard — aldrig 30 dagar).
  - Vid dröjsmål äger Byrån rätt att debitera lagstadgad dröjsmålsränta.
h2 6. Rekryteringsavgift → p
signaturrad (Ort/Datum × 2 | Oskar Sparreljung VD Fröjd | Namn Titel)
doc-footer
```

---

## Nyckelregler för PDF-layout

**Förhindra sidbrytningar:** `h2, h3 { break-after: avoid }` och `tr, ul, table { break-inside: avoid }`

**Tvinga sidbrytning:** `<h2 style="break-before:page; page-break-before:always">`

**Balansera sidan ett:** Dela upp innehåll med explicit sidbrytning — använd aldrig extra top-padding på body.

**Pseudo-element-fällan:** Lyft aldrig innehåll ur en klass med `::before`-symbol och lägg det i en annan klass som också har `::before` — annars renderas dubbla symboler.

---

## Arbetsflöde

1. **Bekräfta** dokumenttyp: offert för signering / konsultavtal / uppdragsavtal / bilaga.
2. **Läs `frojd-fakta`** — org.nr, adress, firmatecknare, arvode, betalvillkor.
3. **Läs `assets/`** — font-CSS (inkludera hela i `<style>`) och logotyp-SVG (inline).
4. **Samla** kund, org.nr, adress, omfattning, arvode, datum — be om uppgifter som saknas.
5. **Generera** HTML enligt rätt dokumentstruktur. Markera platshållare i lila/rödaktig färg.
6. **Konvertera** med `weasyprint` — spara både `.html` och `.pdf`.
7. **Städa** bort alla platshållarmarkeringar i slutversionen.
8. **Spara** till `/mnt/user-data/outputs/[kund]_[dokumenttyp].pdf` och presentera med `present_files`.
