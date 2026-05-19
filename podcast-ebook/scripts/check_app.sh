#!/usr/bin/env bash
set -euo pipefail

if git rev-parse --show-toplevel >/dev/null 2>&1; then
  DEFAULT_REPO="$(git rev-parse --show-toplevel)"
else
  DEFAULT_REPO="$(pwd)"
fi

APP_REPO="${PODCAST_EBOOK_DESKTOP_REPO:-$DEFAULT_REPO}"
APP_BIN="${PODCAST_EBOOK_APP_BIN:-}"

cd "$APP_REPO"
echo "repo: $APP_REPO"
echo "branch: $(git branch --show-current 2>/dev/null || true)"
echo "status:"
git status --short
echo

if [ -n "$APP_BIN" ] && [ -f "$APP_BIN" ]; then
  echo "installed app binary:"
  ls -lh "$APP_BIN"
  echo
  echo "tauri commands in binary:"
  strings "$APP_BIN" | rg 'generate_podcast_ebook|translate_pdf|choose_pdf_file|pdf_translation_runner' || true
else
  echo "installed app binary not checked"
  echo "Set PODCAST_EBOOK_APP_BIN=/path/to/app-binary to inspect a local app bundle."
fi
