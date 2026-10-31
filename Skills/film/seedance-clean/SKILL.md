---
name: "seedance-clean"
description: >
  Seedance 2.5 prompt-writing system (with a 2.0 fallback). Use whenever the user wants to write a Seedance prompt, build a cinematic shot, scene or one-take, turn a script beat or storyboard into a prompt, set up references and assets, edit or extend an existing Seedance clip, or asks about Seedance prompting technique. Trigger on "prompt for Seedance", "write a Seedance prompt", "Seedance 2.5", "make a scene where...", "build a shot", "one-take", "extend this video", "edit this clip". Output is a single standalone prompt. Always consult this skill before writing any Seedance prompt, and read the "What changed" table first — several 2.0 habits actively hurt 2.5 output.
---

# Seedance 2.5 Prompt Writer

Turn scripts, scenes and ideas into Seedance 2.5 prompts. Block, light and pace each take like a film.

**Output: always a single standalone prompt in a code block.**

Deep reference — modes, Edit/Extend syntax, platform specs, cost, a full worked example — lives in `references/seedance-2.5-reference.md`. Read it when you need Edit, Extend, Keyframe or clay-render work, or when the user asks about cost or limits.

---

## WHAT CHANGED FROM 2.0 — READ FIRST

These are not refinements. On several points the correct 2.0 answer is the wrong 2.5 answer.

| Topic | Seedance 2.0 | Seedance 2.5 |
|---|---|---|
| Max length per generation | 15s | **30s**, plus Extend for more |
| References per generation | ~12 (9 images, 3 audio/video) | **50**: 30 images, 10 videos (≤30s each), 10 audio |
| Timestamps | Unstable. The official guide said use `Shot 1 / Shot 2` and let the model pace | **First-class.** Highly responsive to whole-second timestamps |
| Multi-view character sheets | Not recommended | **Supported.** Turnarounds and expression sheets work as references |
| Re-describing the reference in text | Keep it minimal | **Don't re-describe at all** when the reference is precise. Text that restates the image conflicts with it |
| Negative phrasing | Positive only | Positive by default; **negatives allowed for format control**: subtitles, watermarks, music, cuts |
| Duration default | Always max (15s) | **Match the beats.** Billing is per second on major platforms, so padding costs money |
| Aspect ratio | 6 fixed presets | Wider range; 21:9, 16:9, 4:3, 1:1, 3:4, 9:16 on Runway |
| New reference types | none | Clay render / white model, grid storyboards, motion reference, audio reference |
| New modes | Generate only | **Reference, Keyframe, Edit, Extend** |

Seedance 2.0 is still available and roughly a third cheaper. It remains the right call for short, simple shots where timing can be left to the model. When writing for 2.0, use the fallback rules at the end of this file.

---

## CORE PRINCIPLE: WRITE THE VISIBLE

The model reacts to what can be **seen and measured**, not to mood words.

Translate every abstraction into something observable.
- ❌ "tense scene" → ✅ "man freezes, slowly clenches his fist, light only from the side, half his face in shadow"
- ❌ "cool cinematic shot of a car, epic, fast" → ✅ "low tracking shot alongside the car as it powers through a wet curve, headlights glowing, spray off the tyres, hard buffeting camera shake"

Write plain, instruction-style language. Clarity beats density. If a simple prompt works, keep it simple; add control only where the output drifts. Identity drifting means strengthen the reference. Timing wrong means add timestamps.

Before generating, "watch" the prompt as a viewer: is the first frame non-empty, is it clear where the subject is and where it looks, where is the light coming from, where does the take end.

---

## WORKFLOW

1. **Read as a director.** Find the dramatic shape: where the scene turns, lands, breathes.
2. **Pick the mode.** Reference, Keyframe, Edit or Extend. See below.
3. **Pick the duration.** Count the beats, give each room, stop there. Don't pad to 30s.
4. **Bind the assets.** Every uploaded file gets a number and a job.
5. **Write the four-part prompt** below.
6. **Run the checklist.**

If the idea is ambiguous, close the gaps in conversation first: blocking, angle, light, timing, what is in the first frame, how it ends. The model fills any gap on its own, usually not the way intended.

