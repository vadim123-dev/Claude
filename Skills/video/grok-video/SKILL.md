---
name: grok-video
description: Write xAI Grok Imagine video prompts (text-to-video, image-to-video, reference-to-video, extend, edit) with native audio and dialogue — especially natural spoken Israeli Hebrew with full nikud, an English pronunciation guide and delivery notes for clean lip-sync. Use for any Grok / Grok Imagine video prompt, Grok reel or ad clip, or Hebrew speech in an AI video.
---

# Grok Imagine Video Prompts (with Hebrew dialogue)

Turn an idea, a scene description or a first-frame image into a ready-to-paste Grok Imagine prompt. Grok makes picture and sound in one pass, so the prompt directs both. Most requests are short 9:16 reels with Israeli characters speaking Hebrew; English and other languages follow the same rules without the Hebrew section.

## Specs (Grok Imagine Video 1.5, verified 2026-10)

| | |
|---|---|
| Modes | text-to-video, image-to-video (first frame), reference-to-video (1–7 reference images, no first frame), extend, edit |
| Duration | 1–15 s (t2v, i2v); reference-to-video up to ~10 s; extend adds 2–10 new seconds; edit takes ≤ ~8.7 s input |
| Resolution | 480p (default, use for tests) or 720p (final) — 24 fps |
| Aspect | 16:9, 9:16, 4:3, 3:4, 3:2, 2:3, 1:1 (i2v follows the image) |
| Prompt | up to 4096 characters |

## Core rules

1. **Front-load.** Grok renders in prompt order: the first sentence is the first thing that happens. Never leave the key action for the last sentence.
2. **Image-to-video: describe only what changes.** Don't re-describe faces, clothes or lighting already in the image.
3. **One action beat per clip.** Two or more beats or speakers → time-coded segments `(0-4s) … (4-8s) …`. Longer stories → chain with extend.
4. **One camera instruction.** Named moves: `camera locked, static` (default), `slow push-in`, `camera drifts gently left`, `tracking shot alongside [subject]`, `handheld following [subject]`.
5. **Dialogue = an exact line in double quotes, plus a tone.** Whatever is inside quotes is spoken. Never "he explains that…". Nothing else goes inside quotes.
6. **Always a `Sound:` line.** Specific ambience (material, distance: "muffled street noise through a window"), one or two effects, and music stated — or `no music`. Without it Grok adds random music.
7. **State things positively.** Negations ("no blur") are often ignored; say what you want ("sharp focus").
8. **No real people, celebrities, politicians, brands or logos** — moderation blocks them. Use fictional descriptors.
9. **No in-frame text.** It renders unstably; add captions in the edit (ffmpeg / HyperFrames).
10. **Be specific but short:** 3–5 focused scene sentences. Vague prompts get the most average version of the scene; long ones break.

## Hebrew dialogue (the key part)

Grok has no published Hebrew guidance, and unpointed Hebrew is ambiguous (ספר = sefer / sapar / siper). So every Hebrew line carries three layers of pronunciation help, and only the first one is spoken:

1. **The line in Hebrew script, inside quotes, with full nikud**, spelled in ktiv male (with ו/י as vowel letters) — two cues for the vowels.
2. **`Pronunciation guide (not spoken):`** — English-letter transliteration, syllables hyphenated, stressed syllable in CAPS.
3. **`Delivery:`** — in English: what the line means and the intent behind it, pace, where the pauses fall, intonation.

Plus: declare language and accent next to the line (`says in natural native Israeli Hebrew, [tone], no foreign accent:`) and again in Sound (`clear close dialogue in Hebrew`). Everything outside the quotes is English.

