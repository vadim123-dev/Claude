# Prompt Anatomy — the block architecture

Every prompt in the approved library, from the 12-word ones to the 1,400-word ones, is built from the same set of blocks. The long ones use all of them. The short ones use two or three. **Nothing in the library is a flowing paragraph of description** — even the shortest are declarative and structural.

Learn the block set, then choose which blocks the job needs. That choice is the craft.

---

## The block set, in order

| # | Block | What it does | When to include |
|---|---|---|---|
| 0 | **THESIS** | One sentence of directorial intent before any spec | Any piece with a point of view |
| 1 | **FORMAT / HEADER** | Duration, aspect, platform, cut count, fps | Always |
| 2 | **ACTIVE REFERENCES / MANIFEST** | Scoped role per asset + anti-bleed rules | Whenever any reference is attached |
| 3 | **SUBJECT** | Identity spec, or product fidelity spec | Always |
| 4 | **LOCATION MAP** | Fg/mid/bg planes + light direction, per world | Multi-world or built environments |
| 5 | **FIRST FRAME / BLOCKING** | Where everyone is at t=0, already in motion | Anything with a defined opening |
| 6 | **FORMAT MODE / CUT SHEET** | Exact cut times, or "single continuous shot" | Multi-shot pieces |
| 7 | **OPTICS** | Focal length or FOV per shot, plus drift lock | Always |
| 8 | **CAMERA** | Rig position, height, relative speed, handheld amplitude | Always |
| 9 | **ACTION** | Timecoded beats, verbs, no adjectives | Always |
| 10 | **PERFORMANCE** | Micro-behaviour, restraint level, eye-line | Any human subject |
| 11 | **PHYSICS** | Mass, inertia, contact, wind, containment | Almost always |
| 12 | **LIGHTING** | Sources, direction, Kelvin, no-fill rules | Always |
| 13 | **COLOR GRADE** | Palette weighting, arc, saturation policy | Always |
| 14 | **WARDROBE / SURFACE** | Continuity spec, material optics | Fashion, product, vehicle |
| 15 | **AUDIO** | Diegetic layers, music policy, sync points | Always |
| 16 | **STYLE** | Film-emulation stack | Always |
| 17 | **OUTPUT SETTINGS** | Resolution, fps, grain, speed | Long-form / premium |
| 18 | **POSITIVE LOCKS** | Every requirement restated as an affirmative | Any prompt over ~150 words |
| 19 | **NEGATIVE PROMPT** | Named failure modes only | Any prompt over ~150 words |

Use ALL-CAPS labels. They function as structural signposts and they survive being pasted into any UI.

---

## Block 0 — THESIS: the sentence that sets the register

The best prompts in the library open with a statement of intent, and it changes everything downstream.

> `This is not a traditional fashion commercial. It should feel like a talented documentary filmmaker noticed the shirt inside the crowd and began following it instinctively.`

> `Looks exactly like a casual real Instagram reel filmed on iPhone.`

> `The result must look like real dashcam/phone footage of this exact car parked in this exact yard, not a CGI render.`

> `Time is frozen on the field. The camera orbits the man while the world holds still.`

One sentence, and every ambiguity below it resolves correctly. Write the thesis first, then the spec — and make the spec obey the thesis. If the thesis says *documentary*, the camera block cannot say *gimbal-perfect*.

---

## Block 2 — ACTIVE REFERENCES: the highest-leverage block in the library

This is the single most sophisticated pattern in the reference set, and the one to internalise most deeply. It has three parts.

### 2a. One unique token per asset, never reused

`@image1`, `@image2`, `@image3`, or `<<<image_1>>>`, or a named token like `@Ava-marcelline`. Two different references must never share a number — they fuse into one entity and identity collapses.

**Seedance 2.5:** platforms number references as `@Image 1`, `@Video 1`, `@Audio 1` in upload order. The official 2.5 guide then binds each to a name ("Define the woman in @Image 1 as Ava") and uses the name from there on. It also warns against relying on names written on the image itself. The manifest pattern below is exactly what 2.5 wants.

### 2b. A scoped role per asset — and the scope word is `ONLY`

```
REFERENCE MANIFEST:
@image1 = primary face identity ONLY (fair skin, light freckling, hazel-green eyes, straight centre-parted blonde hair)
@image2 = body proportions and silhouette ONLY (tall, slim frame)
@video1 = choreography, timing, framing progression, camera behaviour and location atmosphere ONLY
```

