import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../database/database.dart';

/// Imports versioned JSON content without erasing user history.
class ContentSeedService {
  ContentSeedService(this.db);

  final AppDatabase db;
  static const contentVersionKey = 'content_version';

  Future<void> ensureSeeded({String assetPrefix = 'assets/content'}) async {
    final current = await db.getMeta(contentVersionKey);
    final manifestRaw = await rootBundle.loadString(
      '$assetPrefix/content_manifest.json',
    );
    final manifest = jsonDecode(manifestRaw) as Map<String, dynamic>;
    final version = manifest['version'] as int;

    if (current == version.toString()) {
      await _ensureUserDefaults();
      return;
    }

    await db.transaction(() async {
      final exercisesRaw = await rootBundle.loadString(
        '$assetPrefix/exercises_v1.json',
      );
      final mediaRaw = await rootBundle.loadString(
        '$assetPrefix/media_manifest.json',
      );
      final programsRaw = await rootBundle.loadString(
        '$assetPrefix/programs_v1.json',
      );
      final achievementsRaw = await rootBundle.loadString(
        '$assetPrefix/achievements_v1.json',
      );
      final avatarsRaw = await rootBundle.loadString(
        '$assetPrefix/avatars_v1.json',
      );

      await _seedExercises(
        jsonDecode(exercisesRaw) as Map<String, dynamic>,
        jsonDecode(mediaRaw) as Map<String, dynamic>,
      );
      await _seedPrograms(jsonDecode(programsRaw) as Map<String, dynamic>);
      await _seedAchievements(
        jsonDecode(achievementsRaw) as Map<String, dynamic>,
      );
      await _seedAvatars(jsonDecode(avatarsRaw) as Map<String, dynamic>);
      await db.setMeta(contentVersionKey, version.toString());
    });

    await _ensureUserDefaults();
  }

  Future<void> _ensureUserDefaults() async {
    final profiles = await db.select(db.userProfiles).get();
    if (profiles.isEmpty) {
      await db.into(db.userProfiles).insert(UserProfilesCompanion.insert());
    }
    final prefs = await db.select(db.userPreferences).get();
    if (prefs.isEmpty) {
      await db
          .into(db.userPreferences)
          .insert(UserPreferencesCompanion.insert());
    }
    final levels = await db.select(db.userLevels).get();
    if (levels.isEmpty) {
      await db.into(db.userLevels).insert(UserLevelsCompanion.insert());
    }
    final reminders = await db.select(db.reminderSchedules).get();
    if (reminders.isEmpty) {
      await db
          .into(db.reminderSchedules)
          .insert(ReminderSchedulesCompanion.insert());
    }
  }

