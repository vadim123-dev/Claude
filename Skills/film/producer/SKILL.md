---
name: "producer"
description: Generate production-grade prompts for AI filmmaking — character reference sheets, 9-panel cinematic storyboards, and Seedance 2.5 video prompts. Use this skill whenever the user wants to create an AI-generated film, short, music video, commercial, trailer, scene, or video sequence, or asks for prompts for image and video models like Nano Banana Pro, Midjourney, Flux, GPT Image 2, Seedance 2.5 or 2.0, Veo, or Runway. Also triggers when the user describes a character or story they want to render visually, asks for a storyboard or shot list, or mentions cinematic prompts, text-to-video, image-to-video, or character/style locking across shots. Use even when the user doesn't say the word "prompt" — if they're describing a video they want to make and need help structuring it, use this skill.
---

# AI Filmmaking

A toolkit for generating production-grade prompts across the AI filmmaking pipeline. It chains three templates together: a **Character Sheet** to lock identity, a **9-panel Storyboard Grid** to design a continuous scene, and **Seedance 2.5 Video Prompts** to render each shot or one-take sequence.

The templates are deliberately genre-agnostic. The same skeleton produces photorealistic sci-fi, Pixar-style 3D, anime, music video, noir, documentary, influencer vlog, or stylized commercial work — genre is a swappable parameter, not a hardcoded assumption.

## House style — read this before writing any video prompt

This skill carries a **house visual language**, reverse-engineered from a library of shipped prompts whose look was approved. It is not optional flavour; it is the default look of this operation, and a prompt that ignores it will feel wrong even if it's technically well formed.

Three reference files hold it. Read the ones the job needs, **before** drafting:

- **`references/creative-playbook.md`** — the idea layer. The concept engines (contrast, the moment-before, fake-out, deadpan, match-cut chains), and the **seven production modes (A–G)**. Read this first, always. Naming the mode decides most of the downstream choices.
- **`references/prompt-anatomy.md`** — the block architecture. The 20-block set, the REFERENCE MANIFEST scoping-and-anti-bleed pattern, timecoded cut sheets, POSITIVE LOCKS, negative-prompt failure groups, and the special dialects (VFX insert, plate-protected replacement).
- **`references/house-style.md`** — the craft numbers. Focal lengths and FOV degrees, camera heights, rig behaviour, cut devices, Kelvin values, the 60:30:10 colour ratio, film-emulation stacks, physics language, performance and skin, audio layering.

**Minimum viable use of the house style, when there's no time to read all three:**

1. Name the production mode (A–G) before writing.
2. Open with a one-sentence directorial thesis.
3. State a focal length (or FOV in degrees) and a camera height for every shot.
4. Name the light source, its direction, and whether there is fill.
5. Write the physics: mass, inertia, contact shadow.
6. Close with POSITIVE LOCKS and a negative prompt built from actual failure modes.

## Workflow

Most users want all three templates in sequence (character → storyboard → video). Some come in mid-pipeline ("I have a character sheet, just give me Seedance prompts for these panels"). Figure out where the user is and deliver what they need — don't ship all three when they only asked for one.

When a brief comes in:

1. **Identify the gaps in the creative spec.** Before generating anything, you need enough to write concrete copy. The minimum:
   - Genre / visual style (live-action cinematic? Pixar 3D? anime? music video? influencer vlog? photorealistic sci-fi?)
   - Lead character(s) — a sentence each on age range, build, wardrobe, key prop
   - Setting / location
   - The scene's emotional beat or story turn (what happens, in one sentence)
   - Aspect ratio (default `16:9` for cinema, `9:16` for vertical / music video / social)
   - Exclusions — anything that must NOT appear in frame

2. **Ask 2–3 sharp questions only if the brief is genuinely vague.** Don't fish for every field. If the user already wrote a paragraph of detail, just start generating. Only ask about what's load-bearing.

3. **Pick the template(s) the user actually needs.** Don't deliver a character sheet if they came in with character images already.

4. **Fill every bracket.** Don't ship a skeleton with `[BRACKETED]` placeholders. Replace every field with concrete, evocative copy. The whole point of this skill is to do the writing for them.

5. **Deliver in fenced code blocks.** These prompts get pasted straight into Nano Banana Pro, Midjourney, Seedance, etc. Clean, paste-ready text only — no commentary mixed inside the block.