---

## CHOOSING THE MODE

| Mode | Input | Use when |
|---|---|---|
| **Reference** | Prompt + up to 50 assets | Most work. Characters, locations, style, motion from references |
| **Keyframe** | First frame + last frame + prompt | Exact control over how the shot starts and ends, including building a seamless transition between two frames |
| **Edit** | Existing video + prompt or sketch | The clip is close but one detail, action or camera move is wrong |
| **Extend** | Existing video + prompt | You need more footage before or after a clip you already have |

Mode names and controls vary by platform. **The house platform is Higgsfield**, where the modes are `omni_reference` (Reference), `video_edit` (Edit) and `video_extension` (Extend), and Keyframe is done with `start_image` + `end_image`. Three Higgsfield rules that break takes when missed: **duration defaults to 5 seconds** and must be set every time; **Extend takes the source video only**, with no image references; and **continuing a take works better as `omni_reference` with the last frame as `start_image`** than as Extend. Full Higgsfield contract and other platforms are in the reference file.

---

## PROMPT SKELETON — THE OFFICIAL FOUR PARTS

ByteDance's 2.5 guide prescribes a fixed four-part order: asset referencing, a one-sentence summary, the concrete plot, and closing constraints. Every official launch sample follows it. Use it as the outer shell and place the craft blocks inside it. Lighting gets its own paragraph between plot and constraints, because it is the highest-leverage modifier there is.

```
[FORMAT LINE]
Duration, aspect ratio, one-take or cut structure, overall look.

ASSETS
Bind every uploaded file to a role. What to take from it, what to ignore.

SUMMARY
One sentence: subject + place + event + genre/style + signature camera move.

TIMELINE
Timestamped beats (0–5s, 5–12s …) or Shot N. Per beat: camera, optics,
action, performance, physics. Each beat ends on a visible end state.

LIGHTING & COLOR
Dedicated paragraph. Direction + texture + contrast, Kelvin, three-layer palette.

AUDIO
Ambience, voices, music, each in its own bracket.

HOLD
Closing constraints across the whole take: continuity, identity, counts,
format, what the film never shows.
```

### Where the 2.0 blocks went

| 2.0 block | Now lives in |
|---|---|
| SCENE CONTEXT | SUMMARY |
| ACTIVE REFERENCES | ASSETS |
| LOCATION MAP | ASSETS (if referenced) + first TIMELINE beat |
| FIRST FRAME / BLOCKING | First TIMELINE beat |
| FORMAT MODE | FORMAT LINE |
| OPTICS, CAMERA, ACTION, PERFORMANCE, PHYSICS | Inside each TIMELINE beat |
| LIGHTING, COLOR GRADE | LIGHTING & COLOR |
| WARDROBE | ASSETS (if referenced) or HOLD |
| AUDIO | AUDIO |
| STYLE, OUTPUT SETTINGS | FORMAT LINE |
| POSITIVE LOCKS | HOLD |

---

## PART 1 — ASSETS

Every asset answers two questions: **whose is it, and what exactly should be taken from it.** If only part of it should be used, say what must not be inherited.

**Naming.** Default to the platform's numbering in upload order: `@Image 1`, `@Image 2`, `@Video 1`, `@Audio 1`, `@Clay Render 1`. If the user specifies tags, use theirs. Then **bind** each reference to a subject name and use that name throughout:

```
ASSETS
Define the man in @Image 1 as Tomer. Use his face, hair and build only.
Ignore the cream studio background, the grid layout and the wardrobe flat-lays.
Define the woman in @Image 2 as Yael. Face, hair and build only; same exclusions.
@Image 4 is the location: take the dirt path, poplar row, single cypress and
ploughed field. Ignore the framing borders.
```

**Rules:**
- **One narrow job per reference.** "@Image 1 controls the face only" beats "use @Image 1".
- **Don't re-describe what the reference already shows precisely.** Restating a face or a camera move conflicts with the asset. "Strictly follow the camera movement of @Video 1" is enough.
- **Do state critical small details in words**: logos, text, specific colours. The model can drop them.
- **Don't rely on names written on the image.** Labelling a photo "Tomer" and then writing "Tomer" confuses multi-character scenes. Bind in text.
- **Multi-view sheets are fine now.** Say which panels matter and to ignore the sheet's layout.
- **Short reference clips work better**: 5 to 10 seconds, not 30.
- **Reference only what's in this take.** A bound subject absent from the take gets forced into frame.
- **Eight or fewer subjects** stay reliable. Consistency slips beyond that.

