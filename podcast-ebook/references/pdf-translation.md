# PDF Translation Workflow

## Product Behavior

The app translates selectable-text PDFs through:

```text
scripts/pdf_translation_runner.py
```

The runtime environment needs:

```text
openai
python-dotenv
pypdf
```

## Modes

```text
quick
  Direct translation.

normal
  Extract -> analyze -> glossary/style guide -> chunk translation.

refined
  Normal plus a second chunk-level polish pass.
```

Use `normal` unless the user asks for speed (`quick`) or higher quality (`refined`).

## Output Contract

PDF translation output directory:

```text
~/Desktop/Retrona_Tools_Output/podcast-ebooks/pdf_translation_YYYYMMDD_HHMMSS
```

Expected files:

```text
source_extracted.md
analysis.md
chunks/chunk_001.md
*_zh_translation.md or *_en_translation.md
translation_result.json
manifest.md
```

## Runtime Expectations

Long PDFs can take minutes. For example, a roughly 80,000-character source PDF may translate in about 5-7 minutes in normal mode and 10-14 minutes in refined mode, depending on API latency.

If progress seems stuck, check whether chunk files are appearing:

```bash
pgrep -af 'pdf_translation_runner.py|podcast-ebook-desktop'
find ~/Desktop/Retrona_Tools_Output/podcast-ebooks -maxdepth 3 -path '*/chunks/*' -type f
```

## One-Off Mirror PDFs

If the user asks for a source-specific mirror PDF:

1. Inspect source PDF page size, page count, and visual pattern.
2. Use the existing translation text as content.
3. Generate a one-off artifact in the output folder.
4. Do not productize source-specific layout code unless explicitly asked.

Mirror means visually analogous, not necessarily identical page count. Translated text can expand and require more pages.
