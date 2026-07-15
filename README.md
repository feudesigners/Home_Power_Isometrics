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
flutter build appbundle --release   # uses debug signing locally — production keystore is an external gate
```

## Verification status

Source implementation is complete for the MVP scope. Final test, Android build, emulator/manual accessibility, lifecycle, notification, and import/reset checks are deferred and must be rerun before release. Production exercise review, anatomical media/audio, and Play signing remain external gates.

## Assets

- Seed content: `assets/content/*.json`
- Fonts (OFL): `assets/fonts/` — see `FONT_LICENSES.txt`
- Exercise media: placeholders only — see [`ASSET_GUIDE.md`](ASSET_GUIDE.md)

## Documentation

- [`ARCHITECTURE.md`](ARCHITECTURE.md)
- [`PRODUCT_SPEC.md`](PRODUCT_SPEC.md)
- [`CONTENT_REVIEW.md`](CONTENT_REVIEW.md)
- [`ASSET_GUIDE.md`](ASSET_GUIDE.md)
- [`PRIVACY.md`](PRIVACY.md)
- [`ROADMAP.md`](ROADMAP.md)
