---
name: "image-ref-gen"
description: >
  Reference-image prompt writer for Nano Banana (Gemini) and ChatGPT (GPT-4o) image generation. Use whenever the user wants to create reference images or the prompts for them — character sheets, turnarounds, wardrobe references, prop references, location/set references, style frames, or key visuals. Trigger on phrases like "reference image", "character sheet", "turnaround", "ref for the character", "generate the location", "style frame", "key visual", "Nano Banana prompt", "image prompt", or any request to produce visual reference assets for a film, commercial, music video, or Seedance production. Output is ready-to-paste English prompts that work in both engines. Always consult this skill before writing any image-generation prompt.
---

# Reference Image Prompt Writer (Nano Banana + ChatGPT)

Turn character, wardrobe, prop, location, and style ideas into engine-agnostic image-generation prompts. One prompt, pasteable into **Nano Banana (Gemini)** or **ChatGPT (GPT-4o image)** unchanged.

**Output: always ready-to-paste prompt(s) in code blocks, English only.**

---

## CORE PRINCIPLE: WRITE THE VISIBLE

Both engines react to what can be **seen and measured**, not to mood words or engine jargon.

- ❌ "cool cyberpunk mercenary, badass vibe" → ✅ "woman in her early 30s, shaved left temple, faded scar across the right eyebrow, matte-black tactical jacket with a torn left cuff, standing under a pink neon sign, rain droplets on her shoulders"
- ❌ "beautiful cinematic lighting" → ✅ "single warm tungsten key from the left at 45°, soft fill from a window on the right, background falls two stops darker"

Plain, descriptive, natural language. Fewer precise words beat many vague ones.

---

## ENGINE-AGNOSTIC RULES (one prompt for both)

These rules keep a single prompt working identically in Nano Banana and ChatGPT:

- **No engine syntax.** No `--ar`, no `::weights`, no seeds, no model names, no "8k, trending on artstation" spam. Pure descriptive sentences.
- **Aspect ratio in words**, stated once at the start: "vertical 9:16 portrait format", "wide 16:9 landscape frame", "square 1:1 frame".
- **Positive phrasing only.** State the target, never the prohibition. ❌ "no blur, no extra fingers" → ✅ "sharp focus edge to edge, both hands clearly visible with natural anatomy".
- **One image per prompt.** If a set is needed (e.g., 3 wardrobe angles), write one prompt per image and repeat the identity anchor verbatim in each.
- **Text in images:** if the image must contain text (logo, sign, label), quote it exactly and describe placement: `the label reads "VOLT" in white block letters centered on the can`.
- **No artist/director/brand-style names.** Describe the look itself (light, palette, grain, era) — style names get ignored, altered, or blocked.
- **Photoreal by default** for production references. State medium explicitly when not photoreal ("flat vector illustration", "graphite pencil sketch").

---

## THE IDENTITY ANCHOR (consistency system)

Character consistency across a whole reference set lives in one reusable paragraph — the **identity anchor**. Write it once, then paste it **verbatim** into every prompt featuring that character.

Anchor formula (3–5 sentences max):

```
[Name/role], [age], [build + height impression]. [Face: shape, skin tone, eyes, brows, nose, mouth — 1 sentence of the most identifying features]. [Hair: color, length, texture, style]. [1–2 permanent unique markers: scar, mole, tattoo, glasses]. [Default wardrobe if fixed across the set].
```

Rules:
- **Verbatim reuse.** Never paraphrase the anchor between prompts — every rewording drifts the face.
- **Unique markers are mandatory.** A scar, mole, freckle pattern, or distinctive accessory gives both engines something to lock onto.
- **Keep it under ~80 words.** Longer anchors dilute; the engines start averaging.
- The same principle applies to recurring props and locations: write a short **prop anchor** / **location anchor** and reuse it verbatim.

---

## REFERENCE TYPES — WHAT TO WRITE FOR EACH

### 1. Character sheet / turnaround
Neutral conditions so the identity reads cleanly and survives into Seedance:

```
[aspect: wide 16:9] Character reference sheet, [IDENTITY ANCHOR]. Full body, standing in a relaxed neutral pose, arms at sides. Three views side by side on one sheet: front view, left profile, back view — identical character, identical wardrobe in all three. Even, shadowless studio lighting, plain mid-grey seamless background, no props. Photorealistic, sharp focus head to toe.
```

