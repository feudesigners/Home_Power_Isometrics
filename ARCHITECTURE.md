# Architecture

## Layers

- `lib/app` — bootstrap, routing (`go_router`), Material 3 theme tokens
- `lib/core` — clock, errors, shared widgets, reminder implementation
- `lib/data` — Drift SQLite, repositories, JSON content seed
- `lib/domain` — entities/enums and pure services (timer FSM, progression, XP, achievements, challenges, PBs, export)
- `lib/features` — UI by feature (onboarding, home, exercises, workouts, progress, challenges, avatar, settings)

## State management

Riverpod providers in `lib/app/bootstrap/providers.dart`. Workout runtime state is a `ChangeNotifier` (`WorkoutController`) exposed via `ChangeNotifierProvider`.

## Navigation

`go_router` shell: **Today | Train | Progress | You**. Full-screen routes for onboarding, preview, runner, completion, exercise detail, session detail, challenges.

## Database

Drift schema version **2** (`AppDatabase.schemaVersion`). Migrations enabled from day one. Content seed version stored in `meta_entries.content_version` and does **not** wipe user history tables.

Key dependency justification:

| Package | Why |
|---------|-----|
| drift / sqlite3_flutter_libs | Typed offline persistence + migrations |
| flutter_riverpod | Testable DI/state |
| go_router | Declarative navigation + shell |
| wakelock_plus | Keep screen awake only during active workout |
| flutter_local_notifications | Optional reminders (no exact-alarm for timer) |
| audioplayers | Bundled cue hooks (optional) |
| share_plus / path_provider | Local export without accounts |
| permission_handler | POST_NOTIFICATIONS on Android 13+ |
| flutter_timezone / timezone | Device-local recurring reminder scheduling |

## Timer design

`WorkoutStateMachine` uses an injectable `AppClock` and **deadlines**. UI `Timer.periodic` only repaints / evaluates; it is not the source of truth. Warm-up and cool-down template blocks are first-class plan items but do not create hold records. Pause stores remaining duration; resume rebuilds deadline. Backgrounding pauses and persists recovery JSON; `SessionRecoveryService` validates eligibility and resume requires confirmation.

Current and next exercise posture assets are pre-cached. Missing media and audio are explicit production gates with labeled/static or silent fallbacks.

## Content seeding

Versioned JSON in `assets/content/` is imported transactionally by `ContentSeedService`. Content updates bump `content_version`, replace seeded definitions and media indexes, and preserve user history. `media_manifest.json` is the authoritative media-path index.

## Extension points

- Custom workout builder (Train tab stub)
- Rive `AvatarAnimator` (placeholder animator shipped)
- Health Connect / cloud backup / Wear OS / social / camera pose (see ROADMAP — intentionally absent from MVP)
- Play upload keystore and private signing credentials (template and fail-fast release guard included)