Other roles seen in the library: `subject identity anchor`, `outfit anchor`, `absolute product reference for the front`, `absolute product reference for the back`, `visual aesthetic, camera type, lens texture, lighting and colour grading`, `location reference`, `strict reference for camera movement, camera path, panning speed, smoothness, framing and background environment`.

Note what this makes possible: an asset can contribute *only its grade*, or *only its camera path*, or *only its silhouette*. A reference is not "use this picture" — it is a typed input with a declared channel.

### 2c. Anti-bleed — name what must NOT come across

This is the part that gets skipped, and it is what actually makes multi-reference prompts work. On Seedance 2.5 it is officially endorsed: Runway's own 2.5 examples say "Ignore its black studio background" and "Ignore its environment entirely". Every reference carries unwanted baggage; say what the baggage is.

```
Do not import the grey studio backdrop or the taupe bodysuit from @image1/@image2 into the scene.
Use @video1 only as a blueprint for walking choreography, camera behaviour, framing progression, timing
and street atmosphere. Do not copy, preserve, overlay or face-swap the tanned brunette woman shown in
@video1 — her identity, skin tone and hair colour must never appear in the output.
Keep the assigned face and body identity stable in every frame.
```

The formula: **for every reference, ask "what else is in this image that I don't want?" and ban it by name.** Backdrops, wardrobe, the original subject's identity, skin tone, hair colour, lighting baked into the plate.

### 2d. Product-reference fidelity — the enumerated inventory

Where the deliverable *is* the product, list every attribute that must survive, then ban every verb of alteration.

```
Preserve the exact grey colour, heavyweight cotton texture, oversized boxy silhouette, dropped shoulders,
wide sleeves, collar shape, sleeve length, lateral openings, stitching, small front detail, large
monochromatic lion artwork on the back, artwork scale, artwork placement and lower rubber label.
Do not redesign, recolour, simplify, mirror, crop, replace or reinterpret any detail.
```

Add measurable fidelity requirements: `The back artwork must be visible during at least 70 percent of the video. The artwork must never move independently from the fabric.` The second clause fixes the most common product failure — a print that slides across the garment like a decal.

---

## Block 5 — FIRST FRAME: start on a verb

```
Frame one is already in motion: the woman is at the open rear door of the taxi at frame-right, weight
already dropping into the car, phone in her left hand, sunglasses on her face, skirt hem still swinging
from the last stride. Camera is on the shadow side, low and camera-left of the door, curb line running
along the lower third.
```

Three things at once: subject position and *momentum*, camera position, and a compositional anchor. Compare to the continuation dialect for image-to-video: `Continue from the first frame. Same location, same light, same grade — do not change the environment.` — short, and the three "same"s are doing all the work.

---

## Block 6 — CUT SHEET: decimals and hold instructions

```
FORMAT MODE: Timed multishot. Six segments, five explicit HARD CUTs at 1.4s, 2.8s, 4.6s, 6.2s and 7.9s.
Cuts land only at those points and the camera holds its own frame between them.
```

Or the uniform version: `Total runtime 10 seconds, five cuts of exactly 2 seconds each, hard cuts, no dissolves.`

**Seedance 2.5 note.** The decimal cut sheet above comes from the reference library and works on models that honour sub-second cues. Seedance 2.5 follows **whole-second, continuous ranges** (`0–3s, 3–7s, 7–15s`), and its timestamps guide pacing rather than cut frame-accurately: actions land close to the boundary, not on it. For Seedance 2.5 round to whole seconds, and put any cut that must be frame-exact in the edit. Seedance 2.0 is the opposite case: its official guide calls precise timing unstable and prefers `Shot 1 / Shot 2` with no timestamps.

Or the negation: `Continuous single shot, no scene changes.` / `one continuous shot, no cuts.`

For platform work, a header line does the same job: `[PLATFORM: Instagram Reels 9:16] [DURATION: 10s] [CUT RHYTHM: fast-cut beat-synced] [SHOTS: 10]`.

---

## Block 9 — ACTION: the timecoded beat sheet

The default structure for anything multi-shot. Two dialects:

