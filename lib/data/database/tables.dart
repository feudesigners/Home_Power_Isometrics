import 'package:drift/drift.dart';

class MetaEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text().withDefault(const Constant('Athlete'))();
  TextColumn get goal => text().nullable()();
  TextColumn get startingLevel =>
      text().withDefault(const Constant('foundation'))();
  IntColumn get preferredSessionMinutes =>
      integer().withDefault(const Constant(10))();
  IntColumn get weeklyWorkoutTarget =>
      integer().withDefault(const Constant(3))();
  TextColumn get selectedAvatarId =>
      text().withDefault(const Constant('pulse'))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  IntColumn get onboardingStep => integer().withDefault(const Constant(0))();
  BoolColumn get disclaimerAccepted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class UserPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get theme => text().withDefault(const Constant('system'))();
  BoolColumn get audioEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get voiceEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get hapticsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get reducedMotion =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class HealthCautionPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tag => text()();
  BoolColumn get selected => boolean().withDefault(const Constant(true))();
}

class ReminderSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get weekdaysCsv => text().withDefault(const Constant('1,3,5'))();
  IntColumn get hour => integer().withDefault(const Constant(9))();
  IntColumn get minute => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
}

class ExerciseCategories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get colorHex => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  TextColumn get name => text()();
  TextColumn get primaryMusclesJson => text()();
  TextColumn get secondaryMusclesJson =>
      text().withDefault(const Constant('[]'))();
  IntColumn get contentVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseVariants extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text()();
  TextColumn get displayName => text()();
  IntColumn get difficultyRank => integer()();
  TextColumn get categoryId => text()();
  TextColumn get primaryMusclesJson => text()();
  TextColumn get secondaryMusclesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get equipmentJson => text().withDefault(const Constant('[]'))();
  TextColumn get unilateralMode => text().withDefault(const Constant('none'))();
  IntColumn get targetHoldMs => integer()();
  IntColumn get setupDurationMs =>
      integer().withDefault(const Constant(5000))();
  IntColumn get restDurationMs =>
      integer().withDefault(const Constant(15000))();
  TextColumn get easierVariantId => text().nullable()();
  TextColumn get harderVariantId => text().nullable()();
  TextColumn get breathingCue => text().withDefault(const Constant(''))();
  TextColumn get commonMistakesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get safetyNotes => text().withDefault(const Constant(''))();
  TextColumn get limitationTagsJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get staticAssetId => text().nullable()();
  TextColumn get animatedAssetId => text().nullable()();
  BoolColumn get gatedForBeginners =>
      boolean().withDefault(const Constant(false))();
  TextColumn get reviewStatus =>
      text().withDefault(const Constant('provisional'))();
  IntColumn get contentVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseMedia extends Table {
  TextColumn get id => text()();
  TextColumn get variantId => text().nullable()();
  TextColumn get kind => text()(); // posture | animation | audio
  TextColumn get assetPath => text()();
  TextColumn get accessibilityLabel => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class FormCues extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get variantId => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get cue => text()();
}

class Programs extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get weeks => integer().withDefault(const Constant(1))();
  IntColumn get sessionsPerWeek => integer().withDefault(const Constant(3))();
  IntColumn get estimatedMinutes => integer().withDefault(const Constant(10))();

  @override
  Set<Column> get primaryKey => {id};
}

class ProgramWeeks extends Table {
  TextColumn get id => text()();
  TextColumn get programId => text()();
  IntColumn get weekNumber => integer()();
  TextColumn get focus => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get programId => text().nullable()();
  TextColumn get programWeekId => text().nullable()();
  TextColumn get name => text()();
  IntColumn get estimatedMinutes => integer().withDefault(const Constant(8))();
  BoolColumn get isQuickStart => boolean().withDefault(const Constant(false))();
  BoolColumn get isDefaultRecommended =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutTemplateItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get templateId => text()();
  IntColumn get sortOrder => integer()();
  TextColumn get variantId => text().nullable()();
  TextColumn get itemType =>
      text().withDefault(const Constant('hold'))(); // hold | warmup | cooldown
  TextColumn get label => text().withDefault(const Constant(''))();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
}

class WorkoutSessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text()();
  TextColumn get templateId => text().nullable()();
  TextColumn get programId => text().nullable()();
  IntColumn get plannedDurationMs => integer().withDefault(const Constant(0))();
  IntColumn get actualDurationMs => integer().withDefault(const Constant(0))();
  IntColumn get completedExerciseCount =>
      integer().withDefault(const Constant(0))();
  IntColumn get skippedExerciseCount =>
      integer().withDefault(const Constant(0))();
  IntColumn get perceivedEffort => integer().nullable()();
  BoolColumn get painFlag => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  // Serialized active state for recovery
  TextColumn get recoveryJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class HoldAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get exerciseId => text()();
  TextColumn get variantId => text()();
  TextColumn get side => text().withDefault(const Constant('none'))();
  IntColumn get setNumber => integer().withDefault(const Constant(1))();
  IntColumn get targetMs => integer()();
  IntColumn get completedMs => integer()();
  IntColumn get preparationMs => integer().withDefault(const Constant(0))();
  IntColumn get restMs => integer().withDefault(const Constant(0))();
  IntColumn get pauseMs => integer().withDefault(const Constant(0))();
  TextColumn get result => text()();
  IntColumn get perceivedEffort => integer().nullable()();
  BoolColumn get painFlag => boolean().withDefault(const Constant(false))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SessionFeedback extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  IntColumn get perceivedEffort => integer().nullable()();
  BoolColumn get painFlag => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PersonalBests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get variantId => text()();
  TextColumn get side => text().withDefault(const Constant('none'))();
  IntColumn get bestMs => integer()();
  DateTimeColumn get achievedAt => dateTime()();
  TextColumn get sessionId => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {variantId, side},
  ];
}

class ProgressSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get capturedAt => dateTime()();
  IntColumn get totalSessions => integer()();
  IntColumn get totalHoldMs => integer()();
  IntColumn get weekSessions => integer()();
  TextColumn get payloadJson => text().withDefault(const Constant('{}'))();
}

class XpEvents extends Table {
  TextColumn get id => text()(); // durable idempotency key
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class UserLevels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class AchievementProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get achievementId => text()();
  BoolColumn get unlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
  TextColumn get sourceSessionId => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {achievementId},
  ];
}

class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get targetCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class ChallengeProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get challengeId => text()();
  IntColumn get currentCount => integer().withDefault(const Constant(0))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {challengeId},
  ];
}

class AvatarDefinitions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get statesJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class AvatarItems extends Table {
  TextColumn get id => text()();
  TextColumn get avatarId => text().nullable()();
  TextColumn get kind => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class AvatarUnlocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemId => text()();
  DateTimeColumn get unlockedAt => dateTime()();
  TextColumn get sourceEventId => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {itemId},
  ];
}