---

## PART 2 — SUMMARY

One sentence that captures the whole take. It anchors every beat that follows.

```
SUMMARY
A family of three walks a riverside park path at dawn, filmed as one raw
handheld documentary take that ends on the daughter breaking away out of frame.
```

---

## PART 3 — TIMELINE

### Timestamps or Shot N

Both work on 2.5. Choose by how much timing matters.

| Structure | Use when |
|---|---|
| **Timestamps** `0–4s:` | Beats must land on a clock: music sync, title placement, a transition at a given second |
| **Shot N** | Order matters, exact length doesn't |
| **Single beat** | One simple action. Don't timestamp it |

**Timestamp rules:**
- **Whole seconds only.** `0–4s`, not `0.0s–1.4s`.
- **Continuous ranges, no gaps.** `0–3s, 3–7s, 7–15s`.
- **Timestamps guide pacing, they don't cut frame-accurately.** Actions land close to the boundary, not on it. For frame-level timing, cut in post.
- **Give each beat room.** Too little and the model improvises; too much and actions get dropped or the edit turns frantic. Several events crammed into two or three seconds is the most common failure.
- **Every beat ends on a visible end state.** It gives the beat somewhere to arrive: "End state: the fence post fills the entire frame."
- **One camera move per beat.**

### Inside each beat

Write the craft layers the beat needs in this order: **camera and optics → action → performance → physics.** Camera early. Pushed to the end, FOV gets ignored.

```
0–4s: Handheld at chest height, 47° FOV, operator walking alongside at
5 km/h with a constant 2 to 3 cm tremor. The three walk camera-left to
camera-right along the path; the daughter holds her mother's hand.
Autofocus settles a beat late on the mother's shoulder. End state: all
three centred, mid-stride.
```

### Transitions

2.5 handles transitions inside a single take well: occlusion wipes, whip pans, match moves. Write them as a timed event:

```
At 9s, the camera passes a thick eucalyptus trunk that fills the entire
frame, and emerges on the far side onto a narrow dirt path.
```

```
At 5s, whip-pan right and complete the transition on the far side of the blur.
```

Two unrelated locations with no physical link between them are more reliable through **Keyframe** mode (first frame location A, last frame location B) or two takes cut in post.

### Motion — the official caution

ByteDance's guide recommends **slow, continuous, small movements** and warns against high-burst action inside a shot: sprints, big jumps, tumbles. Those are where 2.5 breaks most often.

- **Hand energy to the camera and the edit**, not the body. A whip pan on a jog reads faster than a sprint the model fumbles.
- **Break movement down and quantify it.** "Slowly raises her right hand to shoulder height", not "she waves".
- **Write the connective tissue.** "Using the momentum of the turn, she swings her arm up" keeps motion continuous.
- **Externalise emotion into physical detail.** Not "relieved": "shoulders drop, she exhales through her nose, fingers loosen on the handrail".

When a brief genuinely needs a burst (a child sprinting, a fall), keep it short, give it its own beat, and have a cut-away ready.

---

## PART 4 — LIGHTING & COLOR

Give lighting **its own paragraph.** Lighting has the single biggest effect on image quality of any modifier, larger than style words or resolution tags. Write this paragraph well and "cinematic" can go from the rest of the prompt.

**Every lighting paragraph states:**
- **Direction**: where the key comes from, relative to camera
- **Texture**: hard or soft
- **Contrast**: low-key or high-key
- **White balance in Kelvin**, fixed for the take (3200K / 4000K / 5600K / 8500K)

**Colour in three layers**, as a grader would:
- **Base**: the large-area foundation. "Dry pale soil, warm off-white render"
- **Secondary**: tied to the subject. "Heather-grey cotton, dusty rose knit"
- **Accent**: one or two small recurring highlights. "A single dark cypress against the field"