**Timecode-led (documentary, narrative, ads).** On Seedance 2.5 write these in whole seconds (`0–2s`, `2–5s`) and end each beat on a visible end state:
```
0.0s to 1.4s — She drops into the taxi's back seat in one hurried motion and pulls the door shut behind
her; the coat and skirt hem flare and settle. Traffic slides past behind at 30 km/h. Cold cyan, wet
asphalt, sunglasses on.
1.4s HARD CUT
1.4s to 2.8s — Inside the moving taxi, cold window-light rakes her face from camera-left...
```

**Shot-led (commercial, product):**
```
CUT 1 — 0.0s to 2.0s. Front three-quarter tracking wide, 85mm telephoto, hub height, camera on a lead
rig ahead of the car and offset one lane left, receding on the tunnel axis at slightly less than the
car's speed: [then what reads in frame, what the light does, what the tires do]
```

The shot-led dialect puts **all four camera parameters in the shot header** — framing, focal, height, rig behaviour — then describes content after a colon. Steal this format; it is the cleanest in the library.

Writing rules for beats:
- Verbs, not adjectives. `She takes it, the ice shifting and clicking as the glass changes hands, lifts it and drinks.`
- One beat = one meaningful unit of time *and* a framing change.
- Name what "reads" in frame — `Front end reads clean: black mesh grille, four round lamps, chrome bumper, hood pins, twin white stripes running back over the hood.` The verb *reads* tells the model this is a legibility requirement, not decoration.
- Include the environment's speed: `traffic slides past behind at 30 km/h`, `she climbs at 4 km/h`.

---

## Block 18 — POSITIVE LOCKS: restate everything as an affirmative

An underrated block, and the reason the most controlled prompts in the library hold together. After the spec, restate every non-negotiable as a positive statement. Models weight affirmatives more reliably than negations.

```
POSITIVE LOCKS
The same woman in all six segments, face 100% matching @image1.
The same printed silk shirt, matching midi skirt and olive cap-toe mules in all six segments.
Sunglasses on her eyes through 2.8s, pushed up into her hair from the staircase, staying in her hair to the end.
Cuts land only at 1.4s, 2.8s, 4.6s, 6.2s and 7.9s; the camera holds its frame between them.
FOV is set per segment and stays put — no drift mid-segment.
Cold cyan holds through 2.8s, flips across her body on the staircase, warm amber holds from 4.6s to the end.
Handheld texture in every segment, the frame breathing 1 to 2 cm.
One time of day per world: flat overcast on the street, low golden sun on the terrace.
```

```
POSITIVE LOCKS
The camera completes a full 90 degrees of orbit across the four seconds.
His joints, limbs and head hold completely still. Only his clothing moves.
His feet stay the same distance in every frame.
Vehicles, pedestrians, screens and sky hold one single instant throughout.
```

Rule of thumb: anything you'd be angry about if the generation got it wrong belongs in POSITIVE LOCKS, phrased as a statement of fact about the finished film.

---

## Block 19 — NEGATIVE PROMPT: failure modes, not aesthetics

A negative prompt is not a list of things you find ugly. It is a list of the specific ways this model breaks. Group them.

**Identity failures:** face change, identity drift, face morphing, different person, altered facial proportions, distorted nose, altered lips, changing beard, beard flickering, skin tone change, deformed head, duplicated face, asymmetrical eyes, warped mouth, unstable profile, duplicate subject.

**Anatomy failures:** warped hands, extra fingers, malformed hands, floating hands, extra limbs, duplicated limbs, malformed legs or feet, anatomical errors, joint deformation.

**Temporal failures:** temporal inconsistency, flickering, morphing between frames, morphing between poses, slow transitions, liquid morphing, jitter, rolling-shutter wobble, changing outfit between cuts, sliding feet, floating limbs.

**Physics failures:** floating objects, no contact shadow, smoke clipping through face, sliding print on fabric, product changing shape or scale.

**Aesthetic-slop failures:** CGI look, AI look, plastic skin, over-sharpened, beauty filter, perfect symmetry, oversaturated colours, excessive bokeh, cinematic anamorphic lens flare, cartoon look, 360-degree product spin, floating product, endless orbit, excessive particles, neon lighting, heroic posing, exaggerated slow motion, fashion runway walking, robotic body motion, synchronised crowd movement.