## Character Lock — the most important rule

The single biggest cause of failure in AI filmmaking is character drift: the same person looking like a different person between shots. To prevent this:

**Reuse the same character description verbatim in every template that features that character.** Don't paraphrase between templates. Don't trust the model to "remember" between generations. The text description is the identity anchor.

When you generate the second and third templates, copy the character description forward unchanged. That continuity is what carries identity across the pipeline.

If reference images exist, reference them *and* keep the text description as a belt-and-braces backup. In Seedance 2.5 prompts, use `@Image 1`, `@Image 2`, etc., bound to a name. See the numbering rule under Template 3.

## Lean about *who*, maximal about *how it's shot*

This is the rule that governs prompt length, and it cuts in two directions. Getting it backwards is the most common failure in this whole skill.

**Lean: identity, wardrobe, character, atmosphere.** The model doesn't need a wardrobe spec sheet to lock a character — it needs the handful of visual details that make that character recognizable. Word clutter here doesn't make outputs more accurate; it dilutes the signal and contaminates the identity anchor with scene-specific detail. A Character Sheet description stays at ~30–60 words, and drops to nothing at all when a reference image is attached — the image *is* the description. See Template 1.

Panel beats and action beats follow the same discipline: write like a screenwriter, not a novelist. Short, declarative phrases. `Viper lunges, palm strike to sternum` — not `Viper takes a sudden step forward and extends her right arm in a forceful palm-strike motion targeting Raven's chest area`.

**Maximal: camera, lens, height, light, colour, physics, cuts, audio.** Here the opposite rule applies, and it applies hard. Every craft parameter left unstated is a parameter the model fills with its worst instinct — a wide-angle drone shot, flat global illumination, a floating product, a slow 360° orbit, plastic skin, a liquid morph between shots. Specificity here is not bloat; it is the only mechanism that overwrites those defaults. The approved reference library contains 1,400-word prompts that work precisely because they spend their length on `85mm telephoto, hub height, camera on a lead rig ahead of the car receding at slightly less than the car's speed` instead of on adjectives.

So: **the word budget goes to the how, not the who.** When trimming a long prompt, cut identity prose and atmosphere adjectives. Never cut a number.

`references/prompt-anatomy.md` has a length table by job type, from 10-word image-to-video prompts to 1,400-word commercial spec-stacks.

## Style consistency

The same palette, grain, lighting language, and lens descriptors should appear in every shot of a sequence. Inconsistent style descriptors are why worlds drift between generations as badly as characters do. If shot 1 establishes "35mm film grain, muted tones, golden-hour key light," that exact block belongs in shots 2 through 9.

Aspect ratio is part of the prompt — state it in every shot, not just the first.

**The stronger version of this rule: lock everything, change one variable.** The reference library's cleanest multi-shot work states its locks out loud — `the same street-level camera height, lateral viewing angle, subject size, screen position, walking speed, lens compression, soft natural daylight and muted warm colour grade across every location`, with only the location changing. Or `identical car, paint, wheels, stripes and ride height across all five cuts, same tunnel, same lane, same direction of travel, same lighting state`, with only the camera changing.

Ask of every sequence: **what is the one variable?** Then write the locked list down as prose in the prompt. An unstated lock is not a lock.

---

## Template 1 — Character Sheet

**Use for:** Nano Banana Pro, GPT Image 2, Midjourney, Flux, or any high-fidelity image model. This sheet becomes the identity reference for every subsequent shot.

**Output:** an 8-shot grid — top row is four full-body views (front, side, three-quarter, back), bottom row is four matching close-ups.

The character sheet has two modes depending on whether the user provided a reference image. Pick the right one — using Mode B when an image is available is one of the biggest sources of word bloat in this skill.

### Two critical rules before you write anything

**1. If a reference image is attached, do not re-describe it in prose.** The image *is* the description. Adding a paragraph that re-narrates what the model can already see fights the visual anchor and dilutes attention. State the rendering style you want applied — that's it.

**2. Keep lighting neutral on the character sheet.** The sheet is a reference meant to be reused across many scenes. If you bake scene-specific lighting into it ("cold moonlight ambient with warm red flare rim-light"), you lock the character to one scene and contaminate every downstream shot. Scene lighting belongs in Template 2 and Template 3, not here. The sheet should be lit neutrally — clean, even, studio-style — so it serves any scene.

