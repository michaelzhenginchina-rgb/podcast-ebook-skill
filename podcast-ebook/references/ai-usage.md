# AI Usage Map

This skill does not call an AI API by itself. It teaches an AI coding agent where the Podcast Ebook app calls AI, where prompts live, and how to modify those prompts safely.

The actual API calls live in the desktop app/runtime code.

## Environment

AI-backed features require:

```text
OPENAI_API_KEY
```

The desktop app usually loads environment variables from the runtime repo. Confirm the runtime path with:

```bash
echo "$PODCAST_EBOOK_RUNTIME_REPO"
```

Do not commit `.env`, API keys, generated transcripts, translated books, or token/cost logs unless explicitly requested.

## Podcast Transcript Cleaning

Purpose:

```text
Turn raw YouTube/podcast transcript text into cleaner reading material while preserving speaker meaning.
```

Main file in the desktop app repo:

```text
scripts/podcast_desktop_runner.py
```

Important symbols:

```text
cleaning_system_prompt(clean_mode)
fast_clean_sections(...)
--ai-clean
--clean-mode faithful|fast|deep
```

Typical API call pattern:

```text
OpenAI(api_key=api_key, timeout=120)
client.chat.completions.create(...)
model: gpt-4o-mini
system message: cleaning_system_prompt(clean_mode)
user message: transcript chunk
temperature: 0.3
```

Cleaning modes:

```text
faithful
  Conservative cleanup. Preserve wording, order, tone, speaker personality, names, numbers, and nuance.

fast
  Section/chunk-based cleanup. Removes filler words, false starts, duplicated phrases, verbal tics, and excessive laughter markers.

deep
  Slower original cleaning path. Use when the user explicitly wants deeper cleanup and accepts more processing time.
```

When changing cleaning prompts:

1. Keep the mode distinction clear.
2. Preserve speaker meaning and do not add ideas.
3. Be careful with Chinese fillers such as `嗯`, `啊`, `呃`, `这个`, `那个`, `就是`, `然后`; sometimes they are filler, sometimes they carry tone.
4. Keep output-only instructions so the model does not add commentary.
5. Run at least one short transcript test with `--ai-clean` before committing.

## Podcast Transcript Translation

Purpose:

```text
Translate generated transcript text into Chinese or English output files.
```

Main file:

```text
scripts/podcast_desktop_runner.py
```

Important symbol:

```text
translate_text_file(source_file, title, target_language, api_key)
```

Typical API call pattern:

```text
OpenAI(api_key=api_key)
client.chat.completions.create(...)
model: gpt-4o-mini
system message: professional translator prompt
user message: transcript chunk
temperature: 0.3
```

Prompt intent:

```text
Translate accurately into fluent Simplified Chinese or fluent English.
Keep the meaning natural to read.
```

When changing translation prompts:

1. Keep the target language explicit.
2. Avoid asking for summaries unless the feature is intentionally changed.
3. Preserve names, timestamps, examples, and technical terms.
4. Check generated output filenames and metadata still make sense.

## PDF Translation

Purpose:

```text
Translate selectable-text PDFs into a traceable Markdown output package.
```

Main file:

```text
scripts/pdf_translation_runner.py
```

Important symbols:

```text
TARGETS
MODES
Translator.chat(...)
Translator.analyze(...)
Translator.translate_chunk(...)
Translator.refine_chunk(...)
```

Typical API call pattern:

```text
OpenAI(api_key=api_key, timeout=90, max_retries=2)
client.chat.completions.create(...)
model: configurable, default gpt-4o-mini
system message: target-specific translation system prompt
user message: analysis request, chunk translation request, or refinement request
```

Translation flow:

```text
extract selectable PDF text
split text into chunks
analyze a source sample
produce summary, style guide, glossary, and risk notes
translate each chunk using the analysis and glossary
optionally refine each translated chunk
write manifest and token/cost metadata
```

Modes:

```text
quick
  Direct translation with simpler formatting.

normal
  Uses analysis and glossary for consistency.

refined
  Runs a second chunk-level polish pass.
```

When changing PDF translation prompts:

1. Preserve headings, bullets, numbered lists, names, dates, and figures.
2. Do not summarize unless the source itself summarizes.
3. Keep glossary/style-guide usage explicit in chunk prompts.
4. Keep page-marker handling clear.
5. Make `refined` improve omissions, mistranslations, term consistency, literal phrasing, and formatting without adding new content.

## Verification Checklist

After changing AI prompts or AI call behavior:

```bash
python -m py_compile scripts/podcast_desktop_runner.py scripts/pdf_translation_runner.py
```

If the runtime venv is configured:

```bash
"$PODCAST_EBOOK_RUNTIME_REPO/venv/bin/python" -m py_compile scripts/podcast_desktop_runner.py scripts/pdf_translation_runner.py
```

For frontend/UI changes around AI controls:

```bash
node --check frontend/app.js
```

For Tauri command changes:

```bash
cd src-tauri && cargo check
```

Prefer small prompt changes with a short before/after sample. Do not silently broaden the behavior from cleaning to rewriting, summarizing, or inventing content.
