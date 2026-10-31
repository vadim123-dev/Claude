# House Style — the visual language

This is the reference library's visual DNA, reverse-engineered from ~34 shipped prompts whose look was approved. When a brief doesn't specify otherwise, these are the defaults. Every value here appeared, explicitly, in prompts that worked.

The governing principle: **video models have ugly defaults.** Left alone they reach for a wide-angle lens, a floating drone move, flat global illumination, a plastic-skin beauty pass, and a slow 360° orbit. Every rule below exists to overwrite one of those defaults with a specific number or a specific ban. Specificity is not decoration — it is the only thing standing between the brief and generic AI output.

---

## 1. Optics — the lens is a hard number, never a vibe

Never write "cinematic camera." Write the focal length.

**The telephoto floor.** For premium, controlled, commercial-feeling work, set a floor and state it: `Every lens 50mm or longer.` Long glass compresses the background into stacked layers, flattens perspective, and reads as a real camera on a real rig. Wide lenses read as CGI and as phone footage.

| Focal | What it's for |
|---|---|
| 18–24mm | Deliberate FPV, low hero angles, tight interiors, in-trunk / under-bumper POV. Use *on purpose*, never as a default. |
| 28–35mm | Handheld documentary following. Natural human perspective. |
| 40–50mm | Locked side profiles, neutral coverage, medium close-ups. |
| 75–100mm | Compression. Portrait beauty close-ups. Stacking receding light strips or crowds behind the subject. |
| 135mm+ | Departure shots, collapsing a tunnel or road into converging rails, extreme isolation. |

**FOV in degrees is the alternative dialect** and is often more reliable: `63° observational wide`, `47° neutral human perspective`, `29° portrait compression`, `18° natural portrait compression`. Pair it with the instruction `FOV is set per segment and stays put — no drift mid-segment.` Models love to creep the focal length inside a shot; that line stops it.

**Camera height is a second hard number.** `hub height`, `bumper height`, `grille height`, `knee height`, `waist height`, `chest height`, `eye level`, `1.1 m`. Where premium realism matters, cap it: `Eye-level to hub-height only — NO overhead, no crane, no drone, no god's-eye.` The god's-eye shot is one of the loudest AI tells in existence.

**Standing optical bans for realism work:** no fisheye, no barrel distortion, no stretched edges, no drone, no impossible camera paths, no gimbal-perfect stabilization.

---

## 2. Camera behaviour — describe the rig, not the feeling

The approved prompts never say "smooth camera movement." They say where the operator or the rig physically is, and what it is doing relative to the subject.

- **Rig position + relative speed:** `camera on a lead rig ahead of the car and offset one lane left, receding on the tunnel axis at slightly less than the car's speed` — the relative-speed clause is what makes the gap open or close on screen. `speed matched exactly to the car` makes the subject appear frozen while the background rips.
- **Handheld with an amplitude:** `the frame breathing 1 to 2 cm with real weight and drift, lagging half a beat behind every movement`. The half-beat lag is the single most convincing handheld descriptor in the whole library — an operator reacts, it does not anticipate.
- **Operator geography:** `operator on the shadow side`. Free, and it instantly makes lighting read as motivated.
- **Motion starts immediately:** `Motion begins on frame one of every cut — never a static start.` and `Frame one is already in motion.` Models default to a beat of stillness at the head of every clip; this kills it.
- **Locked means locked:** for static work, over-specify — `completely static camera like a real phone held by someone filming, no cinematic movement, no zoom, no camera push-in, camera stays completely still`. One mention is not enough; the model needs the redundancy.
- **The near-locked push-in** is the house move for portraits: `a nearly locked cinematic portrait with an extremely subtle push-in`.

**Movement vocabulary that recurs:** slow lateral track, locked side-profile track, lead-rig recede, chase-rig with opening gap, over-the-shoulder rise, oblique lateral track, controlled 180° arc, whip pan, crash zoom, snap zoom, rack focus, focus pull, low push-in, orbit at a stated degrees-per-second.