**Frame-contamination failures:** text, watermark, subtitles, captions, logos, readable advertising, distorted signage, magazine page, paper texture, split screen, collage.

**Pick the groups that apply.** A locked-camera portrait needs the temporal and identity groups; it does not need the crowd group.

**The most useful negatives are the named clichés of the genre you're working in.** For product video: `NOT like a generic AI product video, cheap CGI, 360-degree product spin, floating shoe, random camera movement.` For fashion: `no heroic posing, no fashion runway walking.` Naming the cliché is how you escape it — the model has a strong prior toward exactly those shapes, and only an explicit ban overrides it.

---

## How long should a prompt be?

The library ranges from 12 words to 1,400. Both extremes worked. The rule that explains it:

> **Words spent telling the model what a reference already shows are wasted and actively harmful. Words spent overwriting the model's bad defaults are the highest-value words in the prompt.**

So:

| Situation | Length | Why |
|---|---|---|
| Animating a strong still, idle life only | 10–40 words | The image is the spec. `slow camera movement. bring the subject & environment to life` |
| Continuation from a first frame | 40–120 words | Three "same"s plus the beat sheet |
| UGC / reel with one gag | 120–250 words | Static-camera redundancy + the gag + the line + realism bans |
| Multi-shot social / fashion montage | 250–500 words | Per-shot framing + rhythm device |
| Premium commercial, product or vehicle hero | 600–1,400 words | Every default must be overwritten; the spec-stack is the deliverable |
| Object replacement in existing footage | 150–350 words | Plate-protection language is dense but narrow |

Two corollaries worth stating plainly, because they resolve an apparent contradiction with the "keep prompts lean" rule elsewhere in this skill:

1. **Identity descriptions stay lean.** A character sheet or an identity block gets 30–60 words of stable traits. Scene atmosphere in an identity block is contamination — it locks the character to one scene. This rule does not change.
2. **Craft specification goes maximal.** Camera, lens, height, light, physics, cuts, grade, audio: here, more specific is strictly better, because every unstated parameter is a parameter the model fills with its worst instinct.

Lean about *who*. Maximal about *how it's shot*.

---

## Special-purpose dialects

### VFX insert — replacing a screen or an element inside a plate

```
Vertical 9:16, overhead POV looking down at a person's hands holding a smartphone, blurred out-of-focus
figure and concrete pavement behind, static handheld framing matching the original photo. The phone
screen, previously a green chroma-key surface, now displays [FULL DESCRIPTION OF INSERTED CONTENT].
The thumb makes a subtle scrolling gesture as the footage plays continuously. Natural daylight, slightly
desaturated documentary grading, shallow depth of field on the background, subtle handheld micro-movement.
Duration: 3-4 seconds.
```

Key move: name the *original* state of the region (`previously a green chroma-key surface`), then the new content, then restate the plate's grade, DOF and handheld character so the insert inherits them.

### Object replacement — protecting the plate

```
Replace only the [ORIGINAL OBJECT] with [NEW OBJECT] from @image1.
Crucial: do not alter, modify or blur any part of the background. The wall, street, sidewalk, power lines
and neighbouring houses must remain 100% identical to the original video.
Match its exact position, size, angle and orientation as the original object at every frame.
Keep the same camera trajectory, same panning speed, same shake/stabilisation, same lighting changes
throughout the shot.
Photorealistic natural daylight consistent with the original footage, realistic reflections of the tree
branches and sky on the paint, accurate contact shadows under the tires matching the ground.
No floating or warping of the body during camera motion, no flickering or morphing between frames.
The result must look like real phone footage of this exact object in this exact place, not a CGI render.
```

Five required elements: `replace only` + an enumerated protect-list + per-frame geometric match + inherited light/reflection/contact-shadow + the anti-CGI thesis.

### Staged-content language for sensitive setups

Real productions describe hazardous or edgy elements as what they physically are on set: props, staged, controlled, nonfunctional, breathable, no visible harm, seamless invisible compositing. The library does this too, in a `Production lock:` block. Two reasons it works: it is accurate to how the shot would really be made, and it steers the generator toward the *appearance* of the beat rather than the thing itself. Use the same language for stunts, fire, weapons and impacts — and keep the content itself within what the platform and the client will actually accept. Where a brief can't be staged that way, say so and reshape the beat rather than sharpening the prompt.
