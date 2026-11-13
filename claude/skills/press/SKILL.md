---
name: press
description: Compile markdown files to PDF with the user's `press` command. Use when the user asks to compile, convert, export, render or print markdown (.md) files as PDFs.
allowed-tools: Bash(press:*)
---

# press

`press` converts markdown to PDF (pandoc + Typst) using the user's own styles. Each PDF is written next to its source with the same name (`notes.md` → `notes.pdf`).

```
press [-s style] file.md...
```

- Styles: `sans` (default) and `serif`. Use `serif` only if the user asks for it.
- Pass all files in one call; quote paths with spaces.
- Do not edit the markdown files or the styles in `~/.local/share/press/`; just compile.
- If a file fails, show the user the error output.
- Report the PDF paths that were written.
