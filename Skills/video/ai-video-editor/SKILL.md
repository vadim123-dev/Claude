---
name: ai-video-editor
description: Edit videos using ffmpeg and yt-dlp — trim, cut, merge, remove silences, auto-edit podcasts, create shorts from long videos, add subtitles (SRT burn-in), extract audio to MP3, download and clip YouTube videos, batch process folders of clips, add transitions/fades, adjust speed, normalize audio, and resize for social media. Works with the ai-video-analyzer skill for intelligent editing decisions. Use when the user wants to edit a video, cut clips, make shorts, remove silence, edit a podcast, add subtitles, extract audio, download from YouTube, merge clips, or batch process video files.
allowed-tools: Read, Write, Edit, Bash, Glob
---

# AI Video Editor (ffmpeg + yt-dlp)

Edit any video like a pro — trim, cut, merge, remove silences, add subtitles, create shorts, extract audio, and more. All from Claude Code.

## Prerequisites

Both tools must be installed on the user's system:

```bash
# Check if installed
ffmpeg -version
yt-dlp --version
```

### Install if missing

**ffmpeg:**
- Windows: `winget install FFmpeg` or download from https://ffmpeg.org/download.html
- macOS: `brew install ffmpeg`
- Linux: `sudo apt install ffmpeg`

**yt-dlp:**
- All platforms: `pip install yt-dlp` or `pipx install yt-dlp`
- Windows: `winget install yt-dlp`

---

## Core Operations

### 1. Get Video Info

Always start by understanding the file:

```bash
ffprobe -v quiet -print_format json -show_format -show_streams "input.mp4"
```

Quick version:
```bash
ffmpeg -i "input.mp4" 2>&1 | grep -E "Duration|Video:|Audio:"
```

### 2. Trim / Cut Video

```bash
# Cut from 00:30 to 01:45 (fast, no re-encode)
ffmpeg -i input.mp4 -ss 00:00:30 -to 00:01:45 -c copy output.mp4

# Cut first 15 seconds (for a short/reel)
ffmpeg -i input.mp4 -t 15 -c copy short.mp4

# Cut last 30 seconds
ffmpeg -sseof -30 -i input.mp4 -c copy ending.mp4
```

**Key flags:**
- `-ss` = start time (HH:MM:SS or seconds)
- `-to` = end time
- `-t` = duration
- `-c copy` = no re-encode (fast, lossless)
- `-sseof` = offset from end of file

### 3. Remove Silences (Auto-Edit)

**Step 1: Detect silences**
```bash
ffmpeg -i input.mp4 -af silencedetect=noise=-30dB:d=0.5 -f null - 2>&1 | grep silence_
```

Parameters:
- `noise=-30dB` = silence threshold (lower = more sensitive). Try -25dB for noisy audio.
- `d=0.5` = minimum silence duration in seconds

**Step 2: Build ffmpeg filter to remove silent parts**

After detecting silence timestamps, generate a filter_complex command that concatenates only the non-silent segments. The AI should:
1. Parse silencedetect output
2. Calculate non-silent intervals
3. Generate the trim+concat filter

Example for removing detected silences:
```bash
ffmpeg -i input.mp4 \
  -filter_complex "[0:v]trim=0:5,setpts=PTS-STARTPTS[v0];[0:a]atrim=0:5,asetpts=PTS-STARTPTS[a0];[0:v]trim=7:15,setpts=PTS-STARTPTS[v1];[0:a]atrim=7:15,asetpts=PTS-STARTPTS[a1];[v0][a0][v1][a1]concat=n=2:v=1:a=1" \
  -c:v libx264 -preset fast -crf 23 output.mp4
```

### 4. Auto-Edit Podcast

Complete workflow:
1. **Analyze** the audio for silences (silencedetect)
2. **Remove** long pauses (> 1 second)
3. **Normalize** audio levels
4. **Add** intro/outro if provided

