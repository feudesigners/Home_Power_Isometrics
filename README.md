# IsometriX

Offline-first Flutter Android coach for short guided isometric workouts at home.

**Tagline:** Static Strength. Dynamic Results.

## Product summary

IsometriX helps you start a short guided workout, learn setup through bundled demonstrations (placeholders in MVP), follow accurate prepare/hold/rest/side timers, log sessions in SQLite, track progress, earn achievements/challenges/XP, and grow a companion avatar — all without an account or internet.

The HTML file under [`design/isometrix_app.html`](design/isometrix_app.html) is **design inspiration only**, not production source.

## Requirements

- Flutter **3.44.x** / Dart **3.12.x** (project developed on Flutter 3.44.6)
- Android SDK with platforms matching Flutter toolchain
- **Minimum Android SDK: 24 (Android 7.0)**
- Target/compile SDK: Flutter defaults (currently SDK 35/36 available in environment)

## Setup

```bash
export TMPDIR=$HOME/tmp   # recommended if /tmp is a small tmpfs
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Run

```bash
flutter run -d android
```

## Test

```bash
flutter test
flutter test integration_test
```

The integration suite requires an Android device or AVD; this repository only declares the Android platform.

## Build

```bash
flutter build apk --debug
cp android/key.properties.example android/key.properties
# Edit key.properties to reference your upload keystore.
flutter build appbundle --release
```

## Verification status

The end-to-end source implementation includes atomic workout completion, optional idempotent feedback, lifecycle recovery, real safer-variant switching, accepted progressions, 40 scheduled program sessions, schema-v2 integrity, validated data portability, device-timezone reminders, static/animated media selection, secure release-signing safeguards, and Android cold-start black-screen fixes.

Verified on this machine and a physical Samsung SM-S711B (Android 16, API 36) for the pre-merge baseline:

| Gate | Result |
|------|--------|
| `flutter analyze` | No issues |
| `flutter test` | 24 passed |
| `flutter test integration_test -d RZCX928DF6Y` | Passed on device |
| `flutter build apk --debug` | Built `build/app/outputs/flutter-apk/app-debug.apk` |
| Install + launch on device | Installed for user 0; `MainActivity` started |
| `flutter build appbundle --release` | Uses debug signing locally; production keystore remains an external gate |

Emulator was not used (none installed). Secure Folder / secondary Android users can hide the package from default `am start` unless `--user 0` is used.

Re-run formatting, analysis, tests, and Android builds after merging the stabilization branch. Production exercise review, final anatomical media/audio, and Play App Signing remain external gates.

## Assets

- Seed content: `assets/content/*.json`
- Fonts (OFL): `assets/fonts/` — see `FONT_LICENSES.txt`
- Exercise media: authoritative index in `assets/content/media_manifest.json`; current files remain release placeholders — see [`ASSET_GUIDE.md`](ASSET_GUIDE.md)

## Documentation

- [`ARCHITECTURE.md`](ARCHITECTURE.md)
- [`PRODUCT_SPEC.md`](PRODUCT_SPEC.md)
- [`CONTENT_REVIEW.md`](CONTENT_REVIEW.md)
- [`ASSET_GUIDE.md`](ASSET_GUIDE.md)
- [`PRIVACY.md`](PRIVACY.md)
- [`ROADMAP.md`](ROADMAP.md)
