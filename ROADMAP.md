# Roadmap

## MVP status

Implemented offline coach source: onboarding, programs/library, warm-up/hold/rest/side/cool-down deadline timing with recovery, SQLite history, progression suggestions, XP/achievements/challenges, companion placeholders, validated JSON import/export, CSV export, reset, reminders, themes, activity visuals, and accessibility fallbacks.

Quality gates re-run on Flutter 3.44.6 / Dart 3.12.2 against a connected Samsung SM-S711B: `flutter analyze` clean, unit/widget suite green, on-device integration smoke passed, debug APK built and launched. Release app bundle uses local debug signing; Play signing remains external.

## Deferred

- Health Connect
- Cloud backup
- Wear OS
- Social challenges
- Coach-authored remote programs
- Camera posture assistance
- Final anatomical artwork / Rive companions
- Production Play App Signing / release keystore
- Custom workout builder UI (extension point present)
