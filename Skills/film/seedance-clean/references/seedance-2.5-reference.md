# Seedance 2.5 — Deep Reference

Contents:
1. Specs and platform differences
1a. Higgsfield (the house platform)
2. Cost
3. Reference mode in depth
4. Keyframe mode
5. Edit mode
6. Extend mode
7. Clay render and grid storyboards
8. When to use one take vs. several takes
9. Full worked example
10. Sources

---

## 1. Specs and platform differences

| Spec | Value |
|---|---|
| Duration | 4–30s per generation, or Auto |
| Extension | Multiple rounds, each a standalone clip |
| References | Up to 50: 30 images, 10 videos (≤30s each), 10 audio |
| Resolution | 480p / 720p / 1080p on Runway and Hedra |
| Aspect ratios (Runway) | Auto, 21:9, 16:9, 4:3, 1:1, 3:4, 9:16 |
| Audio | Native, 10+ languages, can be toggled off |
| Output (Runway) | MP4, MOV |

**On "4K":** some coverage describes 2.5 as 4K-ready. As of the platforms checked (Runway, Hedra), output tops out at 1080p. Hedra states plainly that there is no 4K option. Upscale in post if delivery needs 4K.

**Platform availability:** Dreamina / Jimeng, Doubao, BytePlus ModelArk and Volcengine Ark (API), Runway, Higgsfield, Hedra, PixVerse, fal, OpenArt, Morphic, Luma, Kapwing, Picsart. Mode names and controls differ per platform. Runway calls its modes Reference / Keyframe / Edit / Extend; PixVerse calls them Video / Transition / Reference.

2.0 remains available alongside 2.5 on most platforms. It is not deprecated.

---

## 1a. Higgsfield (the house platform)

This is the platform the user works on. Its Seedance 2.5 contract, as exposed by Higgsfield itself:

| Parameter | Values | Notes |
|---|---|---|
| `mode` | `t2v`, `omni_reference`, `video_edit`, `video_extension` | Default `t2v`. Use `omni_reference` whenever there are references |
| `duration` | 4–30 | **Default is 5 seconds.** Always set it explicitly, or the take is cut short |
| `resolution` | 480p, 720p, 1080p | Default 720p |
| `generate_audio` | true / false | Default true |
| `bitrate_mode` | standard, high | High for final renders |
| `extension_mode` | forward, backward | **Required** for `video_extension`, **not allowed** in any other mode |
| `aspect_ratio` | auto, 21:9, 16:9, 4:3, 1:1, 3:4, 9:16 | Ignored in `video_edit` and `video_extension`; output follows the input video |

**Media roles:** `start_image`, `end_image`, `image_references`, `video_references`, `audio_references`.

**Billing quirk:** `video_edit` is billed by the **input video's full duration**, not by the length of the change. Fixing three seconds of a 12-second take costs the full 12.

**Prompt tags:** `@Image 1` … `@Image N` in upload order work on Higgsfield. Confirmed in production.

### Extension failures (status FAILED)

Two confirmed failures in production traced to the same setup. Check these first:

1. **Only the video goes in.** Loading character sheets or location images alongside the source video in `video_extension` is the most likely cause of FAILED. The subjects are already in the video; the sheets aren't needed. The prompt must not mention any `@Image`.
2. **Set `extension_mode`.** Forward or backward, explicitly.

### Prefer start-frame continuation over Extend

`omni_reference` with the previous take's **last frame as `start_image`**, plus the character sheets as `image_references`, gives continuity from the last frame **and** identity lock from the sheets. It is more robust than `video_extension` and keeps reference control. Default to this for continuing a take; use Extend when there is nothing to reference beyond the video itself.

Pairing `start_image` with `end_image` builds a controlled transition between two frames, the Higgsfield equivalent of a Keyframe mode.

---

## 2. Cost

- **Runway:** 1080p 68 credits/sec, 720p 30 credits/sec, 480p 20 credits/sec. Input video adds half again per second of input.
- **Volcengine Ark (official API):** reported at about 52% more per million tokens than 2.0.
- A 30-second 1080p take on Runway is 2,040 credits. A 10-second test at 720p is 300.

