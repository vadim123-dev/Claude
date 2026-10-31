# Claude

My Claude Code setup. `Skills/` holds the skills I own, grouped by topic.

Claude Code only loads skills from `~/.claude/skills/<name>/SKILL.md`, so each skill
here is linked into that folder with a directory junction. Editing a skill in either
place changes the same files.

## Skills

| Group | Skill | Source |
|---|---|---|
| film | `producer` | FILM-SKILLS.zip |
| film | `bamai` | FILM-SKILLS.zip |
| film | `seedance-clean` | FILM-SKILLS.zip |
| film | `image-ref-gen` | FILM-SKILLS.zip |
| video | `ai-video-analyzer` | https://github.com/guyaga/10d10s-day02-video-analyzer |
| video | `ai-video-editor` | https://github.com/guyaga/10d10s-day03-video-editor |

### Add a new skill

1. Create `Skills/<group>/<skill-name>/SKILL.md` (the folder name must match `name:` in the frontmatter).
2. Run `.\link-skills.ps1` to link it into `~/.claude/skills`.
3. Start a new Claude Code session so it loads.

## On a new machine

```powershell
git clone <this repo> C:\Claude
C:\Claude\link-skills.ps1
```

## Third-party skills (not in this repo)

Their installers own and overwrite these folders in `~/.claude/skills`, so reinstall them instead of copying:

- **SuperCMO** (19 skills: `generating-*`, `analyzing-*`, `writing-*`, `planning-campaigns`, ...): installed by the SuperCMO connector/plugin.
- **HyperFrames** (`hyperframes`, `hyperframes-cli`, `hyperframes-registry`, `media-use`): `npx hyperframes skills update`

## Tools the skills need

- Node.js 22+ and `@google/genai` (ai-video-analyzer), `GEMINI_API_KEY` as a user environment variable (never commit it)
- FFmpeg: `winget install Gyan.FFmpeg`
- yt-dlp: `pip install -U "yt-dlp[default]"`, with `--js-runtimes node` in `%APPDATA%\yt-dlp\config.txt`