Also: always include `Background should be simple and not distracting from character design.` The point of the sheet is the character; busy backgrounds steal attention from the identity anchor.

### Mode A — Reference image(s) attached

Use when the user has provided photos or AI-generated reference shots of the character. The image carries the visual; you just specify rendering style.

```
Create a professional character reference sheet for attached character with {use attached image(s) as strong reference, 1:1 similarity, [STYLE DESCRIPTORS — e.g., photorealistic, live-action, lifelike]}. Divide the sheet into four different vertical columns, each representing a different angle, for a total of eight shots. The entire top row must show full-body views from head to toe facing four different directions: the front, the side, a three-quarter view, and the back. All subjects in the top row must be fully visible including feet, with no cropping at the ankles, knees, or head. The bottom row must contain four close-up shots of the face (including front and profile views) corresponding to each of the full-body shots above. The style must be [STYLE BLOCK — e.g., photorealistic, life-like live action shot on a DSLR camera with 35mm film and muted color tones; do not make it look like a 3D render]. Background should be simple and not distracting from character design. Aspect ratio = 16:9.
```

### Mode B — Description only (no reference image)

Use when the user has no reference photo and the character has to be specified entirely in prose. Even here, keep it tight: a comma-separated list of identity-locking traits, not a novelist's paragraph. **~30–60 words is the target; over 100 is a failure.**

Include only what makes the character recognizable: age range, build, skin, hair, eyes, the wardrobe in brief, and the key prop. Skip narrative atmosphere (dirt smudges from a backstory, damp hair from the rain in the scene, sparks streaming from the flare). Those are scene effects, not identity, and they belong in the shot prompts.

> Good (~55 words): `a woman in her late twenties, lean weather-hardened build, pale skin, watchful dark-brown eyes, dark brown shoulder-length wavy hair; wears a charcoal arctic parka with wolf-fur-lined hood, canvas harness straps over the chest, insulated cargo trousers, scuffed black snow boots; right hand grips a lit red emergency flare`
>
> Bloated (~155 words, scene contamination): `a woman in her late twenties, lean and weather-hardened build, pale wind-burned skin with a smudge of dirt and a faint blood streak across her right cheekbone, watchful dark-brown eyes, defined brows, slightly chapped lips, shoulder-length dark brown wavy hair partially tucked into her hood with a few damp strands framing her face. She wears a heavy charcoal-black arctic parka, oversized hood lined with thick brown-and-grey wolf fur pulled up around her head, weathered canvas-and-leather harness straps across the chest, a dark wool scarf bunched at the neck, layered thermal underlayers, insulated cargo trousers, and scuffed black snow boots. In her right hand she grips a lit red emergency road flare, crimson sparks and pink-red smoke streaming from the tip and casting warm red rim-light across her face and fur hood.`

The bloated version is what happens when the model treats the description as creative writing instead of identity locking. Sparks, blood streaks, damp hair, and rim-light cast onto the hood are all scene-specific — they fight identity reuse across shots.

```
Create a professional character reference sheet for [CHARACTER DESCRIPTION — tight comma-separated identity traits: age, build, skin, hair, eyes; wardrobe in brief; key prop. Target 30–60 words. No scene effects, no atmosphere, no narrative damage]. Divide the sheet into four different vertical columns, each representing a different angle, for a total of eight shots. The entire top row must show full-body views from head to toe facing four different directions: the front, the side, a three-quarter view, and the back. All subjects in the top row must be fully visible including feet, with no cropping at the ankles, knees, or head. The bottom row must contain four close-up shots of the face (including front and profile views) corresponding to each of the full-body shots above. The style must be [STYLE BLOCK — e.g., photorealistic, life-like live action shot on a DSLR camera with 35mm film and muted color tones; do not make it look like a 3D render]. Background should be simple and not distracting from character design. Aspect ratio = 16:9.
```

### Adapting the style block to genre

- **Photorealistic / live-action:** `photorealistic, life-like live action shot on a DSLR camera with 35mm film and muted color tones, do not make it look like a 3D render`
- **Pixar / 3D animation:** `stylized 3D render in the visual language of modern Pixar features, soft global illumination, expressive proportions, no photoreal rendering`
- **Anime / 2D:** `2D anime cel-shading in the style of [reference studio], clean line work, painterly backgrounds, no 3D render`
- **Noir:** `high-contrast black and white film, harsh chiaroscuro lighting, 35mm grain`
- **Influencer / iPhone vlog:** `natural daylight, iPhone selfie-camera aesthetic, soft skin tones, no cinematic grade`