```bash
# Normalize audio levels
ffmpeg -i podcast.mp4 -af loudnorm=I=-16:TP=-1.5:LRA=11 -c:v copy normalized.mp4

# Remove silences longer than 1.5 seconds
# (use silencedetect output + trim/concat as above)
```

### 5. Add Subtitles

**Method A: Burn subtitles into video (permanent)**
```bash
# From SRT file
ffmpeg -i input.mp4 -vf "subtitles=subs.srt:force_style='FontName=Arial,FontSize=24,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,Outline=2,Shadow=1'" -c:a copy output.mp4

# Custom styled subtitles (social media style)
ffmpeg -i input.mp4 -vf "subtitles=subs.srt:force_style='FontName=Impact,FontSize=28,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,Bold=1,Outline=3,Shadow=2,MarginV=40'" -c:a copy output.mp4
```

**Method B: Embed as selectable track**
```bash
ffmpeg -i input.mp4 -i subs.srt -c copy -c:s mov_text output.mp4
```

**Workflow with ai-video-analyzer:**
1. Use ai-video-analyzer skill to transcribe the video → get JSON with timestamps
2. Convert JSON to SRT format
3. Burn subtitles with ffmpeg

### 6. Extract Audio

```bash
# To MP3 (high quality)
ffmpeg -i input.mp4 -vn -acodec libmp3lame -q:a 2 output.mp3

# To WAV (lossless)
ffmpeg -i input.mp4 -vn -acodec pcm_s16le output.wav

# To AAC
ffmpeg -i input.mp4 -vn -acodec aac -b:a 192k output.m4a
```

### 7. Download from YouTube

```bash
# Download best quality video + audio
yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" -o "output.mp4" "https://youtube.com/watch?v=ID"

# Download audio only (MP3)
yt-dlp -x --audio-format mp3 --audio-quality 0 -o "output.mp3" "URL"

# Download specific time range (requires ffmpeg)
yt-dlp --download-sections "*00:30-01:45" -o "clip.mp4" "URL"

# Download with subtitles
yt-dlp --write-subs --sub-langs en -o "video.mp4" "URL"

# List available formats
yt-dlp -F "URL"
```

### 8. Create Shorts / Reels from Long Video

Workflow:
1. **Analyze** video with ai-video-analyzer to find best moments
2. **Extract** highlight clips at identified timestamps
3. **Resize** to 9:16 vertical format
4. **Add** subtitles for engagement

```bash
# Extract clip and resize to 9:16 (1080x1920) with crop
ffmpeg -i input.mp4 -ss 00:01:30 -t 30 \
  -vf "crop=ih*9/16:ih,scale=1080:1920" \
  -c:a copy short.mp4

# Or with padding (pillarbox) instead of crop
ffmpeg -i input.mp4 -ss 00:01:30 -t 30 \
  -vf "scale=1080:-2,pad=1080:1920:(ow-iw)/2:(oh-ih)/2:black" \
  -c:a copy short.mp4
```

### 9. Merge / Concatenate Videos

**Method A: Same codec (fast)**
```bash
# Create file list
echo "file 'clip1.mp4'" > list.txt
echo "file 'clip2.mp4'" >> list.txt
echo "file 'clip3.mp4'" >> list.txt

# Concatenate
ffmpeg -f concat -safe 0 -i list.txt -c copy merged.mp4
```

**Method B: Different codecs (re-encode)**
```bash
ffmpeg -i clip1.mp4 -i clip2.mp4 -i clip3.mp4 \
  -filter_complex "[0:v][0:a][1:v][1:a][2:v][2:a]concat=n=3:v=1:a=1" \
  -c:v libx264 -preset fast -crf 23 merged.mp4
```

### 10. Batch Process a Folder

Process all videos in a folder:

