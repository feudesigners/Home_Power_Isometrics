# Final verification report

Date: 2026-07-19

## 1. Branch and commit

- Working tree on `main` (feature work previously landed).
- Local uncommitted: `file_picker` bump, Gradle heap/worker tuning, docs (`FINAL_REPORT`, README, ROADMAP).
- Do not merge/push unless requested.

## 2. Flutter / Dart

- Flutter 3.44.6 (stable)
- Dart 3.12.2

## 3. Android SDK

- minSdk: **24**
- targetSdk / compileSdk: **36** (Flutter default)
- applicationId: `com.feudesigners.isometrix`

## 4. Screens implemented

Onboarding, Today, Train (programs + library), Exercise detail, Workout preview/runner/completion, Progress, Challenges, You (settings/export/reset), companion avatar placeholders.

## 5. Programs and exercises

5 data-driven programs; 16 exercises with variants/regressions; beginner templates avoid gated harder holds. Hold times provisional — see `CONTENT_REVIEW.md`.

## 6. Timer architecture

Deadline-based `WorkoutStateMachine` + injectable `AppClock`; UI ticks are not source of truth; background → pause/persist; resume requires confirmation; wakelock only while active.

## 7. SQLite / Drift

Schema version **1**. Content seed versioned separately from user history.

## 8. Avatar / media

Pulse / Nova / Atlas placeholders. Exercise media pipeline with accessible fallbacks. Final anatomical art is an external gate (`ASSET_GUIDE.md`).

## 9. Safety / content review

Not medically reviewed. Provisional holds documented in `CONTENT_REVIEW.md`.

## 10. Tests and builds

| Command | Result |
|---------|--------|
| `flutter analyze` | No issues |
| `flutter test` | **24 passed** |
| `flutter test integration_test -d RZCX928DF6Y` | **All tests passed** (Samsung SM-S711B) |
| `flutter build apk --debug --target-platform=android-arm64` | **Success** (~94 MB APK) |
| Device install + launch (`--user 0`) | **Success** |
| `flutter build appbundle --release` | **Success** — `build/app/outputs/bundle/release/app-release.aab` (~57.8 MB); debug signing (Play keystore = external gate) |

## 11. Manual checks

- Physical device used (no emulator available).
- App installed and MainActivity launched on primary user.
- Secure Folder (user 150) can mask package from default shell commands — use `--user 0`.
- Airplane-mode / TalkBack / notification grant-deny not exhaustively walked on-device in this session; core offline loop covered by integration smoke.

## 12. Artwork still required

See `ASSET_GUIDE.md` — posture/animation assets for all exercise bases; companion Rive/vector finals; optional audio cues.

## 13. External production gates

1. Professional exercise-content review
2. Final licensed anatomical media / avatar art
3. Production Play App Signing keystore (not in repo)
4. Plugin KGP migration warning (file_picker, share_plus, wakelock_plus, package_info_plus) before future Flutter breakage

## 14. Build notes (this machine)

- `/tmp` is small tmpfs — use `TMPDIR` under the project `.tmp/`.
- Cap Gradle heap (`-Xmx2G`) for ~7 GiB RAM hosts; prior `-Xmx8G` contributed to hung release builds.
- Flutter release engine JARs come from `storage.googleapis.com` / `download.flutter.io` — first release build needs network.

## 15. Merge / push

**No merge or push performed** in this verification pass.