The structure stays the same; the aesthetic descriptor swaps. Avoid descriptors that imply scene lighting (e.g. "moonlit," "firelit," "neon-soaked") — those belong in the shot prompts, not the character sheet.

---

## Template 2 — Cinematic Storyboard Grid

**Use for:** Nano Banana Pro, GPT Image 2, Midjourney, Flux, or any high-fidelity image model.

**Output:** A single image containing a 3×3 grid of 9 sequential panels depicting one continuous scene, with a production-notes strip under each panel.

The whole point of this template is to render a coherent moment in time across 9 beats with locked characters and locked geography. Treat the panels as one continuous take broken into sequential frames — not nine unrelated images.

### Filling the template, the right way

**Character descriptions: one tight sentence per character.** The full identity spec lives in the Character Sheet. Here you only need the handful of details that lock the look across panels — distinguishing features, hair, key clothing color, key prop. Don't repeat the wardrobe inventory.

> Good: `RAVEN: Mid-40s, lean Asian man, silver-grey spiky hair, sleeveless ochre kung-fu robe, gold arm cuffs, barefoot.`
>
> Bloated: `RAVEN: A man approximately 45 years of age with an athletic build of average height, featuring silver-grey spiky hair styled upward, wearing a traditional sleeveless ochre-colored kung-fu robe made of cotton with intricate gold arm cuffs and going barefoot on the wooden floor.`

**Panel beats: screenwriter-style, not novelist-style.** Each beat should be a tight slug line — what's in frame, who's where, what happens. Three to twelve words is the sweet spot. Don't narrate; direct.

> Good: `Panel 2 (top-center): Viper lunges, palm strike to sternum. Whip-pan with the motion.`
>
> Bloated: `Panel 2 (top-center): Viper takes a sudden aggressive step forward and extends her right arm forcefully in a palm-strike motion aimed at Raven's sternum while the camera whip-pans dynamically to follow the action.`

### Annotation strip format

Each panel's annotation strip carries three short lines in clean uppercase, formatted as screenplay slug lines. The first two lines are fixed; the third adapts to genre:

```
CAM:    [camera framing and movement]
MOVE:   [what the subject does — short, punchy]
MOOD:   [emotional / atmospheric beat]
```

The third line substitutes depending on what matters most for the genre:
- **MOOD** — default, for drama / dance / cinematic narrative
- **VOICE** — for vlog / influencer / dialogue-driven scenes (carries the spoken line)
- **STYLE** — for martial arts / action / fight choreography (carries the stance or technique)

Examples of strong annotation triplets, drawn from real reference boards:

```
CAM: SLOW LOW ORBIT. WIDE.
MOVE: STANDOFF. CHERRY PETALS DRIFT BETWEEN.
MOOD: TENSION. STILLNESS BEFORE STRIKE.
```

```
CAM: SELFIE CAM. CLOSE.
MOVE: HOLDS BOTTLE UP TO CAMERA.
VOICE: "OKAY GUYS, I FOUND IT."
```

```
CAM: WHIP-PAN WITH LUNGE. MEDIUM.
MOVE: VIPER LUNGES, PALM STRIKE TO STERNUM.
STYLE: VIPER — SILAT (CEKAK SILAT) / VIPER'S BITE.
```

```
CAM: RISING ORBIT. PUSH-IN.
MOVE: FULL-BODY EXTENSION. ARMS REACH SKY.
MOOD: AWAKENING. SOFT PIANO. BUILD.
```

Note the cadence: 2–6 words per line, often broken into short period-separated phrases. That rhythm is what makes them read like a director's notes instead of a paragraph.

**Readability matters.** Request the annotation text in a clean, high-contrast sans-serif font legible at the rendered grid size. The whole point of the strip is that the user can read it — bad legibility kills the board's usefulness as a production document.

### The template

