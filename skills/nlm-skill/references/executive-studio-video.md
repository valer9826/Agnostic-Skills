# NotebookLM Studio — executive / director-facing video

Use when generating **Video Overview** artifacts for **leadership** (CEO, VP Engineering, board): KPI-heavy, brand palette, uploaded slide PNGs, and **motion** that NotebookLM may only approximate.

**Target format:** Treat the video as an **animated presentation** (exec deck slides), **not** empty analogy imagery. **Every beat must show real slide information** (KPIs, tables, factual bullets) — no filler frames. **Integrate** provided PNG slides **into** the animated sequence (transitions, progressive reveal, spotlight/pan on metric **regions of the slide**) so slide content is **part of** the motion — while **preserving** numbers and layout. See **PRESENTATION FORMAT** and **ZERO EMPTY CONTENT** in `EXECUTIVE_VIDEO_PROMPT.md`.

## Canonical prompt source

Copy `focus_prompt` from your project’s documented executive video prompt file. Declare that path in root `AGENTS.md` (for example `docs/EXECUTIVE_VIDEO_PROMPT.md`). This catalog only ships motion-prompting guidance in this file; it does not pin a corporate notebook ID or URL.

## MCP invocation

- Tool: `studio_create`
- `artifact_type`: `video`
- `language`: `en` (or `es` if you maintain a Spanish variant)
- `video_format`: Prefer **`cinematic`** in the **web UI** when available. On **MCP** (`studio_create`), **`cinematic` has failed** with `Could not create video` for this notebook — use **`explainer`** and put **fully cinematographic** instructions in **`focus_prompt`** (see **CINEMATIC DELIVERY** paragraph in `EXECUTIVE_VIDEO_PROMPT.md`). If the cut is **flat**, regenerate with the same `focus_prompt`.
- `confirm`: `true`
- `focus_prompt`: paste the full block from `EXECUTIVE_VIDEO_PROMPT.md` (NotebookLM Studio section)

Poll `studio_status` until `status` is `completed`; use `video_url` from the artifact.

## Product reality

The tool may **not** combine true data animation with composited PNGs reliably. Asking for an **animated deck** (slide-to-slide motion + reveals on slide regions) sometimes yields better results than asking only for “animate every number.” If output is still inadequate, produce motion in **Slides/PPT/After Effects** and use Studio for narrative draft only.

## Animation formula (reliable prompting pattern)

NotebookLM does **not** guarantee data animations. Prompts that only say “animate everything” often collapse to static slides. Replicate the pattern that worked on strong internal cuts (e.g. *Silent Bottleneck* style):

1. **Open with delivery**: *Premium, cinematic and dynamic — smooth scene transitions; visible motion on headline metrics (count-up, step reveals, Before→After swaps, bar growth, highlight on the active number) wherever the format supports it.*
2. **Hard rules next**: no voice-only KPIs; palette; required image filenames if using composited PNGs.
3. **Priority motion block**: short bullets for the **heaviest KPI scenes** only (e.g. 94.9% slide, CI step-down, vendor table, ROI count-up, AI multiplier bars).
4. **Per-scene line**: each scene = content + **one concrete motion cue** (duration or sequence, e.g. “~2s count-up 0→94.9%”).
5. **A/B format**: alternate `cinematic` ↔ `explainer`; **regenerate** if static or voice-heavy.

Full scene tables and the copy-paste `focus_prompt` live in `EXECUTIVE_VIDEO_PROMPT.md`.

## Source hygiene

Upload the slide or diagram PNGs your program requires as notebook sources; after re-uploading same-titled files, **list sources** and **delete older duplicates** by title. Follow any **notebook source hygiene** workflow defined in your repository `AGENTS.md` or `.agents/workflows/`.

## Related

- Parent skill: `nlm-skill` (`SKILL.md`)
- Slide deck parity: same doc includes Studio `slide_deck` guidance in sibling sections / history