Tie colour to **material + light + compositional role**, never a flat list.
- ❌ "the woman wears red, the man wears blue"
- ✅ "crimson silk scarf catching the cold tungsten spill from the corridor"

---

## AUDIO

2.5 generates audio natively in more than ten languages. Keep sound classes separate so they don't bleed:

```
AUDIO
[Ambience] Footsteps on concrete, birds, leaves, distant traffic.
[Voices] Indistinct background conversation, no intelligible words.
[Music] None.
```

- **No music by default** unless the user asks. Music baked in at generation can't be edited in post. The standard close is `Audio: no music, diegetic sound only.`
- For intelligible dialogue, confirm the target language is supported on the user's platform first.

---

## HOLD — CLOSING CONSTRAINTS

Every official sample ends with a "things to hold onto" section: rules for the whole take. Continuity lives here.

```
HOLD
Screen direction stays camera-left to camera-right. The same three people
throughout, faces matching their references. Sportswear unchanged from
first frame to last. The tower is exactly eleven storeys. Keep the film
entirely free of on-screen text, subtitles and watermarks.
```

Write each constraint once, positively where possible. Format-level negatives (no subtitles, no watermark, no music, no cuts) are fine; the official samples use them.

---

## STYLE — DISTRIBUTED, NOT A PREFIX

Style is a set of aspects, and each lives where it governs: light in LIGHTING & COLOR, lens in the beat's optics, skin and acting in the beat's performance, grain and format in the FORMAT LINE. Adapt every line to this scene.

**Equipment.** Format and stock descriptors appear in official examples and work: "shot on 35mm", "anamorphic", "tungsten-balanced colour negative", "fine photochemical grain", "natural halation". Brand and model names still add nothing. Describe the look, not the gear.

If the user supplies their own style or block text, use it verbatim.

---

## PROMPTING RULES

- **Positive by default.** ❌ "does not fall" → ✅ "stays upright, feet planted." Negatives only for format control.
- **Speeds in km/h.** ❌ "fast" → ✅ "moves at 40 km/h".
- **Atmosphere in percent or metres.** ❌ "light fog" → ✅ "fog density 40%", "haze visible at 15 metres depth".
- **Giant scale via human height.** ❌ "huge" → ✅ "as tall as four people stacked head to toe".
- **Left and right from the camera.**
- **Environment interaction stated physically.** Rain runs down hair, wind moves fabric.
- **Emotion through muscle and posture, not labels.**
- **English prompts** unless the user wants native-language dialogue generated.
- **No director names, no signature-work references.**

---

## OPTICS — SHOT SIZE, LENS, FOV

### Shot sizes
| Abbr | Meaning | In frame |
|------|---------|----------|
| ECU | Extreme Close-Up | a detail: eyes, button, headlight, hand |
| CU | Close-Up | full face / one element large |
| MCU | Medium Close-Up | head and shoulders |
| MS | Medium Shot | roughly to the waist |
| WS | Wide Shot | full figure + surroundings |
| EWS | Extreme Wide | scale, location |

### Focal length (mm, for thinking, not for the prompt)
| Lens | Effect | Use for |
|------|--------|---------|
| 24–35mm wide | space, slight perspective distortion | action, immersion, wides |
| 50mm normal | natural perspective | realism, neutral shots |
| 85mm portrait | soft bokeh, subject separated | portrait, emotion |
| 135mm+ tele | strong compression | observation, distance, sport |

### FOV anchor table (degrees, for the prompt)
| FOV | mm equiv | Purpose | When |
|-----|----------|---------|------|
| 180° | Fisheye | spherical distortion | POV, dream-state |
| 120° | FPV action cam | FPV drone, barrel distortion | FPV flight |
| 107° | 14–16mm | architectural ultra-wide | huge interiors, epic establish |
| 84° | 20–24mm | wide | establish, group blocking |
| 63° | 28–35mm | observational | wide observation, reportage |
| 47° | 40–50mm | neutral human perspective | universal establish, medium |
| 29° | 75–85mm | portrait compression | medium-isolate, dialogue bust |
| 18° | 100–135mm | natural portrait | close-portrait, identity-preserving |
| 12° | 180–200mm | tele-detail | hands, objects, detail-on-wide |
| 8° | 300–400mm | extreme compression | observation, broadcast |