```
Create a cinematic storyboard sheet in a 3x3 grid format (9 panels arranged in 3 rows x 3 columns) depicting ONE CONTINUOUS [SCENE TYPE] between [NUMBER] characters.

Style: Cinematic, [GENRE/REFERENCE TONE], [STYLE DESCRIPTORS — e.g., live-action, photorealistic, lifelike, 35mm film grain]. Aspect ratio = 16:9 page layout. No text, no captions, no panel numbers inside panels, only thin clean separators between panels. UNDER EACH panel a thin off-white annotation strip with three short lines of production notes in a clean, high-contrast sans-serif font (must be legible at rendered size): CAM (camera framing/movement), MOVE (subject action), and MOOD (atmosphere). Substitute VOICE for MOOD on vlog/dialogue scenes, or STYLE for MOOD on action/martial-arts scenes. Notes must read as short, declarative slug lines — not full sentences.

CHARACTER LOCK — all characters must appear IDENTICAL across all 9 panels (same face, same build, same clothing, same props). Use the descriptions below as the source of truth. If reference images are attached, treat them as additional identity anchors and match them precisely.

[CHARACTER A]: [one tight sentence — distinguishing features, hair, key clothing color, key prop].
[CHARACTER B]: [same — one tight sentence].
[Add CHARACTER C / D only if needed.]

This is a CONTINUOUS [SCENE TYPE] — one [encounter / moment / exchange], one location, one unbroken flow of time. Same [LOCATION & ATMOSPHERE]. [EXCLUSIONS — anything that must NOT appear].

Camera moves naturally around the action as if shot in a single continuous take broken into 9 sequential beats.

Narrative — [SEQUENCE NAME] (read left-to-right, top-to-bottom):
Panel 1 (top-left): [Beat 1 — short, declarative].
Panel 2 (top-center): [Beat 2].
Panel 3 (top-right): [Beat 3].
Panel 4 (middle-left): [Beat 4].
Panel 5 (middle-center): [Beat 5].
Panel 6 (middle-right): [Beat 6].
Panel 7 (bottom-left): [Beat 7].
Panel 8 (bottom-center): [Beat 8].
Panel 9 (bottom-right): [Beat 9].
```

**When writing the 9 beats, think like a director.** Each panel should advance the action by a meaningful unit of time *and* shift the camera framing — wide → medium → close-up → over-the-shoulder, etc. Nine variants of "they're talking from the same angle" wastes the grid. Vary the framing, vary the action, build to a climactic beat in panels 7–9.

---

## Template 3 — Seedance 2.5 Video Prompts

Seedance prompts come in **three variants** depending on what reference material the user has. Pick the one that matches the situation. Don't default to Variant A if they already have a storyboard: Variants B and C give much higher fidelity when a grid exists.

For prompt craft beyond these templates (timestamp rules, motion cautions, lighting paragraph, Edit and Extend modes), consult the `seedance-clean` skill. It is the source of truth for Seedance 2.5 prompting.

### Reference numbering and binding — read this first

2.5 numbers references by type in upload order: `@Image 1`, `@Image 2`, `@Video 1`, `@Audio 1`. **Each reference gets its own number.** Two character sheets are never both `@Image 1`; that collapses them into one reference and breaks identity lock.

- Character A's sheet → `@Image 1`
- Character B's sheet → `@Image 2`
- Storyboard grid → next free number (`@Image 3` with two sheets, `@Image 1` when it is the only reference)

If the user names their own tags, use theirs.

**Then bind each number to a name and say what to take from it.** This is the official 2.5 structure, and it matters most for character sheets, which carry backgrounds, panel grids and wardrobe flat-lays the model should not inherit:

```
Define the man in @Image 1 as Daniel. Use his face, hair and build only.
Ignore the studio background, the panel grid and the wardrobe flat-lays.
```

Refer to him as Daniel from then on. **Don't re-describe his face in text.** 2.5 treats text that restates a precise reference as a conflicting instruction. Describe only what the reference doesn't show: wardrobe for this shot, current state, action.

Multi-view sheets and turnarounds are supported references on 2.5. On 2.0 they weren't.

### Duration — match the beats, don't pad

2.5 generates **4 to 30 seconds** per take. Choose the duration from the content: count the beats, give each enough room to land, stop there.

**Don't default to the maximum.** Major platforms bill 2.5 per second (Runway: 68 credits/sec at 1080p). A 30-second take costs twice a 15-second one, and padding a 15-second idea to 30 makes the model invent filler. This reverses the old 2.0 rule of always filling the full 15 seconds.

When the user names a length, use it. When a piece is longer than 30 seconds, split it at natural seams and generate one take per block, or generate one take and use Extend.

