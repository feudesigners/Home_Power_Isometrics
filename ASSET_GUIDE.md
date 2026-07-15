# Asset guide

## Status

MVP ships **non-anatomical placeholders**. Missing media must not crash workouts (`ExerciseMediaView` fallback).

## Required final assets (handoff)

For each exercise base id (`wall_sit`, `glute_bridge`, … `prone_w`):

| Asset | Path pattern | Notes |
|-------|--------------|-------|
| Static posture PNG/WebP | `assets/images/{id}_posture.png` | Neutral alignment, licensed |
| Animation WebP/GIF | `assets/animations/{id}.webp` | Loop; provide static frame for reduced-motion |
| Optional MP4 technique | deferred | Not required for timer |

Companion avatars Pulse / Nova / Atlas: idle, greeting, preparing, holding, encouraging, resting, celebrating, levelUp — vector/`AvatarAnimator` or licensed `.riv`.

Audio: prep beep, halfway, final-3, complete, rest (optional WAV/OGG under `assets/audio/`).

## Manifest

`assets/content/media_manifest.json` maps media IDs → paths.

## Licences

Do not hotlink. Do not commit unlicensed fitness imagery. Fonts: OFL — `assets/fonts/FONT_LICENSES.txt`.