Use only these discrete steps. Set FOV per beat and add "no drift within the beat" when it matters.

**Vocabulary 2.5 recognises reliably:** extreme wide, medium, close-up, push-in, pull-out, pan, tilt, low angle, overhead, one-take, aerial, FPV, dolly, whip-pan, wipe, dissolve, crane, orbit, handheld.

---

## OPTICAL TECHNIQUES

**Observation pattern (hidden-camera effect)**, all three at once:
1. Foreground occlusion: out-of-focus obstruction over 20–30% of frame.
2. Atmospheric haze between camera and subject.
3. Distance vantage: super-tele 8°–12°, operator anchored far away.

**Sports broadcast:** 8° super-tele + handheld 1–2 cm tremor + "anchored at distance, finding the action".

**Detail-on-wide (snake cam):** 84° FOV + low angle right up against a small object.

**Intimate wide:** 63–84° FOV on a close face, surroundings readable.

**Tele compressed air column** at 8°–12°: "dust suspended in the long compressed air column between camera and subject".

**Raw documentary realism:** handheld 2–3 cm tremor, autofocus settling a beat late, exposure lifting and recovering over half a second when the camera swings into sun, imperfect off-centre framing. Realism comes from the camera's imperfections, not from the subject.

---

## SPECIAL PROTOCOLS

**Extreme-FOV multi-beat consistency (8°, 107°, 120°):**
1. One location reference across all beats.
2. State the FOV at the start of each beat.
3. Confirm the FOV at the end of the beat.
4. Colour via material + light, not a list.

**Whip-pan.** Give the whip its own second in the timeline and say where it lands: "At 5s, whip-pan right; the blur resolves on the far side." The 2.0 finding that a whip under 0.8s renders as a hard cut has **not been re-verified on 2.5**. Test it before relying on it.

**Mixed time-speed (real-time + slow-mo):** give each speed its own beat and state the ramp. "The motion ramps into slow motion for one readable instant, then speed releases."

**Cracks/breaks without impact:** "crowd presses, not strikes", "fracture originates from edge stress", sequential timing edge-to-centre.

---

## LIMITS AND KNOWN WEAKNESSES

ByteDance names two weak areas on 2.5 itself: **physical plausibility of complex motion**, and **stability when several subjects interact.** Plan around both.

- Complex choreography between several people → fewer subjects, slower movement, more camera work.
- A child running with adults, a crowd reacting, a fight → give the burst its own short beat and plan a cut.
- A counted object (floors on a building, people at a table) → state the count in ASSETS and again in HOLD. Check it on every render.

---

## CHECKLIST

- FORMAT LINE states duration, aspect, one-take or cut structure, look?
- Duration matches the beats, not padded?
- Every asset numbered, bound to a subject, given one job, exclusions stated?
- No text re-describing what a precise reference already shows?
- SUMMARY is one sentence?
- Timestamps in whole seconds, continuous, no gaps?
- Each beat has room, one camera move, and a visible end state?
- Camera and optics first inside each beat?
- Bursts of motion minimised or isolated?
- LIGHTING & COLOR is its own paragraph: direction, texture, contrast, Kelvin, three layers?
- AUDIO classes separated, no music unless asked?
- HOLD covers continuity, identity, counts, and no on-screen text?
- Speeds in km/h, atmosphere in %/metres, left/right from camera?
- FOV from the anchor table?
- No director names, no brand or model gear names?

---

## FALLBACK: WRITING FOR SEEDANCE 2.0

Use when the user is on 2.0 or wants the cheaper model.

- **Max 15 seconds**, about 12 references.
- **No hard timestamps.** 2.0's own guide warns precise timing is unstable. Use `Shot 1 / Shot 2 / Shot 3` and let the model pace.
- **Avoid multi-view sheets.** One clean front-facing face image works better.
- **Short anchor line per reference is fine:** `@tag: age + build + unique features. 100% matches the reference.`
- **Positive phrasing only.**
- The four-part skeleton still helps; drop the timestamps from TIMELINE.