### Variant A — Text-driven shots, optional character sheet references

Use when: the user has individual character sheets (or no references) and wants composable shot prompts they can iterate on freely.

```
[DURATION] seconds, [ASPECT], [ONE CONTINUOUS TAKE / N CUTS], [GENRE + LOOK].

ASSETS
Define the [person] in @Image 1 as [NAME 1]. Use [face, hair, build] only.
Ignore [background, grid, flat-lays].
Define the [person] in @Image 2 as [NAME 2]. [Same pattern.]

SUMMARY
[One sentence: subject + place + event + style + signature camera move.]

TIMELINE (continuous whole-second ranges covering the full duration)
0–5s: [Camera + FOV] — [What is in frame and what happens]. End state: [where it lands].
5–10s: [Camera + FOV] — [What happens]. End state: [where it lands].
10–15s: [Camera + FOV] — [What happens]. End state: [where it lands].

LIGHTING & COLOR
[Direction, hard/soft, contrast, Kelvin. Base / secondary / accent palette.]

AUDIO
[Ambience] [...] [Voices] [...] [Music] None.

HOLD
[Continuity, wardrobe, counts, screen direction.] Keep the film free of on-screen text, subtitles and watermarks.
```

### Variant B — Storyboard grid as the main reference

Use when: the user has a 9-panel storyboard and wants the sequence rendered as one continuous video. Grid storyboards are an officially supported reference type on 2.5. The grid carries identity, geography, framing and pacing; your job is the through-line.

```
[DURATION] seconds, [ASPECT]. Use the cinematic storyboard grid @Image 1 as
the main visual and motion reference. Read the panels as a sequence of shots
in order, not as one image. Follow the panel order, camera logic, motion
arrows and framing. Ignore the grid lines and gutters. Handheld camera moments
for realism.

Storyline:
[A compressed through-line, not a panel-by-panel novelization.]

Audio: no music, diegetic sound only. Keep the film free of on-screen text.
```

### Variant C — Character sheets + storyboard grid

Use when: the user has both character sheets AND a storyboard grid. Highest fidelity: characters locked by the sheets, motion and framing locked by the grid.

```
[DURATION] seconds, [ASPECT].

Define the [person] in @Image 1 as [NAME 1]. Face, hair and build only;
ignore the sheet's background, grid and flat-lays.
Define the [person] in @Image 2 as [NAME 2]. Same exclusions.

Use the cinematic storyboard grid @Image 3 as the main visual and motion
reference. Read the panels as a sequence of shots in order, not as one image.
Follow the panel order, camera logic, motion arrows and framing. Ignore the
grid lines and gutters.

Storyline:
[Fill briefly from the storyboard, naming characters by their bound names.]

Audio: no music, diegetic sound only. Keep the film free of on-screen text.
```

One character sheet: drop the second binding and renumber the grid to `@Image 2`. Three sheets: `@Image 1`/`@Image 2`/`@Image 3`, grid becomes `@Image 4`. The structure stays; only the numbers shift.

### Audio default: no music

Seedance prompts should **not** include music unless the user explicitly asks for it or names a track. Close with `Audio: no music, diegetic sound only.` Music baked in at generation time can't be removed cleanly, so let the user score the cut.

The exception: the user asks for music or names a track or mood. Then bake it in.

### Dialog scenes (primarily Variant A)

2.5 generates native audio in more than ten languages. If the user wants spoken dialog, put it in the TIMELINE in quoted brackets, with the speaker's emotion and micro-gestures fused into the line. For a second character's response, **always start with "She replies:" or "He replies:"**. The word "reply" signals consecutive speech and stops speakers collapsing into each other.

```
0–3s: Medium shot — She says (excited, eyes wide): "This is the best gift I ever received!" (pointing at the box).
3–6s: Reverse over-the-shoulder — He replies (quietly amused): "I wasn't sure you'd open it."
```

Confirm the dialog language is supported on the user's platform before relying on it.

### Multi-shot sequences without a storyboard

On 2.5 a multi-shot sequence up to 30 seconds can be **one take** with timestamped beats. Prefer that when shots share a location, a continuous camera move, or in-camera transitions: the transitions become free and continuity holds.