**Practical rule:** test at 480p or 720p and short duration. Commit to 1080p and full length only once the prompt is proven. Because billing is per second, never pad duration.

---

## 3. Reference mode in depth

The official structure binds each asset to a named subject, then refers to that name.

```
Define the woman in @Image 1, in the red dress and straw hat, as Subject 1.
Use @Image 2 for the venue.
The lead vocalist must strictly follow @Image 5.
Reference @Images 6 to 10 for the rest of the orchestra.
```

**Scoped exclusion** is the most useful 2.5 technique for reference sheets and product shots. Runway's own example:

```
@Image 1 defines the running shoe: its exact shape, the bone-white midsole
and the moulded white logo mark on the lateral side. Ignore its black studio
background. @Image 2 defines the runner and the visual style only: his face,
build, sleeve, shorts, stride and the cold-warm dawn grade. Ignore its
environment entirely.
```

**Video references** carry motion and camera. "Strictly follow the motion and camera work of @Video 1" is enough; don't re-describe the move frame by frame.

**Audio references** carry voice, rhythm or sound design.

**Grid storyboards** work as a reference for shot order and framing. Say explicitly that the grid is a sequence of shots, read in order, not one image.

---

## 4. Keyframe mode

Set a first frame and a last frame; prompt the motion between them.

Use for:
- A shot that must start or end on an exact composition (a hero frame, a logo lockup position).
- A **seamless transition between two unrelated locations**. First frame location A, last frame location B, and describe the move that connects them: an occlusion pass, a whip, a push through a doorway.

The first and last frames count separately from the 50 references.

---

## 5. Edit mode

Change an existing video from a prompt or a sketch. Output matches the input's aspect ratio and length (it may shift very slightly).

**Timestamp-targeted edits:**
```
Edit @Video 1. Keep the characters, actions and visual style unchanged.
Adjust only the camera movement. 0–4s: a micro-FPV move skims tightly past
the pan, then whip-pans to the coffee. 4–7s: push in and track laterally
along the rim of the pan.
```

**Background replacement:**
```
Using @Video 1, keep the subject intact and replace the green-screen
background. 0–4s: outdoor training ground. 4–10s: locker room.
```

**Sketch edits (Runway):** draw on a frame of the source video. The sketch becomes `@Image 1 at ss:SS`, pointing the edit at that moment. Works best in Edit mode.

**Use Edit instead of regenerating** whenever the take is mostly right. It holds everything you didn't mention.

---

## 6. Extend mode

Continue a video forwards or backwards.

- **Forwards:** describe what happens after the clip ends.
- **Backwards:** describe what happens before it begins. "Before video 1 starts, show the dancer walking onto the stage."

**Each extension is a standalone clip.** It contains only the new footage at the set duration; the original is untouched. Assemble the two in the edit. This means an extended film still has a seam, but the model matched the far side of it.

Official phrasing:
```
Extend the video. Continue from the visuals and subjects in @Video 1 and
generate another 30-second clip, keeping the character subjects, scene,
visual style and sound effects consistent. [What happens next.]
```

---

## 7. Clay render and grid storyboards

**Clay render / white model:** build the scene's spatial structure, character poses, motion paths and camera angles in textureless 3D. Reference it for blocking and camera; reference images for the look.

```
Refer to @Clay Render 1 for camera movement, pacing, shot-size transitions,
subject trajectory and blocking. Refer to @Image 2 for character design,
materials, lighting and colour.
```

2.5 also uses the clay render's spatial information to produce physically correct lighting: source direction, colour temperature, intensity and shadow projection.

This is the most precise blocking tool available. Worth it for complex camera moves, product assembly, anything where framing must be exact.

---

## 8. When to use one take vs. several takes

30 seconds in one pass is tempting. It is not always right.

