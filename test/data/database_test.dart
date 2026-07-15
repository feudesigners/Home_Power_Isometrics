import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isometrix/data/database/database.dart';
import 'package:isometrix/data/seed/content_seed_service.dart';
import 'package:isometrix/data/repositories/app_repositories.dart';
import 'dart:convert';

import '../test_sqlite.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  configureTestSqlite();

  test(
    'schema creates and user data survives content version key updates',
    () async {
      final db = AppDatabase.memory();
      addTearDown(db.close);

      await db.setMeta('content_version', '0');
      await db
          .into(db.userProfiles)
          .insert(
            UserProfilesCompanion.insert(displayName: const Value('Tester')),
          );
      await db
          .into(db.workoutSessions)
          .insert(
            WorkoutSessionsCompanion.insert(
              id: 's1',
              startedAt: DateTime.utc(2026, 1, 1),
              status: 'completed',
            ),
          );
      await db.setMeta(ContentSeedService.contentVersionKey, '1');
      final sessions = await db.select(db.workoutSessions).get();
      expect(sessions.length, 1);
      final profile = await db.select(db.userProfiles).get();
      expect(profile.first.displayName, 'Tester');
    },
  );

  test('multiple holds belong to one session', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);
    await db
        .into(db.workoutSessions)
        .insert(
          WorkoutSessionsCompanion.insert(
            id: 'session-1',
            startedAt: DateTime.utc(2026, 1, 1),
            status: 'active',
          ),
        );
    await db.transaction(() async {
      await db
          .into(db.holdAttempts)
          .insert(
            HoldAttemptsCompanion.insert(
              id: 'h1',
              sessionId: 'session-1',
              exerciseId: 'E001',
              variantId: 'wall_sit_easier',
              targetMs: 15000,
              completedMs: 15000,
              result: 'completed',
              startedAt: DateTime.utc(2026, 1, 1, 12),
              endedAt: DateTime.utc(2026, 1, 1, 12, 0, 15),
            ),
          );
      await db
          .into(db.holdAttempts)
          .insert(
            HoldAttemptsCompanion.insert(
              id: 'h2',
              sessionId: 'session-1',
              exerciseId: 'E006',
              variantId: 'forearm_plank_easier',
              targetMs: 12000,
              completedMs: 12000,
              result: 'completed',
              startedAt: DateTime.utc(2026, 1, 1, 12, 1),
              endedAt: DateTime.utc(2026, 1, 1, 12, 1, 12),
            ),
          );
    });
    final sessions = await db.select(db.workoutSessions).get();
    final holds = await db.select(db.holdAttempts).get();
    expect(sessions.length, 1);
    expect(holds.length, 2);
  });

  test('JSON export imports validated session and hold history', () async {
    final source = AppDatabase.memory();
    await source
        .into(source.userProfiles)
        .insert(UserProfilesCompanion.insert());
    await source
        .into(source.userPreferences)
        .insert(UserPreferencesCompanion.insert());
    await source.into(source.userLevels).insert(UserLevelsCompanion.insert());
    await source
        .into(source.workoutSessions)
        .insert(
          WorkoutSessionsCompanion.insert(
            id: 'session-exported',
            startedAt: DateTime.utc(2026, 4, 2, 10),
            status: 'completed',
            completedAt: Value(DateTime.utc(2026, 4, 2, 10, 5)),
          ),
        );
    await source
        .into(source.holdAttempts)
        .insert(
          HoldAttemptsCompanion.insert(
            id: 'hold-exported',
            sessionId: 'session-exported',
            exerciseId: 'wall_sit',
            variantId: 'wall_sit_foundation',
            targetMs: 18000,
            completedMs: 18000,
            result: 'completed',
            startedAt: DateTime.utc(2026, 4, 2, 10, 1),
            endedAt: DateTime.utc(2026, 4, 2, 10, 1, 18),
          ),
        );

    final exported = await AppRepositories(source).exportUserData();
    await source.close();

    final target = AppDatabase.memory();
    addTearDown(target.close);
    await target
        .into(target.userProfiles)
        .insert(UserProfilesCompanion.insert());
    await target
        .into(target.userPreferences)
        .insert(UserPreferencesCompanion.insert());
    await target.into(target.userLevels).insert(UserLevelsCompanion.insert());
    final summary = await AppRepositories(
      target,
    ).importUserData(jsonEncode(exported));

    expect(summary.sessions, 1);
    expect(summary.holdAttempts, 1);
    expect(await target.select(target.workoutSessions).get(), hasLength(1));
    expect(await target.select(target.holdAttempts).get(), hasLength(1));
  });
}
