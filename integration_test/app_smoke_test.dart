import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:isometrix/core/time/app_clock.dart';
import 'package:isometrix/domain/entities/enums.dart';
import 'package:isometrix/domain/services/workout_state_machine.dart';
import 'package:isometrix/data/database/database.dart';
import 'package:drift/drift.dart';
import '../test/test_sqlite.dart';

/// Integration-style smoke without full Flutter UI binding to emulator.
/// Verifies: seedable DB + multi-hold session + XP idempotency path data.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  configureTestSqlite();

  testWidgets('fresh DB session with multiple holds is one session', (
    tester,
  ) async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    await _seedTestContent(db);
    await db.into(db.userProfiles).insert(UserProfilesCompanion.insert());
    await db.into(db.userPreferences).insert(UserPreferencesCompanion.insert());
    await db.into(db.userLevels).insert(UserLevelsCompanion.insert());

    await db
        .into(db.workoutSessions)
        .insert(
          WorkoutSessionsCompanion.insert(
            id: 'sess',
            startedAt: DateTime.now(),
            status: 'active',
            templateId: const Value('tpl_quick'),
          ),
        );

    final clock = FakeAppClock();
    final machine = WorkoutStateMachine(clock);
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'wall_sit_easier',
        exerciseId: 'E001',
        displayName: 'Wall Sit',
        holdDuration: const Duration(seconds: 2),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
      ),
      WorkoutPlanItem(
        variantId: 'forearm_plank_easier',
        exerciseId: 'E006',
        displayName: 'Plank',
        holdDuration: const Duration(seconds: 2),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
      ),
    ]);
    machine.start();
    while (machine.phase != WorkoutPhase.completed) {
      clock.advance(const Duration(milliseconds: 500));
      machine.evaluate();
      if (clock.now().difference(DateTime.utc(2026, 1, 1, 12)) >
          const Duration(minutes: 2)) {
        fail('timer did not complete');
      }
    }

    await db
        .into(db.holdAttempts)
        .insert(
          HoldAttemptsCompanion.insert(
            id: 'h1',
            sessionId: 'sess',
            exerciseId: 'E001',
            variantId: 'wall_sit_easier',
            targetMs: 2000,
            completedMs: 2000,
            result: 'completed',
            startedAt: DateTime.now(),
            endedAt: DateTime.now(),
          ),
        );
    await db
        .into(db.holdAttempts)
        .insert(
          HoldAttemptsCompanion.insert(
            id: 'h2',
            sessionId: 'sess',
            exerciseId: 'E006',
            variantId: 'forearm_plank_easier',
            targetMs: 2000,
            completedMs: 2000,
            result: 'completed',
            startedAt: DateTime.now(),
            endedAt: DateTime.now(),
          ),
        );
    await (db.update(db.workoutSessions)..where((t) => t.id.equals('sess')))
        .write(const WorkoutSessionsCompanion(status: Value('completed')));

    final sessions = await db.select(db.workoutSessions).get();
    final holds = await db.select(db.holdAttempts).get();
    expect(sessions.length, 1);
    expect(holds.length, 2);

    await db
        .into(db.xpEvents)
        .insert(
          XpEventsCompanion.insert(
            id: 'xp_session_sess',
            sourceType: 'session',
            sourceId: 'sess',
            amount: 50,
          ),
        );
    // Duplicate blocked by PK
    await expectLater(
      () => db
          .into(db.xpEvents)
          .insert(
            XpEventsCompanion.insert(
              id: 'xp_session_sess',
              sourceType: 'session',
              sourceId: 'sess',
              amount: 50,
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });
}

Future<void> _seedTestContent(AppDatabase db) async {
  await db.into(db.exerciseCategories).insert(
    ExerciseCategoriesCompanion.insert(
      id: 'C001',
      name: 'Test',
      colorHex: '#000000',
    ),
  );
  for (final exercise in const {
    'E001': 'Wall Sit',
    'E006': 'Plank',
  }.entries) {
    await db.into(db.exercises).insert(
      ExercisesCompanion.insert(
        id: exercise.key,
        categoryId: 'C001',
        name: exercise.value,
        primaryMusclesJson: '[]',
      ),
    );
  }
  for (final variant in const {
    'wall_sit_easier': 'E001',
    'forearm_plank_easier': 'E006',
  }.entries) {
    await db.into(db.exerciseVariants).insert(
      ExerciseVariantsCompanion.insert(
        id: variant.key,
        exerciseId: variant.value,
        displayName: variant.key,
        difficultyRank: 1,
        categoryId: 'C001',
        primaryMusclesJson: '[]',
        targetHoldMs: 2000,
      ),
    );
  }
}