  Future<void> _seedExercises(
    Map<String, dynamic> data,
    Map<String, dynamic> mediaManifest,
  ) async {
    for (final c in (data['categories'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.exerciseCategories)
          .insertOnConflictUpdate(
            ExerciseCategoriesCompanion.insert(
              id: c['id'] as String,
              name: c['name'] as String,
              colorHex: c['colorHex'] as String,
            ),
          );
    }
    for (final e in (data['exercises'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.exercises)
          .insertOnConflictUpdate(
            ExercisesCompanion.insert(
              id: e['id'] as String,
              categoryId: e['categoryId'] as String,
              name: e['name'] as String,
              primaryMusclesJson: jsonEncode(e['primaryMuscles'] ?? []),
              secondaryMusclesJson: Value(
                jsonEncode(e['secondaryMuscles'] ?? []),
              ),
              contentVersion: Value(
                e['contentVersion'] as int? ?? data['version'] as int? ?? 1,
              ),
            ),
          );
    }
    for (final v in (data['variants'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.exerciseVariants)
          .insertOnConflictUpdate(
            ExerciseVariantsCompanion.insert(
              id: v['id'] as String,
              exerciseId: v['exerciseId'] as String,
              displayName: v['displayName'] as String,
              difficultyRank: v['difficultyRank'] as int,
              categoryId: v['categoryId'] as String,
              primaryMusclesJson: jsonEncode(v['primaryMuscles'] ?? []),
              secondaryMusclesJson: Value(
                jsonEncode(v['secondaryMuscles'] ?? []),
              ),
              equipmentJson: Value(jsonEncode(v['equipment'] ?? [])),
              unilateralMode: Value(v['unilateralMode'] as String? ?? 'none'),
              targetHoldMs: v['targetHoldMs'] as int,
              setupDurationMs: Value(v['setupDurationMs'] as int? ?? 5000),
              restDurationMs: Value(v['restDurationMs'] as int? ?? 15000),
              easierVariantId: Value(v['easierVariantId'] as String?),
              harderVariantId: Value(v['harderVariantId'] as String?),
              breathingCue: Value(v['breathingCue'] as String? ?? ''),
              commonMistakesJson: Value(jsonEncode(v['commonMistakes'] ?? [])),
              safetyNotes: Value(v['safetyNotes'] as String? ?? ''),
              limitationTagsJson: Value(jsonEncode(v['limitationTags'] ?? [])),
              staticAssetId: Value(v['staticAssetId'] as String?),
              animatedAssetId: Value(v['animatedAssetId'] as String?),
              gatedForBeginners: Value(
                v['gatedForBeginners'] as bool? ?? false,
              ),
              reviewStatus: Value(
                v['reviewStatus'] as String? ?? 'provisional',
              ),
              contentVersion: Value(
                v['contentVersion'] as int? ?? data['version'] as int? ?? 1,
              ),
            ),
          );
    }
    await db.delete(db.formCues).go();
    for (final fc in (data['formCues'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.formCues)
          .insert(
            FormCuesCompanion.insert(
              variantId: fc['variantId'] as String,
              sortOrder: Value(fc['sortOrder'] as int? ?? 0),
              cue: fc['cue'] as String,
            ),
          );
    }
    await db.delete(db.exerciseMedia).go();
    for (final m
        in (mediaManifest['media'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.exerciseMedia)
          .insertOnConflictUpdate(
            ExerciseMediaCompanion.insert(
              id: m['id'] as String,
              variantId: Value(m['variantId'] as String?),
              kind: m['kind'] as String,
              assetPath: m['assetPath'] as String,
              accessibilityLabel: m['accessibilityLabel'] as String,
            ),
          );
    }
  }

  Future<void> _seedPrograms(Map<String, dynamic> data) async {
    // Definitions are replaceable seed content; user history keeps textual IDs.
    await db.delete(db.workoutTemplateItems).go();
    await db.delete(db.workoutTemplates).go();
    await db.delete(db.programWeeks).go();
    await db.delete(db.programs).go();

    for (final p in (data['programs'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.programs)
          .insertOnConflictUpdate(
            ProgramsCompanion.insert(
              id: p['id'] as String,
              name: p['name'] as String,
              description: p['description'] as String,
              weeks: Value(p['weeks'] as int? ?? 1),
              sessionsPerWeek: Value(p['sessionsPerWeek'] as int? ?? 3),
              estimatedMinutes: Value(p['estimatedMinutes'] as int? ?? 10),
            ),
          );
    }
    for (final w
        in (data['programWeeks'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.programWeeks)
          .insertOnConflictUpdate(
            ProgramWeeksCompanion.insert(
              id: w['id'] as String,
              programId: w['programId'] as String,
              weekNumber: w['weekNumber'] as int,
              focus: Value(w['focus'] as String? ?? ''),
            ),
          );
    }
    for (final t
        in (data['workoutTemplates'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.workoutTemplates)
          .insertOnConflictUpdate(
            WorkoutTemplatesCompanion.insert(
              id: t['id'] as String,
              programId: Value(t['programId'] as String?),
              programWeekId: Value(t['programWeekId'] as String?),
              name: t['name'] as String,
              estimatedMinutes: Value(t['estimatedMinutes'] as int? ?? 8),
              isQuickStart: Value(t['isQuickStart'] as bool? ?? false),
              isDefaultRecommended: Value(
                t['isDefaultRecommended'] as bool? ?? false,
              ),
            ),
          );
    }
    for (final i
        in (data['workoutTemplateItems'] as List)
            .cast<Map<String, dynamic>>()) {
      await db
          .into(db.workoutTemplateItems)
          .insert(
            WorkoutTemplateItemsCompanion.insert(
              templateId: i['templateId'] as String,
              sortOrder: i['sortOrder'] as int,
              variantId: Value(i['variantId'] as String?),
              itemType: Value(i['itemType'] as String? ?? 'hold'),
              label: Value(i['label'] as String? ?? ''),
              durationMs: Value(i['durationMs'] as int? ?? 0),
            ),
          );
    }
  }

  Future<void> _seedAchievements(Map<String, dynamic> data) async {
    for (final a
        in (data['achievements'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.achievements)
          .insertOnConflictUpdate(
            AchievementsCompanion.insert(
              id: a['id'] as String,
              name: a['name'] as String,
              description: a['description'] as String,
            ),
          );
    }
    for (final c in (data['challenges'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.challenges)
          .insertOnConflictUpdate(
            ChallengesCompanion.insert(
              id: c['id'] as String,
              name: c['name'] as String,
              description: c['description'] as String,
              targetCount: c['targetCount'] as int,
            ),
          );
    }
  }

  Future<void> _seedAvatars(Map<String, dynamic> data) async {
    for (final a in (data['avatars'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.avatarDefinitions)
          .insertOnConflictUpdate(
            AvatarDefinitionsCompanion.insert(
              id: a['id'] as String,
              name: a['name'] as String,
              description: a['description'] as String,
              statesJson: jsonEncode(a['statesJson'] ?? []),
            ),
          );
    }
    for (final i in (data['items'] as List).cast<Map<String, dynamic>>()) {
      await db
          .into(db.avatarItems)
          .insertOnConflictUpdate(
            AvatarItemsCompanion.insert(
              id: i['id'] as String,
              avatarId: Value(i['avatarId'] as String?),
              kind: i['kind'] as String,
              name: i['name'] as String,
            ),
          );
    }
  }
}