Split into separate takes instead when a client will revise individual shots, when a segment needs frame-accurate timing for titles or a music sync (timestamps land close, not exact), or when the piece runs past 30 seconds. Then keep the ASSETS, LIGHTING & COLOR and HOLD sections identical across all prompts and vary only the TIMELINE.

---

## Template 4 — Shot Spec Architecture (the house-style prompt)

**Use for:** premium commercial, product, vehicle, fashion, and narrative work in any capable video model (Seedance 2.5, Veo, Kling, Runway, Sora). This is the format the approved reference library is written in, and it is the right default whenever the output has to look *directed* rather than generated.

Template 3's variants are for composable, iterative shots hung off character sheets and storyboards. Template 4 is for when the prompt itself is the shooting script — one dense, block-structured document that leaves the model nothing to improvise.

**Before filling it:** name the production mode from `references/creative-playbook.md` (A–G). The mode tells you which blocks below are required and which to drop. Then pull the numbers from `references/house-style.md`. Do not fill this template from memory — the value is in the specificity, and the specificity lives in the reference files.

### The skeleton

Use ALL-CAPS block labels. Drop any block the mode doesn't need. Order matters: intent → references → world → craft → beats → locks.

```
[THESIS — one sentence of directorial intent. What this must feel like, and what it must NOT feel like.]

FORMAT: [duration] / [aspect] / [fps] / [cut count or "single continuous shot, no cuts"] / [platform if social]

ACTIVE REFERENCES
@Image 1 — [ROLE] ONLY. [The traits this asset contributes.] Ignore [what it must not pass on].
@Image 2 — [ROLE] ONLY. [Traits.] Ignore [...].
Do not import [the unwanted element each reference carries] into the scene.
[Identity & continuity paragraph — what must stay stable in every frame.]

SUBJECT: [Identity in 30–60 words, or the enumerated product-fidelity inventory + the do-not-alter verb list.]

LOCATION MAP: [Foreground plane. Midground plane. Background plane + haze density.] Light comes from [source and direction].

FIRST FRAME: [Frame one is already in motion — subject position and momentum, camera position, compositional anchor.]

CUT SHEET: [Hard cuts at exact decimal times, and "the camera holds its own frame between them" — or "single continuous shot".]

OPTICS: [Focal length or FOV per shot. State the floor/ceiling. "FOV is set per shot and stays put — no drift mid-shot."]

CAMERA: [Rig position, height, speed relative to subject, handheld amplitude in cm and the half-beat lag. "Motion begins on frame one of every cut — never a static start."]

ACTION
0.0s–[t]s — [Shot framing, focal, height, rig behaviour]: [what happens, verbs only, what "reads" in frame].
[t]s HARD CUT
...

PERFORMANCE: [Micro-behaviour, restraint level, eye-line. "Always mid-action or mid-reaction, never posed or waiting."]

PHYSICS: [Mass, inertia and lag, load/unload, contact shadows, wind speed and displacement range, containment rules.]

LIGHTING: [Practical sources named, direction, Kelvin. Fill policy. Haze. Light as a moving event across surfaces.]

COLOR: [60:30:10 weighting, or the grade arc and where it flips. Saturation policy — what owns the only pure colour.]

SURFACE / WARDROBE: [Material + its optical behaviour + the ban on the plastic version. Continuity across shots.]

AUDIO: [Diegetic layers as physical events. Sync points. Music policy — default none.] No dialogue. No subtitles.

STYLE: [Film-emulation stack.]

OUTPUT: [Resolution, fps, grain, real-time speed.]

POSITIVE LOCKS
[Every non-negotiable restated as a statement of fact about the finished film.]

NEGATIVE PROMPT
[Failure modes from the applicable groups + this genre's named cliché.]
```

### Duration

Duration follows the platform and the content, not this template. Seedance 2.5 runs 4 to 30 seconds and should match the beats rather than default to the maximum (see Template 3). Other models and other briefs run 8–25s; the reference library spans that whole range. Whatever the number, write the cut sheet to cover it completely and to one decimal place.

### Don't ship the skeleton

The same rule as every other template: fill every bracket with concrete copy, and never let a `[BRACKETED]` label reach the user. If a block would only contain a generic phrase, delete the block instead.

---

## Delivery format

Deliver each prompt in its own fenced code block so the user can copy-paste cleanly. Any commentary, options, or follow-up questions live **outside** the code blocks. A prompt block should contain only the prompt — nothing else.