```bash
# Convert all to MP4
for f in *.mov; do ffmpeg -i "$f" -c:v libx264 -preset fast -crf 23 "${f%.mov}.mp4"; done

# Resize all to 1080p
for f in *.mp4; do ffmpeg -i "$f" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" "resized_$f"; done

# Extract thumbnails from all
for f in *.mp4; do ffmpeg -i "$f" -ss 00:00:01 -frames:v 1 "${f%.mp4}_thumb.jpg"; done
```

---

## Social Media Presets

### Instagram Reel / TikTok (9:16, 1080x1920)
```bash
ffmpeg -i input.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:a copy -t 60 reel.mp4
```

### Instagram Post (1:1, 1080x1080)
```bash
ffmpeg -i input.mp4 -vf "crop=min(iw\,ih):min(iw\,ih),scale=1080:1080" -c:a copy post.mp4
```

### YouTube Shorts (9:16, max 60s)
```bash
ffmpeg -i input.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -t 60 -c:a copy short.mp4
```

### LinkedIn / YouTube (16:9, 1920x1080)
```bash
ffmpeg -i input.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -c:a copy linkedin.mp4
```

---

## Effects & Transitions

### Fade In/Out
```bash
# Fade in first 1 second, fade out last 1 second (for a 30s video)
ffmpeg -i input.mp4 -vf "fade=t=in:st=0:d=1,fade=t=out:st=29:d=1" -af "afade=t=in:st=0:d=1,afade=t=out:st=29:d=1" output.mp4
```

### Speed Change
```bash
# 2x speed (timelapse feel)
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" fast.mp4

# 0.5x speed (slow motion)
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=2.0*PTS[v];[0:a]atempo=0.5[a]" -map "[v]" -map "[a]" slow.mp4
```

### Add Background Music
```bash
# Mix music at 20% volume under video audio
ffmpeg -i video.mp4 -i music.mp3 \
  -filter_complex "[1:a]volume=0.2[bg];[0:a][bg]amix=inputs=2:duration=first" \
  -c:v copy output.mp4
```

### Extract Frame as Image
```bash
# Single frame at timestamp
ffmpeg -i input.mp4 -ss 00:00:05 -frames:v 1 frame.jpg

# One frame per second (for thumbnails)
ffmpeg -i input.mp4 -vf fps=1 frames/frame_%04d.jpg
```

### GIF from Video
```bash
# High quality GIF (10 FPS, 480px wide)
ffmpeg -i input.mp4 -ss 0 -t 5 -vf "fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" output.gif
```

---

## Quality Presets

| Preset | CRF | Speed | Use Case |
|--------|-----|-------|----------|
| **High quality** | 18 | slow | Final export, portfolio |
| **Good quality** | 23 | fast | Social media, general |
| **Quick draft** | 28 | ultrafast | Preview, testing |
| **Lossless copy** | — | — | Trim/cut only (use `-c copy`) |

```bash
# High quality export
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k output.mp4

# Quick draft
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 draft.mp4
```

---

## Integration with Other Skills

If the `ai-video-analyzer` skill is installed, use it briefly to get timestamps or transcription before editing — don't load its full context, just reference it for specific tasks like "transcribe this video" or "find the scene changes".

---

## Best Practices

1. **Always use `-c copy`** when only trimming — avoids re-encoding, instant results
2. **Check the input first** with ffprobe before editing
3. **Use `-y`** flag to auto-overwrite output files
4. **Never overwrite the source** — always output to a different filename
5. **Test with a short clip** before processing a long video
6. **Use `-preset fast`** for a good speed/quality balance
7. **CRF 23** is the default and works great for most cases
8. **For YouTube downloads**, check `yt-dlp -F URL` to see available quality options
9. **Batch operations** — use loops for processing multiple files
10. **Clean up temp files** after concatenation (list.txt, intermediate clips)

## Supported Formats

**Input:** MP4, MOV, AVI, MKV, WebM, WMV, FLV, MPEG, 3GP, M4V, TS
**Output:** MP4 (recommended), MOV, WebM, GIF, MP3, WAV, AAC, FLAC
**Subtitles:** SRT, ASS, SSA, VTT
