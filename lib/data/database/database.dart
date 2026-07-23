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
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // v1 baseline — future content/user migrations go here.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

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
