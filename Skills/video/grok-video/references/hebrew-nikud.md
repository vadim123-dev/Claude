# Hebrew nikud and transliteration for spoken video

Goal: the model says the line the way an Israeli would say it today. Nikud tells it which vowels; the transliteration tells it stress and modern pronunciation that nikud can't show. Write both from how the line *sounds* in modern Israeli speech, not from classical grammar.

## Nikud: what to mark

Mark every letter (full nikud), and pay most attention to the marks that change the sound:

| Mark | Why it matters | Example |
|---|---|---|
| Dagesh in ב כ פ | b/v, k/kh, p/f | בָּא (ba) vs. אָבָא (A-ba) · כֶּסֶף (KE-sef) vs. אָכַלְתִּי (a-KHAL-ti) · פֹּה (po) vs. אֶפֶס (E-fes) |
| Shin / sin dot | sh vs. s | שָׁלוֹם (sha-LOM) · שָׂמֵחַ (sa-ME-akh) |
| Vav with holam / shuruk / consonant | o / u / v | שׁוֹמֵר (sho-MER) · שׁוּק (shuk) · וַדַּאי (va-DAI) |
| Patach under final ח / ע (patach gnuva) | the vowel comes *before* the consonant | שָׂמֵחַ (sa-ME-akh) · יוֹדֵעַ (yo-DE-a) |
| Kamatz katan | looks like "a" but is "o" | כָּל (kol) · צָהֳרַיִם (tso-ho-RA-yim) — always spell it out in the transliteration |
| Sheva (see below) | silent or "e" | |

**Ktiv male + nikud:** keep the full spelling with vowel letters (שׁוּלְחָן, not שֻׁלְחָן; אִימָא) — the model gets the vowel from both the letter and the point.

**Spoken forms win.** If Israelis say it differently from the textbook, point the spoken form and transliterate it that way: תַּקְשִׁיב / תִּשְׁמַע, אֵין מַצָּב, עַכְשָׁיו (akh-SHAV), אֲנִי יוֹדֵעַ (a-NI yo-DE-a).

## Sheva in modern Israeli Hebrew

Modern speech ignores the classical na/nach rules. Write the transliteration from how it's actually said:

- Usually **silent** at the start of a word, forming a cluster: שְׁתַּיִם (SHTA-yim), כְּבָר (kvar), סְלִיחָה (sli-KHA), תְּמוּנָה (tmu-NA).
- **Said as "e"** when:
  - it sits under a prefix letter ו ב כ ל מ ש: בְּסֵדֶר (be-SE-der), לְהַגִּיד (le-ha-GID), וְאָז (ve-AZ)
  - the first letter is י ל מ נ ר: מְאוֹד (me-OD), נְסִיעָה (ne-si-A), רְחוֹב (re-KHOV)
  - a cluster would be hard to say, e.g. before a guttural: תְּאוּרָה (te-u-RA)
- In the middle of a word it's usually silent: מַשְׁהוּ (MASH-hu), יַלְדָּה (yal-DA).

When unsure, the transliteration decides — the model follows it more reliably than the sheva.

## Stress

Nikud doesn't show stress, so the CAPS syllable carries it. Mark every word.

- **Default: last syllable** (mil'ra): a-NI, kha-YAV, sha-LOM, to-DA, mish-pa-KHA.
- **Second-to-last** (mil'el) for:
  - segolates: KE-sef, YE-led, BO-ker, E-rev, SE-fer
  - most slang and loanwords: SA-ba-ba, YAL-la, O-kei, TE-le-fon — but ba-la-GAN and a-KHI are final
  - many names: MO-she, DA-vid (colloquial), YO-si
  - common everyday words: RE-ga, EI-fo (אֵיפֹה), be-SE-der — check each one, don't guess
  - spoken past tense often reduces: הָלְכָה = hal-KHA (spoken) rather than ha-le-KHA (formal)
- **Final ח / ע with patach gnuva:** stress stays on the syllable before it: sa-ME-akh, yo-DE-a.
- Wrong stress is the most common reason a word sounds foreign. If a word keeps coming out wrong, swap it for a synonym.

## Transliteration conventions

- Hyphens between syllables, stressed syllable in CAPS, English letters only, outside quotes, labeled `Pronunciation guide (not spoken):`.
- `kh` = ח and כ without dagesh (the throat sound in "loch"). `ts` = צ. `sh` = שׁ. `r` = Israeli guttural r (say so once in Delivery if needed: "guttural Israeli r").
- ע and א are glottal or silent in everyday speech — don't write them; write the vowel: עַכְשָׁיו = akh-SHAV, אֲבָל = a-VAL.
- ה at the end of a word is silent; in fast speech it often drops mid-word too (מָה הוּא אָמַר → ma-u a-MAR) — transliterate the natural reduction when the delivery is casual.
- Apostrophe sounds: ג׳ = j (ג׳וּק, jook), צ׳ = ch (צ׳וּפָּר), ז׳ = zh (ז׳וּרְנָל).

## English meaning in the prompt

Put the meaning in English inside `Delivery:` ("he's sarcastically agreeing to pay, really annoyed") — it helps the model pick the emotion and stress the right word. Never inside quotes, and never as its own line the model might read out.

## A/B test when a line sounds wrong

There's no published test of how Grok reads Hebrew nikud, so check with the user's own clips:

1. **A:** full nikud + Pronunciation guide (the default).
2. **B:** same line without nikud (ktiv male only) + the same Pronunciation guide.
3. **C (only for a stubborn word):** nikud on just that word.

Generate at 480p, same seed/image if available, and compare — or have `ai-video-analyzer` transcribe each clip and list mispronounced words. Keep whichever works and note it for next time.
