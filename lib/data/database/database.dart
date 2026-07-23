import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    MetaEntries,
    UserProfiles,
    UserPreferences,
    HealthCautionPreferences,
    ReminderSchedules,
    ExerciseCategories,
    Exercises,
    ExerciseVariants,
    ExerciseMedia,
    FormCues,
    Programs,
    ProgramWeeks,
    WorkoutTemplates,
    WorkoutTemplateItems,
    WorkoutSessions,
    HoldAttempts,
    SessionFeedback,
    PersonalBests,
    ProgressSnapshots,
    XpEvents,
    UserLevels,
    Achievements,
    AchievementProgress,
    Challenges,
    ChallengeProgress,
    AvatarDefinitions,
    AvatarItems,
    AvatarUnlocks,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  /// In-memory DB for tests.
  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _createIntegrityObjects();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await _createIntegrityObjects();
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _createIntegrityObjects() async {
    // Repair impossible singleton/duplicate states before adding constraints.
    await customStatement(
      'DELETE FROM user_profiles WHERE id NOT IN '
      '(SELECT MIN(id) FROM user_profiles)',
    );
    await customStatement(
      'DELETE FROM user_preferences WHERE id NOT IN '
      '(SELECT MIN(id) FROM user_preferences)',
    );
    await customStatement(
      'DELETE FROM user_levels WHERE id NOT IN '
      '(SELECT MIN(id) FROM user_levels)',
    );
    await customStatement(
      'DELETE FROM reminder_schedules WHERE id NOT IN '
      '(SELECT MIN(id) FROM reminder_schedules)',
    );
    await customStatement(
      'DELETE FROM health_caution_preferences WHERE id NOT IN '
      '(SELECT MIN(id) FROM health_caution_preferences GROUP BY tag)',
    );
    await customStatement(
      'DELETE FROM session_feedback WHERE id NOT IN '
      '(SELECT MAX(id) FROM session_feedback GROUP BY session_id)',
    );

    for (final statement in const [
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_user_profiles_singleton '
          'ON user_profiles ((1))',
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_user_preferences_singleton '
          'ON user_preferences ((1))',
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_user_levels_singleton '
          'ON user_levels ((1))',
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_reminders_singleton '
          'ON reminder_schedules ((1))',
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_health_caution_tag '
          'ON health_caution_preferences (tag)',
      'CREATE UNIQUE INDEX IF NOT EXISTS ux_feedback_session '
          'ON session_feedback (session_id)',
      'CREATE INDEX IF NOT EXISTS ix_sessions_status_started '
          'ON workout_sessions (status, started_at DESC)',
      'CREATE INDEX IF NOT EXISTS ix_holds_session '
          'ON hold_attempts (session_id)',
      'CREATE INDEX IF NOT EXISTS ix_holds_variant_ended '
          'ON hold_attempts (variant_id, ended_at DESC)',
      'CREATE INDEX IF NOT EXISTS ix_templates_program_week '
          'ON workout_templates (program_id, program_week_id)',
      'CREATE INDEX IF NOT EXISTS ix_template_items_order '
          'ON workout_template_items (template_id, sort_order)',
      '''CREATE TRIGGER IF NOT EXISTS fk_hold_session_insert
         BEFORE INSERT ON hold_attempts
         WHEN NOT EXISTS (
           SELECT 1 FROM workout_sessions WHERE id = NEW.session_id
         )
         BEGIN SELECT RAISE(ABORT, 'Unknown workout session'); END''',
      '''CREATE TRIGGER IF NOT EXISTS fk_hold_content_insert
         BEFORE INSERT ON hold_attempts
         WHEN NOT EXISTS (
           SELECT 1 FROM exercises WHERE id = NEW.exercise_id
         ) OR NOT EXISTS (
           SELECT 1 FROM exercise_variants WHERE id = NEW.variant_id
         )
         BEGIN SELECT RAISE(ABORT, 'Unknown exercise content'); END''',
      '''CREATE TRIGGER IF NOT EXISTS fk_feedback_session_insert
         BEFORE INSERT ON session_feedback
         WHEN NOT EXISTS (
           SELECT 1 FROM workout_sessions WHERE id = NEW.session_id
         )
         BEGIN SELECT RAISE(ABORT, 'Unknown feedback session'); END''',
      '''CREATE TRIGGER IF NOT EXISTS fk_template_item_insert
         BEFORE INSERT ON workout_template_items
         WHEN NOT EXISTS (
           SELECT 1 FROM workout_templates WHERE id = NEW.template_id
         ) OR (
           NEW.variant_id IS NOT NULL AND NOT EXISTS (
             SELECT 1 FROM exercise_variants WHERE id = NEW.variant_id
           )
         )
         BEGIN SELECT RAISE(ABORT, 'Unknown template content'); END''',
    ]) {
      await customStatement(statement);
    }
  }

  Future<String?> getMeta(String key) async {
    final row = await (select(
      metaEntries,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setMeta(String key, String value) async {
    await into(metaEntries).insertOnConflictUpdate(
      MetaEntriesCompanion.insert(key: key, value: value),
    );
  }
}

/// Uses [driftDatabase] so Android gets temp-directory + sqlite workarounds.
QueryExecutor _openConnection() {
  return driftDatabase(name: 'isometrix');
}
