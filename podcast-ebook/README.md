# Podcast Ebook Skill

This is a shareable AI-agent skill for working on the Podcast Ebook desktop app.

It helps Codex, Claude Code, or another skill-aware coding assistant understand:

- the Tauri desktop app structure
- the Python podcast-to-ebook runtime relationship
- the YouTube transcript to ebook workflow
- the PDF translation workflow
- the Cuimao-style translation process used by the app
- the expected verification and Git workflow

## Install For Codex

From the repository root:

```bash
mkdir -p ~/.codex/skills
cp -R skills/podcast-ebook ~/.codex/skills/podcast-ebook
```

Then start a new Codex session and ask for `podcast-ebook` work. The skill should be available as `$podcast-ebook`.

## Configure Local Paths

The helper scripts are path-configurable:

```text
PODCAST_EBOOK_DESKTOP_REPO
PODCAST_EBOOK_RUNTIME_REPO
PODCAST_EBOOK_APP_BIN
PODCAST_EBOOK_RUNTIME_PYTHON
PODCAST_EBOOK_OUTPUT_DIR
```

```bash
export PODCAST_EBOOK_DESKTOP_REPO="/path/to/podcast-ebook-desktop"
export PODCAST_EBOOK_RUNTIME_REPO="/path/to/runtime-repo"
export PODCAST_EBOOK_APP_BIN="/path/to/Podcast Ebook.app/Contents/MacOS/podcast-ebook-desktop"
export PODCAST_EBOOK_RUNTIME_PYTHON="/path/to/python"
export PODCAST_EBOOK_OUTPUT_DIR="/path/to/output-folder"
```

## Quick Checks

```bash
skills/podcast-ebook/scripts/check_app.sh
skills/podcast-ebook/scripts/check_runtime.sh
```

These scripts do not modify files. They print the current repo state, installed app status, and runtime dependency availability.

## Files

```text
SKILL.md
references/app-architecture.md
references/pdf-translation.md
scripts/check_app.sh
scripts/check_runtime.sh
agents/openai.yaml
```