**Numeric orbits** when precision matters: `circles the subject to the right at constant 1.1 m height and constant 4 m distance, covering a full 90 degrees at one steady rate of 22.5 degrees per second, the same speed in the first frame as in the last.` Stating the rate *and* that it is constant at both ends prevents ease-in/ease-out drift.

---

## 3. Cutting — hard cuts, motivated, or match cut

Never dissolves. Never morphs. The library is unanimous: `Hard cuts only — no dissolves, no fades, no whip transitions.` and `never liquid morphing`. Liquid morphing between shots is the definitive AI-video tell.

Four approved ways to get from shot to shot:

1. **Motivated cut** — the cut is caused by something in frame. `All cuts should be motivated by body movement, passing supporters, flags, concrete pillars or changes in camera direction.` `Cut through a supporter passing close to the lens.` A foreground object wiping the lens is the cheapest, most convincing transition available.
2. **Match cut on a shared shape or gesture** — the strongest structural device in the library. Chain them: hand-wrap tightening → racing glove tightening → visor lowering → visor lowering → inhale → inhale → downward jump → downward ski drop. Unrelated worlds become one sentence.
3. **Stride-matched cut** — `Use stride-matched transitions so every location changes precisely as one foot touches the ground.` Location changes, walk continues, and it reads as one uninterrupted journey.
4. **Flash cut** — `Each pose change is punctuated by a quick camera flash — a bright white burst with soft lens glare — so multiple flashes fire within a single setup, not only at the transition to the next one.` Turns a montage into a photo shoot.

**Timing is written to the decimal.** `five cuts of exactly 2 seconds each`. `Cuts land only at 1.4s, 2.8s, 4.6s, 6.2s and 7.9s; the camera holds its frame between them.` The second clause matters as much as the first — it tells the model to stop moving the camera between cut points.

---

## 4. Light — practical sources, named, with a temperature

Never "cinematic lighting." Name the physical source, its direction, its colour temperature, and what it does *not* do.

- **Practical only, and say so:** `Practical light only — overhead white LED tunnel strips running along both haunches, headlight spill on asphalt, red taillight glow.` `Natural light only, no artificial fill and no on-camera light.`
- **Refuse the fill:** `No fill, no bounce cards.` `Crushed blacks, heavy desaturation, no fill light.` `Hard raking pools of light with deep black falloff between them.` Falloff into real black is the difference between photographed and rendered.
- **Kelvin values:** `flat overcast sky at 8500K, cold and directionless` / `a 2800K amber spill pouring down the stairwell`. Two temperatures in one prompt gives the model a colour axis to travel along.
- **Direction, always:** `Light comes from the low sun at frame-left, raking across everything at head height.` `Single warm low firelight from the lower right rims the faces along the cheekbone, brow and beard — everything else falls into cold blue shadow.`
- **Haze to make light visible:** `Faint exhaust and dust haze catching every beam.` `low-sun haze at 35% density.` `Thin haze in the air.` Percentage density is a useful lie — the model responds to it.
- **Light as an event, not a state:** `tunnel light strips travelling across the panels as the car moves`, `a soft light slowly travels across the leather`, `an overhead strip sweeps across the decklid and down the quarter panel, then the car drops into the black gap between pools`. Light moving over a surface is what sells material.
- **Rim to separate:** `a narrow controlled rim light along the silhouette to separate it from the dark background`.

**Bans:** no blown highlights, no harsh artificial lighting, no excessive glow, no neon (unless the concept is neon), no cheap CGI lighting.

---

## 5. Colour — the grade carries the idea

- **The 60:30:10 ratio.** `60:30:10 — desaturated concrete grey dominant, cold blue-white light secondary, red taillight accent.` Three colours, weighted. This produces a graphic frame instead of a muddy one.
- **One pure colour, everything else dusty.** `Inside that warm frame the Campari is the single most saturated element — the crimson liquid is the only pure colour, everything else sits in dusty gold.` For product and brand work this is the whole grade strategy: desaturate the world so the product owns the only saturation in frame.
- **The grade can be the narrative.** Two worlds in one clip: `desaturated cyan-blue... blues held and every warm tone pulled down` for the first half, `warm amber gold... terracotta and honeyed skin` for the second, and the flip point is placed on the subject's body as she climbs a staircase — `the flip is the cut point of the whole piece.` When the grade changes, the story changes.
- **Anti-grade mode.** For credibility work the correct grade is none: `true-to-source dynamic range, no color grade`, `not cinematic`. State the absence.