**One take wins when:**
- Transitions between locations are the point of the film. They become free.
- Continuity across the whole piece matters more than any single shot.
- The piece won't be revised shot by shot.

**Several takes win when:**
- **The client will revise.** One changed shot in a single 30s take means regenerating the whole take, and approved shots change too. Edit mode helps but doesn't fully isolate a segment.
- A segment needs **frame-accurate timing**, for titles or a music sync. Timestamps land close, not exact.
- A counted object must be right (floors, people) and a miss would kill the whole take.
- The film is longer than 30 seconds anyway.

**The hybrid that usually wins:** group shots into blocks by what they share. Put continuous-motion sequences (a flight, a walk with transitions) into one take each. Keep revision-prone and timing-critical segments (the sales close, the logo) as separate takes.

---

## 9. Full worked example

A 9-second block: FPV flight landing into a handheld walk. Built on the four-part skeleton.

```
9 seconds, 16:9, one continuous take. Opens as photoreal FPV drone footage
and becomes raw consumer handheld documentary footage. Fine natural grain,
soft highlight roll-off.

ASSETS
Define the man in @Image 1 as Tomer, the woman in @Image 2 as Yael, and the
girl in @Image 3 as Noa. From each sheet take the face, hair and build only.
Ignore the cream studio backgrounds, the panel grid and the wardrobe
flat-lays. @Image 4 is the riverside park: the paved path, the eucalyptus
row with pale peeling trunks, the river on the right.

SUMMARY
An FPV drone dives from above a riverside park, skims the water, and lands
as a handheld camera walking beside a family of three at dawn.

TIMELINE
0–3s: FPV, 120° FOV. The drone dives at 50 km/h from 15 metres to 1 metre
above the water, rolling 25 degrees left as it banks toward the bank. End
state: skimming the surface, eucalyptus sweeping past on the left.
3–6s: Still FPV, 120° FOV. It climbs onto the paved path and closes on Tomer,
Yael and Noa from 15 metres behind, decelerating from 45 km/h to walking pace
and dropping to chest height. End state: 2 metres behind them, level.
6–9s: 47° FOV. The camera swings out to their left and walks alongside at
5 km/h. A constant 2 to 3 cm handheld tremor begins that was not there
before. Autofocus settles a beat late on Yael's shoulder. The three walk
camera-left to camera-right; Noa holds her mother's hand. End state: walking
alongside them, framing loose and slightly off-centre.

LIGHTING & COLOR
Available daylight only, 5600K. Low morning sun behind the eucalyptus on
camera-left: hard rim light on hair and shoulders, long bars of shadow
across water and path. Bright pale concrete underfoot fills the faces.
Base: pale concrete and silver water. Secondary: heather-grey cotton and
dusty rose knit. Accent: specular flashes off the river.

AUDIO
[Ambience] Air rush fading to footsteps on concrete, birds, leaves, a bicycle
bell, distant traffic.
[Voices] Indistinct background conversation, no intelligible words.
[Music] None.

HOLD
Screen direction stays camera-left to camera-right. The same three people
throughout, faces matching their references. Tomer in a heather-grey tee and
black shorts, Yael in a dusty rose sleeveless top and black leggings, Noa in
a mustard-yellow tee and denim shorts. The switch from drone to handheld
happens inside this take, with no cut. Keep the film free of on-screen text,
subtitles and watermarks.
```

---

## 10. Sources

- ByteDance Seed, "One-take Creation, Flexible Referencing: Introducing Seedance 2.5", 31 July 2026 — seed.bytedance.com
- Runway Help Center, "Creating with Seedance 2.5" — help.runwayml.com
- Volcengine Ark, official Seedance 2.5 Prompt Guide (as summarised by SunoMV, 7 August 2026)
- Hedra, PixVerse, Kapwing, Luma, OpenArt, fal and docs.seedance.tv platform guides, July–August 2026

Treat third-party guides as working practice, not specification. Where they disagree with ByteDance or the platform's own documentation, the platform wins. Re-check specs before a deadline-critical run; they are changing month to month.