- If the engine struggles with 3-in-1 sheets, split into three prompts (front / profile / back), anchor verbatim in each.
- Add a separate **face close-up prompt** (head-and-shoulders, front, neutral expression, same lighting). On Seedance 2.0 this is the image identity locks work best from.
- **Seedance 2.5 takes multi-view sheets directly** as references, and 2.0 doesn't. Keep the sheet background plain and the layout simple: whatever sits on the sheet (backdrop, panel borders, wardrobe flat-lays) has to be excluded in the video prompt, so less on the sheet means less to exclude.
- Don't write the character's name on the sheet. Seedance 2.5's guide warns that names written on reference images confuse multi-character scenes; the name gets bound in the prompt instead.

### 2. Wardrobe reference
```
[aspect] Wardrobe reference photo: [garment described by material + construction + condition + color tied to material] (e.g., "waxed olive-green cotton field jacket, worn at the elbows, brass zipper, frayed left cuff"). Displayed on [the character / a mannequin / flat-lay], plain mid-grey background, even studio light, true-to-color.
```
- Material + condition + one flaw = believable. Perfect garments read as CGI.

### 3. Prop reference
```
[aspect] Product/prop reference photo: [prop anchor: object, material, size vs a human hand, color, wear, any text quoted exactly]. On a plain mid-grey surface, soft even light, slight 3/4 angle showing top and side, sharp focus.
```
- State scale by comparison ("fits in an open palm", "as long as a forearm").

### 4. Location / set reference
```
[aspect] Location reference: [place, time of day, weather]. Foreground: [...]. Midground: [...]. Background: [...]. Light source and direction: [...]. Camera height and viewpoint: [...]. Empty of people. Photorealistic.
```
- Layered foreground/midground/background, same as a Seedance LOCATION MAP — so the still matches the video prompt later.
- Generate the location **empty**; characters composite in via the video model.

### 5. Style frame / key visual
The one image that sells the look. Unlike the neutral refs above, here everything plays at once:
```
[aspect] [Scene in one sentence — who, where, what moment]. [IDENTITY ANCHOR if a character appears]. [Composition: framing, where the subject sits in frame, camera height]. [Lighting: source, direction, quality, ratio]. [Palette: 2–3 colors tied to material + light, not a list]. [Atmosphere in measurable terms: haze, rain, dust]. [Medium/finish: photoreal, film grain, era].
```
- One style frame per scene/mood is usually enough; more dilutes the direction.

---

## PROMPT STRUCTURE (general order)

1. **Format** — aspect ratio in words
2. **What this image is** — "character reference sheet", "location reference", "key visual"
3. **Subject** — identity/prop/location anchor
4. **Pose / arrangement / composition**
5. **Lighting** — source, direction, quality
6. **Background / environment**
7. **Finish** — photoreal, focus, grain

Use only what the image needs. Neutral refs stay minimal; style frames earn the full stack.

---

## WORKFLOW

1. **Clarify the target.** Which reference type(s)? For a character: is there an existing description or is this from scratch?
2. **Write the anchor first** and show it to the user — this paragraph will be reused everywhere, so it must be approved before the set is generated.
3. **Write the prompts**, one per image, anchors verbatim.
4. **Deliver as a numbered set of code blocks**, each labeled with its purpose (e.g., "Shot 1 — front turnaround").

If the request is ambiguous (age, era, palette, format), close the gaps in conversation first — the engines fill every gap on their own, usually not the way intended.

---

## ITERATION ADVICE (include when relevant)

When the user reports a bad generation, diagnose in this order:
1. **Identity drift** → anchor was paraphrased or too long; restore verbatim, trim to <80 words, strengthen unique markers.
2. **Wrong mood/light** → lighting stated as adjectives; restate as source + direction + ratio.
3. **Cluttered frame** → too many elements; cut to what the reference needs, move story elements to the style frame.
4. **Text garbled** → shorten the quoted text, describe placement, or plan text as a post overlay.
5. Both engines support **conversational refinement** — the follow-up message ("same image, but…") only needs the *change*, plus the identity anchor if a character is in frame.

---

## CHECKLIST (before delivering)

- Aspect ratio stated in words, first?
- Anchor written once, pasted verbatim in every prompt of the set?
- Unique markers present (scar/mole/accessory)?
- Everything positive (no "no X")?
- Color tied to material + light, not a flat list?
- Scale by human comparison where size matters?
- Any in-image text quoted exactly with placement?
- No engine syntax, no artist/brand/style names?
- One image per prompt; sets numbered and labeled?
- English only?