---

## 6. The film-emulation stack

Stack these; they compound. Different combinations for different registers.

**35mm photochemical (premium narrative / fashion / commercial):**
`35mm photochemical film look, real film grain, gentle halation on clipped highlights, subtle gate weave, natural motion blur, 180-degree shutter, 24fps, wide tonal latitude with soft highlight roll-off, anamorphic, subtle horizontal flare on light sources, 2.39:1 letterboxed inside 16:9`

**Vintage compact digital / early-2000s (candid lifestyle, the most convincing "not AI" register in the library):**
`vintage compact digital camera aesthetic, early 2000s flash photography, handheld movement, tiny autofocus breathing, slight exposure shifts, natural rolling shutter, film grain, sensor noise, imperfect framing, realistic skin texture`

**Amateur phone (UGC / dashcam / found footage):**
`realistic amateur iPhone night footage, not cinematic — natural grain, motion blur only on the moving subject, true-to-source dynamic range, no colour grade, natural handheld micro-shake`

The insight underneath all three: **imperfection is the realism signal.** Autofocus breathing, exposure shifts, rolling shutter, imperfect framing, slight focus corrections, `realistic exposure adaptation when moving between shaded corridors and direct sunlight` — these are things only a physical camera does. Perfection reads as synthetic. Ask for the flaws by name.

---

## 7. Physics — the strongest realism lever available

More than lighting, more than grain: **objects behaving with mass is what makes a shot read as photographed.** Write the physics as its own block.

- **Mass and hinge:** `The taxi door carries real mass and swings on its hinge before latching.`
- **Inertia and lag:** `The silk skirt has inertia — it lags her body and settles a beat after she stops.` `the coat and skirt hem flare and settle.` Fabric that stops when the body stops is the tell of a bad generation.
- **Load and unload:** `suspension loads and unloads through the body, weight transfer visible in the roll, tires stay planted with correct contact shadow.` `Her heels load and unload on each stair tread with real contact shadows.` `front suspension compressed, nose sitting low.`
- **Contact, always:** `realistic contact with the surface`, `accurate contact shadows under the tires matching the ground`, `a hard contact shadow on the terracotta counter`. Floating is the most common failure; contact shadow is the cure.
- **Nothing floats:** `Gravity, inertia and mass respected. Nothing floats, nothing skates.`
- **Small-object detail:** `Ice cubes shift, click and resettle when the glass changes hands; the liquid tilts with real weight and clings to the glass wall; condensation beads and runs.`
- **Wind with a speed and a range:** `A steady 25 km/h wind crosses from camera-right to camera-left and acts on his clothing only. The open jacket panels lift and ripple away from his torso within a 12 cm range, two to three soft cycles across the four seconds.` A displacement range and a cycle count turn "hair blowing" into a controllable parameter.
- **Containment rules:** `Water, soap foam and brushes remain entirely outside the sealed cabin. The windshield wipers stay off.` State what must *not* cross a boundary; models leak water through glass.

---

## 8. Surface and material

Product and vehicle work lives or dies here.

`Automotive paint realism — metallic flake reading under moving light, real clearcoat reflections, sharp specular roll-off along the body crease lines, rubber-on-asphalt tire contact.`

`The leather must look like genuine premium leather. Visible but subtle natural grain. Realistic pores and texture. Soft controlled reflections. No plastic appearance. No synthetic CGI surface. Stitching must remain sharp and physically attached.`

`the real heavyweight cotton texture, natural wrinkles, seams, shoulder construction and subtle movement of the fabric as he walks.`

Three-part formula: **name the material → name its optical behaviour (flake / grain / pores / specular roll-off) → ban the plastic version.**

---

## 9. Performance and skin — restraint plus micro-life

**Skin at pore level:**
`Pore-level skin realism: vellus hair on her jaw and forearms, capillary flush high on her cheeks, real specular on the bridge of her nose and forehead under each light source, faint shine at the temple. Living eyes with visible catch-lights, real blinks, visible breathing throughout.`

