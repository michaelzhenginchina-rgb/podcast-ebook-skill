# Podcast Ebook Skill

A shareable AI-agent skill for working with a Podcast Ebook desktop workflow.

This skill helps Codex, Claude Code, and other skill-aware coding agents understand how to operate a Tauri desktop app backed by a Python podcast-to-ebook runtime.

It is inspired by the style of workflow skills such as Cuimao Translator: the skill is not a standalone app. It is a structured operating guide for an AI coding agent.

## What It Covers

- Podcast Ebook desktop app structure
- Tauri frontend and command orchestration
- Python runtime relationship
- YouTube transcript to EPUB/PDF workflows
- PDF translation workflow
- Cuimao-style translation flow: extract, analyze, glossary, chunk translation, optional refinement
- Output folder conventions
- Verification and Git workflow

## Install For Codex

Clone this repo, then copy the skill folder into your Codex skills directory:

```bash
git clone https://github.com/michaelzhenginchina-rgb/podcast-ebook-skill.git
mkdir -p ~/.codex/skills
cp -R podcast-ebook-skill/podcast-ebook ~/.codex/skills/podcast-ebook
```

Start a new Codex session and refer to the skill as:

```text
$podcast-ebook
```

## Install For Claude Code-Style Skill Systems

If your assistant supports local `SKILL.md` folders, copy the `podcast-ebook/` directory into that assistant's skills folder.

The important file is:

```text
podcast-ebook/SKILL.md
```

## Configure Local Paths

The helper scripts use common defaults:

```text
desktop repo: current git repo
runtime repo: ~/podcast-to-ebook-repo
app binary:   ~/Applications/Podcast Ebook.app/Contents/MacOS/podcast-ebook-desktop
```

Override them when your machine uses different paths:

```bash
export PODCAST_EBOOK_DESKTOP_REPO="/path/to/podcast-ebook-desktop"
export PODCAST_EBOOK_RUNTIME_REPO="/path/to/podcast-to-ebook-repo"
export PODCAST_EBOOK_APP_BIN="/path/to/Podcast Ebook.app/Contents/MacOS/podcast-ebook-desktop"
export PODCAST_EBOOK_RUNTIME_PYTHON="/path/to/python"
```

## Quick Checks

From a Podcast Ebook desktop app repo:

```bash
~/.codex/skills/podcast-ebook/scripts/check_app.sh
~/.codex/skills/podcast-ebook/scripts/check_runtime.sh
```

These scripts do not modify files. They print repo state, installed app status, and runtime dependency availability.

## Repository Layout

```text
podcast-ebook/
  SKILL.md
  README.md
  references/
    app-architecture.md
    pdf-translation.md
  scripts/
    check_app.sh
    check_runtime.sh
  agents/
    openai.yaml
```

## Notes

This repo contains the AI-agent skill only. It does not include the Podcast Ebook desktop app or the Python runtime.

The skill is intentionally path-configurable so other users can adapt it to their own local app/runtime layout.