Read `references/hebrew-nikud.md` before writing the nikud and transliteration — it has the modern-Israeli rules (sheva, stress, בכ"פ, kamatz katan, gutturals) and the A/B test for when nikud hurts.

**Writing the line:**
- **Spoken Israeli register**, not textbook: אחי, וואלה, יאללה, סבבה, נו באמת, אין מצב, תקשיב. Avoid אינני / הנני / ברצוני unless formality is the joke.
- **Word budget ≈ 2 words per second, including pauses:** 5 s → 8–10 words, 8 s → 12–16, 10 s → 16–18. Prefixed words (וכשהגעתי) count heavy. When in doubt, cut — a packed line sounds rushed and breaks lip-sync.
- Numbers as words (שְׁלוֹשָׁה קִילוֹ). English loanwords only if Israelis use them, written in Hebrew letters (אוֹקֵיי, סוֹרִי).
- Comedy: punchline word last, then a silent reaction beat in the timeline.
- Two speakers: identify each by appearance and position ("the bald man on the left"), never only by name; one line per time segment; a short gap before the reply.
- Describe the voice: age, timbre, energy ("raspy middle-aged male voice, tired and sarcastic"). Keep the identical voice description across clips for consistency.

**Pauses and flow (in Delivery and punctuation):** name the pauses by the Hebrew word ("a short breath after 'אָחִי', a half-second beat before 'מָאתַיִם'"); "relaxed conversational pace, words slightly run together, not over-enunciated"; rising pitch on questions, a dip at the end of statements; mirror it in punctuation — `...` hesitation, `,` breath, `!` punch, `?` rise. A short natural filler ("נוּ", "אֶמְמ") before the line helps it sound unread.

## Image requirements for lip-sync

Front or three-quarter face, mouth visible and unobstructed, well lit, face big enough in frame. If the image is weak (profile, covered mouth, tiny face), say so in one line and suggest a tighter crop or regenerating the still (see `image-ref-gen`).

## Templates

### Image-to-video, one speaker
```
9:16. [Speaker by appearance] [action beat], looks at [camera / the other person] and says in natural native Israeli Hebrew, [tone], no foreign accent: "[שורה עם ניקוד מלא]". [Reaction / end beat]. Camera [locked, static / slow push-in].
Pronunciation guide (not spoken): [syl-LA-bles, STRESS in caps].
Delivery: [meaning and intent in English], [pace], [pauses by word], [intonation], natural conversational rhythm, not read aloud.
Sound: clear close dialogue in Hebrew, [voice description], [specific ambience], no music. [N] seconds.
```

### Two speakers (time-coded)
```
9:16. (0-4s) [Speaker A by appearance] says in natural native Israeli Hebrew, [tone]: "[שורה א]". (4-8s) After a short natural pause, [Speaker B by appearance] answers in natural native Israeli Hebrew, [tone]: "[שורה ב]". (8-10s) [Silent reaction beat]. Camera [move].
Pronunciation guide (not spoken): A: [transliteration]. B: [transliteration].
Delivery: A [meaning, pace, pauses, intonation]; B [meaning, pace, pauses, intonation]; natural conversational rhythm, not read aloud.
Sound: clear close dialogue in Hebrew, [voice A], [voice B], [ambience], no music. 10 seconds.
```

### Text-to-video
```
9:16, [shot type], [camera move]. [Subject + setting + light, concise]. [Speaker] says in natural native Israeli Hebrew, [tone]: "[שורה עם ניקוד]". [Action beat].
Pronunciation guide (not spoken): [transliteration].
Delivery: [meaning, pace, pauses, intonation].
Sound: clear close dialogue in Hebrew, [voice], [ambience], [music or no music]. [N] seconds.
```

### Extend (continues from the last frame)
```
[New action continuing from the final frame]. [Speaker] says in natural native Israeli Hebrew, [tone]: "[שורה עם ניקוד]".
Pronunciation guide (not spoken): [transliteration].
Delivery: [meaning, pace, pauses, intonation].
Sound: [same voice description as before], [cues]. Extend [2–10] seconds.
```

Non-Hebrew dialogue: same templates, replace "natural native Israeli Hebrew" with the language and accent, and drop the nikud. Keep a Pronunciation guide only for names or words the model is likely to misread.

## Checklist

- [ ] First sentence = first action; i2v doesn't re-describe the image
- [ ] One beat per segment; time codes for 2+ beats or speakers; one camera instruction
- [ ] Hebrew line: colloquial, in quotes, full nikud, ktiv male, within the word budget
- [ ] Pronunciation guide: outside quotes, labeled "not spoken", stress in CAPS
- [ ] Delivery: meaning, pace, pauses by word, intonation
- [ ] Language + accent declared next to the line and in Sound
- [ ] Sound line with voice, ambience, and music or "no music"
- [ ] No real names, brands, logos or in-frame text; duration and aspect stated

## Output format (compact — the user reads on a phone)

1. **Prompt** — one code block, ready to paste.
2. **The line(s)** — Hebrew with nikud · transliteration · short English meaning.
3. **Settings** — mode, duration, aspect, 480p for the test / 720p for the final.
4. **If it fails** — at most two fixes from Troubleshooting.

## Troubleshooting

| Problem | Fix |
|---|---|
| English accent or wrong language | Repeat "native Israeli Hebrew" in the action sentence and in Sound; shorten the line |
| Speaks the transliteration or the English meaning aloud | Make sure they're outside quotes and labeled "not spoken"; if it persists, drop the Pronunciation guide and keep meaning inside Delivery |
| A word is mispronounced or stressed wrong | Check its nikud and CAPS stress (references/hebrew-nikud.md); swap in a synonym; run the A/B test |
| Sounds read aloud / robotic | Loosen Delivery ("casual, words run together"), add a filler (נוּ / תִּשְׁמַע), cut words to make room for pauses |
| Rushed, no pauses | Cut 2–3 words; name the pause in Delivery |
| Lip-sync drifts | Shorter line, tighter front-facing frame, or text-to-video (no locked first frame) |
| Random music | `no music` in Sound |
| Action arrives late | Move it to the first sentence |
| Blocked by moderation | Remove names and likeness cues; generalize |

## Related skills

`image-ref-gen` for the first frame or character refs · `ai-video-analyzer` to check the result (ask Gemini to transcribe the Hebrew and flag mispronounced words) · `ai-video-editor` for captions, trims and stitching clips.