**Acting direction, restrained:**
`Restrained naturalistic acting: micro-pauses before every reaction, precise eye-line, the smile built from the muscles around the eyes first and the mouth second. She is always mid-action or mid-reaction, never posed or waiting.`

That last sentence is the best performance note in the library. Models default to *posing*. "Always mid-action or mid-reaction, never posed or waiting" is the fix.

**Micro-life for near-static shots** — the vocabulary that brings a still to life without breaking it: slow head tilt, hair moves slightly in a warm breeze, shifts weight to the other foot, natural blinking, one soft blink, natural breathing, minimal head movement, a smile that arrives a half-beat late, shoulders drop a full inch, breath goes out.

**Emotion by physical symptom, not adjective.** For high-energy candid work, describe the body: `huge excited grins, eyes wide, laughing hysterically, gripping the sides, camera shaking as it follows them`. For restraint: `expressions must be restrained, authentic and focused. No smiling at camera.`

**Directing the non-actor is a real instruction:** `SOLDIER: does not speak, does not react beyond the initial flinch — he just stares down, frozen.` Without it, secondary characters overact.

**Face stability is a movement budget.** From the Ferrari prompt: `He looks ahead without turning his head sharply, in order to preserve his face and profile perfectly` and `Moderate movement to maximise face stability.` This is the key trade-off to state out loud — every degree of head rotation is identity risk. When the face is the deliverable, spend motion elsewhere: on smoke, fabric, light, the environment.

---

## 10. Audio — diegetic, layered, usually no music

Default: **no music.** `Environmental SFX only.` `No background music, only natural sounds.` `NO MUSIC. Absolutely no background music. No melody. No instruments. No beat.` Music baked in at generation time cannot be removed cleanly.

Write sound as a **layer list of physical events**, matched to what's on screen: `Suitcase thud, trunk suspension creak, lighter switch, wick flame, cigarette draw and exhale, distant wood cracking, layered fire, hinge springs and trunk latch.` `Flat-six engine snarl with a Doppler pass-by, tires rolling over dusty asphalt, quiet night ambience.` `big-displacement V8 exhaust, tunnel reverb tail, tire roar on concrete.`

Sound can also carry structure:
- **Progression:** `The sound becomes progressively stronger as the model leaves the corridor and enters the stands.`
- **Sync to a visual beat:** `deep bass hit and cymbal swell precisely synced with the weightless float moment at the 5 second mark`, `sharp percussive click synced with each rack-focus`, `camera shutter click on every cut`.
- **Silence as a hit:** `audio cutting to near-silence in the final half second for impact.`
- **Near-silence as a mood:** `Near silence, one sustained low sub-bass tone and a steady low airflow hiss.`

When music *is* wanted, tie it to the edit: `An upbeat rhythmic music bed drives the cuts, every hard cut landing on a beat.`

Always close with: `No dialogue. No subtitles.` (or the dialogue spec, if there is one).

---

## 11. Set and world design

- **Layer the location in three planes with a light direction.** `foreground wet asphalt mirroring an overcast sky, midground a taxi at the curb with its rear door open, background grey Barcelona facades and traffic in soft cyan haze at 15% density. Light comes from the flat white sky above and slightly camera-left.` Write this per world when a piece travels between worlds.
- **Practical sets, not CGI.** `Practical physical sets and believable practical effects, no glossy CGI look.` `stagehands move painted scenery behind them` — visible stagecraft is a look.
- **Minimal for product.** `The environment must remain minimal. Do NOT fill the frame with unnecessary props. The product is the hero.`
- **Composition:** rule of thirds or dead centre, stated. `car on a strong third or dead centre`. `honest negative space above her`. `Leave clean negative space around the product.` `Full subject in frame at all times — never crop.`
- **Crowds are choreographed, not summoned.** `controlled crowd choreography`, and then ban the failures: `no duplicated supporters, no frozen crowd members, no synchronized crowd movements`.
- **IP hygiene in real-world locations:** `red and black flags without official club crests, sponsor logos or readable text. No readable advertising boards. No distorted signs.` Models invent garbled logos and text; ban them explicitly.