If you're delivering multiple prompts (e.g., one Seedance Variant A prompt per storyboard panel), label them clearly above each block:

> `### Panel 1 — Seedance prompt`
>
> ```
> ...prompt text...
> ```

The user will likely paste each one into a separate generation, so they need to tell them apart at a glance.

## Common pitfalls

- **Shipping `[BRACKETED]` placeholders.** If `[CHARACTER DESCRIPTION]` makes it into the final output, the skill has failed. Fill every field.
- **Bloating character descriptions in the Storyboard template.** One tight sentence per character, not three. Identity lives in the Character Sheet (image or short description); the Storyboard just needs a brief reminder.
- **Bloating the Character Sheet description when a reference image is attached.** The image *is* the description — don't re-narrate it. Mode A is short by design.
- **Baking scene effects into the Character Sheet.** Blood streaks, dirt smudges, damp hair, sparks streaming from the prop, scene-specific rim-light cast onto the character — all of these contaminate the identity reference. Lighting should be neutral; transient details belong in the shot prompts.
- **Narrating panel beats instead of directing them.** "Viper lunges, palm strike to sternum" — not a sentence with three subordinate clauses.
- **Annotation strips written as full sentences.** They should read like screenplay slug lines: short, period-separated, uppercase, 2–6 words per line.
- **Using MOOD when the scene calls for VOICE or STYLE.** Vlogs need the spoken line. Fight scenes need the stance. Pick the right third line for the genre.
- **Collapsing multiple references onto `@Image 1`.** Each reference gets its own number. Character A's sheet ≠ Character B's sheet ≠ storyboard grid.
- **Using Variant A when the user has a storyboard.** If a grid exists, Variant B or C is much higher fidelity than chaining text prompts.
- **Forgetting aspect ratio on shots 2–9.** State it in every prompt.
- **Adding music to Seedance prompts the user didn't ask for.** Default to ambient / `NO MUSIC`.
- **Padding Seedance duration to the maximum.** 2.5 bills per second and runs to 30s. Match the duration to the beats.
- **Re-describing a character's face in text when a sheet is referenced.** On 2.5 the text conflicts with the image. Bind the reference and describe only what it doesn't show.
- **Writing decimal timecodes like `1.4s`.** 2.5 follows whole-second, continuous ranges: `0–3s, 3–7s`.
- **Packing a sprint, a jump or a tumble into one beat.** 2.5's weakest area is high-burst motion. Hand the energy to the camera or the edit.
- **Editorializing inside the code block.** Notes go outside. The prompt is what gets pasted.

### House-style pitfalls

- **Writing a vibe where a number belongs.** "Cinematic camera movement" is not a camera instruction. `85mm telephoto, hub height, lead rig receding at slightly less than the subject's speed` is. Same for light (Kelvin + direction + fill policy), handheld (cm of drift), wind (km/h + displacement range), and cut timing (one decimal place).
- **Skipping the anti-bleed clause on references.** Every reference carries baggage — a studio backdrop, the original subject's face, a wardrobe you don't want. Scope each asset with `ONLY`, then ban its baggage by name. Without this, multi-reference prompts fuse.
- **Trimming a long prompt by cutting numbers.** Trim identity prose and atmosphere adjectives. Never the specs.
- **No thesis sentence.** One line of directorial intent at the top resolves a dozen ambiguities below it. Skipping it is why prompts come out generic despite being long.
- **No contrast.** If the concept has only one pole — no cold-to-warm, no frozen-to-moving, no serious-frame-to-absurd-line — it isn't an idea yet. Go back before specifying.
- **Leaving the genre's cliché un-banned.** The model's default shape for any genre *is* the cliché: the 360° product spin, the drone reveal, the liquid morph, the plastic-skin beauty pass. Name it in the negative prompt or inherit it.
- **Omitting POSITIVE LOCKS on a long prompt.** Negations are weighted less reliably than affirmatives. Restate the non-negotiables as facts about the finished film.
- **Music by default.** Environmental SFX only unless the user asks. This holds across every mode.
- **Making the camera busy around something that must be perfect.** A face, a logo, a product: spend the motion budget on smoke, fabric, light and environment instead. `Moderate movement to maximise face stability` is a real instruction.
- **Static starts.** Models open on a beat of stillness by default. `Motion begins on frame one of every cut` fixes it.
