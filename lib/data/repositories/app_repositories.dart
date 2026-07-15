import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/enums.dart';
import '../../domain/services/achievement_evaluator.dart';
import '../../domain/services/challenge_evaluator.dart';
import '../../domain/services/export_import_service.dart';
import '../../domain/services/personal_best_service.dart';
import '../../domain/services/progression_recommendation_service.dart';
import '../../domain/services/workout_state_machine.dart';
import '../../domain/services/xp_service.dart';
import '../database/database.dart';

class AppRepositories {
  AppRepositories(this.db);

  final AppDatabase db;
  final _uuid = const Uuid();
  final xpService = const XpService();
  final achievements = const AchievementEvaluator();
  final challenges = const ChallengeEvaluator();
  final personalBests = const PersonalBestService();
  final progression = const ProgressionRecommendationService();

  Future<UserProfile> profile() async {
    return (await db.select(db.userProfiles).get()).first;
  }

  Future<UserPreference> preferences() async {
    return (await db.select(db.userPreferences).get()).first;
  }

  Future<void> updateTheme(String theme) async {
    final pref = await preferences();
    await (db.update(
      db.userPreferences,
    )..where((t) => t.id.equals(pref.id))).write(
      UserPreferencesCompanion(
        theme: Value(theme),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> selectAvatar(String avatarId) async {
    final available = await (db.select(
      db.avatarDefinitions,
    )..where((t) => t.id.equals(avatarId))).getSingleOrNull();
    if (available == null) return;
    final current = await profile();
    await (db.update(
      db.userProfiles,
    )..where((t) => t.id.equals(current.id))).write(
      UserProfilesCompanion(
        selectedAvatarId: Value(avatarId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> saveOnboarding({
    required int step,
    required bool complete,
    String? displayName,
    String? goal,
    String? startingLevel,
    int? sessionMinutes,
    int? weeklyTarget,
    String? avatarId,
    List<String>? limitationTags,
    bool? disclaimer,
    bool? audio,
    bool? haptics,
    bool? reducedMotion,
  }) async {
    final p = await profile();
    await (db.update(db.userProfiles)..where((t) => t.id.equals(p.id))).write(
      UserProfilesCompanion(
        onboardingStep: Value(step),
        onboardingComplete: Value(complete),
        displayName: displayName != null
            ? Value(displayName)
            : const Value.absent(),
        goal: goal != null ? Value(goal) : const Value.absent(),
        startingLevel: startingLevel != null
            ? Value(startingLevel)
            : const Value.absent(),
        preferredSessionMinutes: sessionMinutes != null
            ? Value(sessionMinutes)
            : const Value.absent(),
        weeklyWorkoutTarget: weeklyTarget != null
            ? Value(weeklyTarget)
            : const Value.absent(),
        selectedAvatarId: avatarId != null
            ? Value(avatarId)
            : const Value.absent(),
        disclaimerAccepted: disclaimer != null
            ? Value(disclaimer)
            : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
    if (limitationTags != null) {
      await db.delete(db.healthCautionPreferences).go();
      for (final tag in limitationTags) {
        await db
            .into(db.healthCautionPreferences)
            .insert(HealthCautionPreferencesCompanion.insert(tag: tag));
      }
    }
    if (audio != null || haptics != null || reducedMotion != null) {
      final pref = await preferences();
      await (db.update(
        db.userPreferences,
      )..where((t) => t.id.equals(pref.id))).write(
        UserPreferencesCompanion(
          audioEnabled: audio != null ? Value(audio) : const Value.absent(),
          hapticsEnabled: haptics != null
              ? Value(haptics)
              : const Value.absent(),
          reducedMotion: reducedMotion != null
              ? Value(reducedMotion)
              : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<List<String>> limitationTags() async {
    final rows = await db.select(db.healthCautionPreferences).get();
    return rows.where((r) => r.selected).map((r) => r.tag).toList();
  }

  Future<WorkoutTemplate?> recommendedTemplate() async {
    final rows = await (db.select(
      db.workoutTemplates,
    )..where((t) => t.isDefaultRecommended.equals(true))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<WorkoutTemplate?> quickStartTemplate() async {
    final rows = await (db.select(
      db.workoutTemplates,
    )..where((t) => t.isQuickStart.equals(true))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<WorkoutTemplateItem>> templateItems(String templateId) {
    return (db.select(db.workoutTemplateItems)
          ..where((t) => t.templateId.equals(templateId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<ExerciseVariant?> variantById(String id) {
    return (db.select(
      db.exerciseVariants,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<ExerciseVariant>> allVariants() =>
      db.select(db.exerciseVariants).get();

  Future<List<Exercise>> allExercises() => db.select(db.exercises).get();

  Future<List<ExerciseCategory>> categories() =>
      db.select(db.exerciseCategories).get();

  Future<List<Program>> programs() => db.select(db.programs).get();

  Future<List<WorkoutTemplate>> templatesForProgram(String programId) {
    return (db.select(
      db.workoutTemplates,
    )..where((t) => t.programId.equals(programId))).get();
  }

  Future<List<WorkoutTemplate>> allTemplates() =>
      db.select(db.workoutTemplates).get();

  Future<List<FormCue>> formCuesFor(String variantId) {
    return (db.select(db.formCues)
          ..where((t) => t.variantId.equals(variantId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<ExerciseMediaData?> mediaById(String? id) {
    if (id == null) return Future.value();
    return (db.select(
      db.exerciseMedia,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<WorkoutPlanItem>> planFromTemplate(String templateId) async {
    final items = await templateItems(templateId);
    final plan = <WorkoutPlanItem>[];
    for (final item in items) {
      if (item.itemType != 'hold') {
        plan.add(
          WorkoutPlanItem(
            variantId: 'block_${item.id}',
            exerciseId: '',
            displayName: item.label,
            holdDuration: Duration(milliseconds: item.durationMs),
            setupDuration: Duration.zero,
            restDuration: Duration.zero,
            kind: item.itemType == 'cooldown'
                ? WorkoutItemKind.cooldown
                : WorkoutItemKind.warmup,
          ),
        );
        continue;
      }
      if (item.variantId == null) continue;
      final baseVariantId = item.variantId!;
      final acceptedVariantId =
          await db.getMeta('progression_variant_$baseVariantId');
      final v = await variantById(acceptedVariantId ?? baseVariantId);
      if (v == null) continue;
      final acceptedHoldMs = int.tryParse(
        await db.getMeta('progression_hold_${v.id}') ?? '',
      );
      final cues = await formCuesFor(v.id);
      final media = await mediaById(v.staticAssetId);
      final animatedMedia = await mediaById(v.animatedAssetId);
      plan.add(
        WorkoutPlanItem(
          variantId: v.id,
          exerciseId: v.exerciseId,
          displayName: v.displayName,
          holdDuration: Duration(
            milliseconds: acceptedHoldMs ?? v.targetHoldMs,
          ),
          setupDuration: Duration(milliseconds: v.setupDurationMs),
          restDuration: Duration(milliseconds: v.restDurationMs),
          unilateralMode: unilateralModeFromString(v.unilateralMode),
          formCues: cues.map((c) => c.cue).toList(),
          breathingCue: v.breathingCue,
          staticAssetPath: media?.assetPath,
          animatedAssetPath: animatedMedia?.assetPath,
          mediaAccessibilityLabel: media?.accessibilityLabel,
          animatedMediaAccessibilityLabel:
              animatedMedia?.accessibilityLabel,
          easierVariantId: v.easierVariantId,
          harderVariantId: v.harderVariantId,
        ),
      );
    }
    return plan;
  }

  Future<List<WorkoutPlanItem>> planForPractice(String variantId) async {
    final v = await variantById(variantId);
    if (v == null) return const [];
    final cues = await formCuesFor(v.id);
    final media = await mediaById(v.staticAssetId);
      final animatedMedia = await mediaById(v.animatedAssetId);
    return [
      WorkoutPlanItem(
        variantId: v.id,
        exerciseId: v.exerciseId,
        displayName: v.displayName,
        holdDuration: Duration(milliseconds: v.targetHoldMs),
        setupDuration: Duration(milliseconds: v.setupDurationMs),
        restDuration: Duration(milliseconds: v.restDurationMs),
        unilateralMode: unilateralModeFromString(v.unilateralMode),
        formCues: cues.map((c) => c.cue).toList(),
        breathingCue: v.breathingCue,
        staticAssetPath: media?.assetPath,
          animatedAssetPath: animatedMedia?.assetPath,
          mediaAccessibilityLabel: media?.accessibilityLabel,
          animatedMediaAccessibilityLabel:
              animatedMedia?.accessibilityLabel,
          easierVariantId: v.easierVariantId,
          harderVariantId: v.harderVariantId,
      ),
    ];
  }

  Future<String> startSession({
    required String? templateId,
    required String? programId,
    required int plannedDurationMs,
  }) async {
    final id = _uuid.v4();
    await db
        .into(db.workoutSessions)
        .insert(
          WorkoutSessionsCompanion.insert(
            id: id,
            startedAt: DateTime.now(),
            status: SessionStatus.active.name,
            templateId: Value(templateId),
            programId: Value(programId),
            plannedDurationMs: Value(plannedDurationMs),
          ),
        );
    return id;
  }

  Future<void> persistRecovery(
    String sessionId,
    Map<String, dynamic> snap,
  ) async {
    await (db.update(
      db.workoutSessions,
    )..where((t) => t.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(
        status: Value(SessionStatus.interrupted.name),
        recoveryJson: Value(jsonEncode(snap)),
      ),
    );
  }

  Future<void> markSessionPaused(
    String sessionId,
    Map<String, dynamic> snap,
  ) async {
    await (db.update(
      db.workoutSessions,
    )..where((t) => t.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(
        status: Value(SessionStatus.paused.name),
        recoveryJson: Value(jsonEncode(snap)),
      ),
    );
  }

  Future<WorkoutSession?> interruptedSession() async {
    final rows =
        await (db.select(db.workoutSessions)..where(
              (t) =>
                  t.status.equals(SessionStatus.interrupted.name) |
                  t.status.equals(SessionStatus.paused.name) |
                  t.status.equals(SessionStatus.active.name),
            ))
            .get();
    return rows.isEmpty ? null : rows.last;
  }

  Future<void> recordHoldAttempt({
    required String sessionId,
    required String exerciseId,
    required String variantId,
    required HoldSide side,
    required int setNumber,
    required int targetMs,
    required int completedMs,
    required int preparationMs,
    required int restMs,
    required int pauseMs,
    required HoldResult result,
    required bool painFlag,
    int? effort,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await db
        .into(db.holdAttempts)
        .insert(
          HoldAttemptsCompanion.insert(
            id: id,
            sessionId: sessionId,
            exerciseId: exerciseId,
            variantId: variantId,
            side: Value(side.name),
            setNumber: Value(setNumber),
            targetMs: targetMs,
            completedMs: completedMs,
            preparationMs: Value(preparationMs),
            restMs: Value(restMs),
            pauseMs: Value(pauseMs),
            result: result.name,
            perceivedEffort: Value(effort),
            painFlag: Value(painFlag),
            startedAt: now.subtract(Duration(milliseconds: completedMs)),
            endedAt: now,
          ),
        );

    final pb = personalBests.consider(
      attempt: PersonalBestCandidate(
        variantId: variantId,
        side: side,
        completedMs: completedMs,
        result: result,
      ),
      existingBestMs: await _existingBest(variantId, side),
    );
    if (pb != null) {
      final existing =
          await (db.select(db.personalBests)..where(
                (t) =>
                    t.variantId.equals(pb.variantId) &
                    t.side.equals(pb.side.name),
              ))
              .getSingleOrNull();
      if (existing == null) {
        await db
            .into(db.personalBests)
            .insert(
              PersonalBestsCompanion.insert(
                variantId: pb.variantId,
                side: Value(pb.side.name),
                bestMs: pb.bestMs,
                achievedAt: now,
                sessionId: Value(sessionId),
              ),
            );
      } else {
        await (db.update(
          db.personalBests,
        )..where((t) => t.id.equals(existing.id))).write(
          PersonalBestsCompanion(
            bestMs: Value(pb.bestMs),
            achievedAt: Value(now),
            sessionId: Value(sessionId),
          ),
        );
      }
    }
  }

  Future<int?> _existingBest(String variantId, HoldSide side) async {
    final row =
        await (db.select(db.personalBests)..where(
              (t) => t.variantId.equals(variantId) & t.side.equals(side.name),
            ))
            .getSingleOrNull();
    return row?.bestMs;
  }

  Future<void> finalizeSession({
    required String sessionId,
    required int actualDurationMs,
    required int completedCount,
    required int skippedCount,
    required bool pain,
  }) async {
    await db.transaction(() async {
      final existing = await (db.select(
        db.workoutSessions,
      )..where((t) => t.id.equals(sessionId))).getSingleOrNull();
      if (existing == null ||
          existing.status == SessionStatus.completed.name) {
        return;
      }
      await (db.update(
        db.workoutSessions,
      )..where((t) => t.id.equals(sessionId))).write(
        WorkoutSessionsCompanion(
          status: Value(SessionStatus.completed.name),
          completedAt: Value(DateTime.now()),
          actualDurationMs: Value(actualDurationMs),
          completedExerciseCount: Value(completedCount),
          skippedExerciseCount: Value(skippedCount),
          painFlag: Value(pain),
          recoveryJson: const Value(null),
        ),
      );
      await _awardCompletionRewards(
        sessionId: sessionId,
        pain: pain,
        effort: null,
      );
    });
  }

  Future<void> saveSessionFeedback({
    required String sessionId,
    required int effort,
    required bool pain,
    String? note,
  }) async {
    if (effort < 1 || effort > 10) {
      throw const FormatException('Effort must be between 1 and 10.');
    }
    await db.transaction(() async {
      final session = await (db.select(
        db.workoutSessions,
      )..where((t) => t.id.equals(sessionId))).getSingleOrNull();
      if (session == null ||
          session.status != SessionStatus.completed.name) {
        throw const FormatException(
          'Feedback can only be saved for a completed session.',
        );
      }
      await (db.update(
        db.workoutSessions,
      )..where((t) => t.id.equals(sessionId))).write(
        WorkoutSessionsCompanion(
          perceivedEffort: Value(effort),
          painFlag: Value(pain || session.painFlag),
          note: Value(note),
        ),
      );

      final existing = await (db.select(
        db.sessionFeedback,
      )..where((t) => t.sessionId.equals(sessionId))).getSingleOrNull();
      if (existing == null) {
        await db.into(db.sessionFeedback).insert(
          SessionFeedbackCompanion.insert(
            sessionId: sessionId,
            perceivedEffort: Value(effort),
            painFlag: Value(pain || session.painFlag),
            note: Value(note),
          ),
        );
      } else {
        await (db.update(
          db.sessionFeedback,
        )..where((t) => t.id.equals(existing.id))).write(
          SessionFeedbackCompanion(
            perceivedEffort: Value(effort),
            painFlag: Value(pain || session.painFlag),
            note: Value(note),
          ),
        );
      }
      await _awardCompletionRewards(
        sessionId: sessionId,
        pain: pain || session.painFlag,
        effort: effort,
      );
    });
  }

  Future<void> completeSession({
    required String sessionId,
    required int actualDurationMs,
    required int completedCount,
    required int skippedCount,
    required int? effort,
    required bool pain,
    String? note,
  }) async {
    await finalizeSession(
      sessionId: sessionId,
      actualDurationMs: actualDurationMs,
      completedCount: completedCount,
      skippedCount: skippedCount,
      pain: pain,
    );
    if (effort != null) {
      await saveSessionFeedback(
        sessionId: sessionId,
        effort: effort,
        pain: pain,
        note: note,
      );
    }
  }

  Future<void> abandonSession(String sessionId, {bool partial = true}) async {
    await (db.update(
      db.workoutSessions,
    )..where((t) => t.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(
        status: Value(
          partial ? SessionStatus.abandoned.name : SessionStatus.abandoned.name,
        ),
        completedAt: Value(DateTime.now()),
        recoveryJson: const Value(null),
      ),
    );
  }

  Future<void> discardSession(String sessionId) async {
    await (db.delete(
      db.holdAttempts,
    )..where((t) => t.sessionId.equals(sessionId))).go();
    await (db.delete(
      db.workoutSessions,
    )..where((t) => t.id.equals(sessionId))).go();
  }

  Future<void> _awardCompletionRewards({
    required String sessionId,
    required bool pain,
    required int? effort,
  }) async {
    final existingXp = (await db.select(db.xpEvents).get())
        .map((e) => e.id)
        .toSet();
    var changed = false;

    final xpId = 'xp_session_$sessionId';
    final base = xpService.award(
      existingEventIds: existingXp,
      eventId: xpId,
      amount: XpService.sessionCompleteBase,
      painReported: false,
    );
    if (base > 0) {
      await db.into(db.xpEvents).insert(
        XpEventsCompanion.insert(
          id: xpId,
          sourceType: 'session',
          sourceId: sessionId,
          amount: base,
        ),
      );
      existingXp.add(xpId);
      changed = true;
    }

    if (effort != null) {
      final feedbackId = 'xp_feedback_$sessionId';
      final bonus = xpService.award(
        existingEventIds: existingXp,
        eventId: feedbackId,
        amount: XpService.feedbackBonus,
        painReported: pain,
      );
      if (bonus > 0) {
        await db.into(db.xpEvents).insert(
          XpEventsCompanion.insert(
            id: feedbackId,
            sourceType: 'feedback',
            sourceId: sessionId,
            amount: bonus,
          ),
        );
        changed = true;
      }
    }

    if (changed) await _recalcLevel();
    await _evaluateAchievements(sessionId);
    if (base > 0) await _evaluateChallenges(sessionId);
  }

  Future<void> _recalcLevel() async {
    final events = await db.select(db.xpEvents).get();
    final total = events.fold<int>(0, (a, e) => a + e.amount);
    final level = xpService.levelForXp(total);
    final row = (await db.select(db.userLevels).get()).first;
    await (db.update(db.userLevels)..where((t) => t.id.equals(row.id))).write(
      UserLevelsCompanion(
        totalXp: Value(total),
        level: Value(level),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _evaluateAchievements(String sessionId) async {
    final sessions = await (db.select(
      db.workoutSessions,
    )..where((t) => t.status.equals(SessionStatus.completed.name))).get();
    final holds = await db.select(db.holdAttempts).get();
    final unlocked = (await db.select(db.achievementProgress).get())
        .where((a) => a.unlocked)
        .map((a) => a.achievementId)
        .toSet();
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final weekSessions = sessions
        .where((s) => s.startedAt.isAfter(weekAgo))
        .toList();
    final cats = <String>{};
    for (final h in holds.where(
      (h) =>
          weekSessions.any((s) => s.id == h.sessionId) &&
          h.result == HoldResult.completed.name,
    )) {
      final v = await variantById(h.variantId);
      if (v != null) cats.add(v.categoryId);
    }
    final completedHolds = holds
        .where((h) => h.result == HoldResult.completed.name)
        .toList();
    final totalHoldMs = completedHolds.fold<int>(
      0,
      (a, h) => a + h.completedMs,
    );

    DateTime? previous;
    for (final s in sessions) {
      if (s.id == sessionId) continue;
      if (previous == null || s.completedAt?.isAfter(previous) == true) {
        previous = s.completedAt ?? s.startedAt;
      }
    }
    final daysSince = previous == null
        ? null
        : DateTime.now().difference(previous).inDays;

    final newly = achievements.evaluate(
      AchievementContext(
        totalCompletedSessions: sessions.length,
        totalHoldAttempts: completedHolds.length,
        totalControlledHoldMs: totalHoldMs,
        sessionsThisWeek: weekSessions.length,
        weeklyTarget: (await profile()).weeklyWorkoutTarget,
        categoriesThisWeek: cats,
        hadProgression:
            int.tryParse(await db.getMeta('accepted_progression_count') ?? '0') !=
            0,
        daysSinceLastSession: daysSince,
        alreadyUnlocked: unlocked,
      ),
    );

    final currentSession = sessions
        .where((session) => session.id == sessionId)
        .firstOrNull;
    if (currentSession?.programId == 'core_control' &&
        !unlocked.contains('core_control')) {
      newly.add('core_control');
    }
    if (currentSession?.programId == 'lower_body_stability' &&
        !unlocked.contains('lower_body_stability')) {
      newly.add('lower_body_stability');
    }

    for (final id in newly) {
      await db
          .into(db.achievementProgress)
          .insertOnConflictUpdate(
            AchievementProgressCompanion.insert(
              achievementId: id,
              unlocked: const Value(true),
              unlockedAt: Value(DateTime.now()),
              sourceSessionId: Value(sessionId),
            ),
          );
    }
  }

  Future<void> _evaluateChallenges(String sessionId) async {
    final defs = ChallengeEvaluator.definitions;
    for (final def in defs) {
      final existing = await (db.select(
        db.challengeProgress,
      )..where((t) => t.challengeId.equals(def.id))).getSingleOrNull();
      final snap = challenges.apply(
        def: def,
        previousCount: existing?.currentCount ?? 0,
        alreadyCompleted: existing?.completed ?? false,
        increment:
            def.id == 'first_workout' ||
                def.id == 'three_sessions_week' ||
                def.id == 'seven_day_starter' ||
                def.id == 'twenty_one_day_consistency'
            ? 1
            : 0,
      );
      await db
          .into(db.challengeProgress)
          .insertOnConflictUpdate(
            ChallengeProgressCompanion.insert(
              challengeId: def.id,
              currentCount: Value(snap.currentCount),
              completed: Value(snap.completed),
              completedAt: snap.completed
                  ? Value(DateTime.now())
                  : const Value.absent(),
            ),
          );
    }
  }

  Future<UserLevel> userLevel() async =>
      (await db.select(db.userLevels).get()).first;

  Future<List<WorkoutSession>> recentSessions({int limit = 30}) {
    return (db.select(db.workoutSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(limit))
        .get();
  }

  Future<List<HoldAttempt>> holdsForSession(String sessionId) {
    return (db.select(
      db.holdAttempts,
    )..where((t) => t.sessionId.equals(sessionId))).get();
  }

  Future<List<AchievementProgressData>> achievementProgress() =>
      db.select(db.achievementProgress).get();

  Future<List<ChallengeProgressData>> challengeProgress() =>
      db.select(db.challengeProgress).get();

  Future<List<AvatarDefinition>> avatars() =>
      db.select(db.avatarDefinitions).get();

  Future<List<PersonalBest>> bests() => db.select(db.personalBests).get();

  Future<List<ProgressionSuggestion>> progressionSuggestionsForSession(
    String sessionId,
  ) async {
    final session = await (db.select(
      db.workoutSessions,
    )..where((t) => t.id.equals(sessionId))).getSingleOrNull();
    if (session == null) return const [];
    final attempts = await holdsForSession(sessionId);
    final careTags = await limitationTags();
    final suggestions = <ProgressionSuggestion>[];
    final seen = <String>{};

    for (final attempt in attempts.reversed) {
      if (!seen.add(attempt.variantId)) continue;
      final variant = await variantById(attempt.variantId);
      if (variant == null) continue;
      final cutoff = (session.completedAt ?? session.startedAt).subtract(
        const Duration(days: 28),
      );
      final successes =
          (await (db.select(db.holdAttempts)..where(
                    (t) =>
                        t.variantId.equals(attempt.variantId) &
                        t.result.equals(HoldResult.completed.name),
                  ))
                  .get())
              .where(
                (row) =>
                    !row.endedAt.isBefore(cutoff) &&
                    !row.endedAt.isAfter(
                      session.completedAt ?? DateTime.now(),
                    ),
              )
              .toList()
            ..sort((a, b) => b.endedAt.compareTo(a.endedAt));
      final recommendation = progression.recommend(
        ProgressionInput(
          variantId: variant.id,
          easierVariantId: variant.easierVariantId,
          harderVariantId: variant.harderVariantId,
          targetMs: attempt.targetMs,
          completedMs: attempt.completedMs,
          perceivedEffort: session.perceivedEffort ?? 8,
          painReported: session.painFlag || attempt.painFlag,
          formMaintained: attempt.result == HoldResult.completed.name,
          result: holdResultFromString(attempt.result),
          recentSuccessfulCompletions: successes.take(2).length,
          limitationTags: careTags,
          variantLimitationTags:
              (jsonDecode(variant.limitationTagsJson) as List).cast<String>(),
        ),
      );
      suggestions.add(
        ProgressionSuggestion(
          variantId: variant.id,
          displayName: variant.displayName,
          recommendation: recommendation,
        ),
      );
    }
    return suggestions;
  }

  Future<void> acceptProgression({
    required String sessionId,
    required ProgressionSuggestion suggestion,
  }) async {
    final recommendation = suggestion.recommendation;
    if (recommendation.action == ProgressionAction.maintain) return;
    final targetVariant = recommendation.suggestedVariantId;
    if (targetVariant != null && await variantById(targetVariant) == null) {
      throw const FormatException('Suggested variation is unavailable.');
    }

    await db.transaction(() async {
      if (targetVariant != null) {
        await db.setMeta(
          'progression_variant_${suggestion.variantId}',
          targetVariant,
        );
      }
      if (recommendation.suggestedHoldMs != null) {
        await db.setMeta(
          'progression_hold_${suggestion.variantId}',
          recommendation.suggestedHoldMs.toString(),
        );
      }
      final current =
          int.tryParse(await db.getMeta('accepted_progression_count') ?? '0') ??
          0;
      await db.setMeta('accepted_progression_count', '${current + 1}');

      final eventId = 'xp_progression_${sessionId}_${suggestion.variantId}';
      final existing = (await db.select(db.xpEvents).get())
          .map((event) => event.id)
          .toSet();
      final amount = xpService.award(
        existingEventIds: existing,
        eventId: eventId,
        amount: XpService.progressionAttemptBonus,
        painReported: false,
      );
      if (amount > 0) {
        await db.into(db.xpEvents).insert(
          XpEventsCompanion.insert(
            id: eventId,
            sourceType: 'progression',
            sourceId: suggestion.variantId,
            amount: amount,
          ),
        );
        await _recalcLevel();
      }

      final challenge = ChallengeEvaluator.definitions
          .where((definition) => definition.id == 'progression_milestones')
          .firstOrNull;
      if (challenge != null) {
        final existingProgress = await (db.select(
          db.challengeProgress,
        )..where(
          (table) => table.challengeId.equals(challenge.id),
        )).getSingleOrNull();
        final next = challenges.apply(
          def: challenge,
          previousCount: existingProgress?.currentCount ?? 0,
          alreadyCompleted: existingProgress?.completed ?? false,
          increment: amount > 0 ? 1 : 0,
        );
        await db.into(db.challengeProgress).insertOnConflictUpdate(
          ChallengeProgressCompanion.insert(
            challengeId: challenge.id,
            currentCount: Value(next.currentCount),
            completed: Value(next.completed),
            completedAt: next.completed
                ? Value(DateTime.now())
                : const Value.absent(),
          ),
        );
      }
      await _evaluateAchievements(sessionId);
    });
  }

  Future<void> deleteAllUserData() async {
    await db.transaction(() async {
      await db.delete(db.holdAttempts).go();
      await db.delete(db.sessionFeedback).go();
      await db.delete(db.workoutSessions).go();
      await db.delete(db.xpEvents).go();
      await db.delete(db.achievementProgress).go();
      await db.delete(db.challengeProgress).go();
      await db.delete(db.personalBests).go();
      await db.delete(db.progressSnapshots).go();
      await db.delete(db.avatarUnlocks).go();
      await db.delete(db.healthCautionPreferences).go();
      final levels = await db.select(db.userLevels).get();
      for (final l in levels) {
        await (db.update(db.userLevels)..where((t) => t.id.equals(l.id))).write(
          const UserLevelsCompanion(totalXp: Value(0), level: Value(1)),
        );
      }
      final profiles = await db.select(db.userProfiles).get();
      for (final p in profiles) {
        await (db.update(
          db.userProfiles,
        )..where((t) => t.id.equals(p.id))).write(
          const UserProfilesCompanion(
            onboardingComplete: Value(false),
            onboardingStep: Value(0),
            disclaimerAccepted: Value(false),
          ),
        );
      }
    });
  }

  Future<Map<String, dynamic>> exportUserData() async {
    final p = await profile();
    final pref = await preferences();
    final sessions = await db.select(db.workoutSessions).get();
    final holds = await db.select(db.holdAttempts).get();
    final xp = await db.select(db.xpEvents).get();
    final ach = await db.select(db.achievementProgress).get();
    return {
      'schemaVersion': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'profile': {
        'displayName': p.displayName,
        'goal': p.goal,
        'startingLevel': p.startingLevel,
        'preferredSessionMinutes': p.preferredSessionMinutes,
        'weeklyWorkoutTarget': p.weeklyWorkoutTarget,
        'selectedAvatarId': p.selectedAvatarId,
      },
      'preferences': {
        'theme': pref.theme,
        'audioEnabled': pref.audioEnabled,
        'hapticsEnabled': pref.hapticsEnabled,
        'reducedMotion': pref.reducedMotion,
      },
      'sessions': sessions
          .map(
            (s) => {
              'id': s.id,
              'startedAt': s.startedAt.toIso8601String(),
              'completedAt': s.completedAt?.toIso8601String(),
              'status': s.status,
              'templateId': s.templateId,
              'programId': s.programId,
              'plannedDurationMs': s.plannedDurationMs,
              'actualDurationMs': s.actualDurationMs,
              'completedExerciseCount': s.completedExerciseCount,
              'skippedExerciseCount': s.skippedExerciseCount,
              'effort': s.perceivedEffort,
              'pain': s.painFlag,
              'note': s.note,
            },
          )
          .toList(),
      'holdAttempts': holds
          .map(
            (h) => {
              'id': h.id,
              'sessionId': h.sessionId,
              'exerciseId': h.exerciseId,
              'variantId': h.variantId,
              'side': h.side,
              'setNumber': h.setNumber,
              'targetMs': h.targetMs,
              'completedMs': h.completedMs,
              'preparationMs': h.preparationMs,
              'restMs': h.restMs,
              'pauseMs': h.pauseMs,
              'result': h.result,
              'effort': h.perceivedEffort,
              'pain': h.painFlag,
              'startedAt': h.startedAt.toIso8601String(),
              'endedAt': h.endedAt.toIso8601String(),
            },
          )
          .toList(),
      'xpEvents': xp
          .map(
            (e) => {
              'id': e.id,
              'sourceType': e.sourceType,
              'sourceId': e.sourceId,
              'amount': e.amount,
              'createdAt': e.createdAt.toIso8601String(),
            },
          )
          .toList(),
      'achievements': ach
          .map(
            (a) => {
              'achievementId': a.achievementId,
              'unlocked': a.unlocked,
              'unlockedAt': a.unlockedAt?.toIso8601String(),
              'sourceSessionId': a.sourceSessionId,
            },
          )
          .toList(),
    };
  }

  Future<ImportSummary> importUserData(String raw) async {
    final data = ExportImportService().parseAndValidate(raw);
    final profileData = data['profile'] as Map<String, dynamic>?;
    final preferenceData = data['preferences'] as Map<String, dynamic>?;
    final sessions = (data['sessions'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    final holds = (data['holdAttempts'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    final xp = (data['xpEvents'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    final achievementRows = (data['achievements'] as List? ?? const [])
        .cast<Map<String, dynamic>>();

    await db.transaction(() async {
      if (profileData != null) {
        final current = await profile();
        await (db.update(
          db.userProfiles,
        )..where((t) => t.id.equals(current.id))).write(
          UserProfilesCompanion(
            displayName: _stringValue(profileData, 'displayName'),
            goal: _nullableStringValue(profileData, 'goal'),
            startingLevel: _stringValue(profileData, 'startingLevel'),
            preferredSessionMinutes: _intValue(
              profileData,
              'preferredSessionMinutes',
            ),
            weeklyWorkoutTarget: _intValue(profileData, 'weeklyWorkoutTarget'),
            selectedAvatarId: _stringValue(profileData, 'selectedAvatarId'),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
      if (preferenceData != null) {
        final current = await preferences();
        await (db.update(
          db.userPreferences,
        )..where((t) => t.id.equals(current.id))).write(
          UserPreferencesCompanion(
            theme: _stringValue(preferenceData, 'theme'),
            audioEnabled: _boolValue(preferenceData, 'audioEnabled'),
            hapticsEnabled: _boolValue(preferenceData, 'hapticsEnabled'),
            reducedMotion: _boolValue(preferenceData, 'reducedMotion'),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
      for (final s in sessions) {
        await db
            .into(db.workoutSessions)
            .insertOnConflictUpdate(
              WorkoutSessionsCompanion.insert(
                id: s['id'] as String,
                startedAt: DateTime.parse(s['startedAt'] as String),
                status: s['status'] as String,
                completedAt: Value(_dateOrNull(s['completedAt'])),
                templateId: Value(s['templateId'] as String?),
                programId: Value(s['programId'] as String?),
                plannedDurationMs: Value(s['plannedDurationMs'] as int? ?? 0),
                actualDurationMs: Value(s['actualDurationMs'] as int? ?? 0),
                completedExerciseCount: Value(
                  s['completedExerciseCount'] as int? ?? 0,
                ),
                skippedExerciseCount: Value(
                  s['skippedExerciseCount'] as int? ?? 0,
                ),
                perceivedEffort: Value(s['effort'] as int?),
                painFlag: Value(s['pain'] as bool? ?? false),
                note: Value(s['note'] as String?),
              ),
            );
      }
      for (final h in holds) {
        await db
            .into(db.holdAttempts)
            .insertOnConflictUpdate(
              HoldAttemptsCompanion.insert(
                id: h['id'] as String,
                sessionId: h['sessionId'] as String,
                exerciseId: h['exerciseId'] as String,
                variantId: h['variantId'] as String,
                side: Value(h['side'] as String? ?? 'none'),
                setNumber: Value(h['setNumber'] as int? ?? 1),
                targetMs: h['targetMs'] as int,
                completedMs: h['completedMs'] as int,
                preparationMs: Value(h['preparationMs'] as int? ?? 0),
                restMs: Value(h['restMs'] as int? ?? 0),
                pauseMs: Value(h['pauseMs'] as int? ?? 0),
                result: h['result'] as String,
                perceivedEffort: Value(h['effort'] as int?),
                painFlag: Value(h['pain'] as bool? ?? false),
                startedAt: DateTime.parse(h['startedAt'] as String),
                endedAt: DateTime.parse(h['endedAt'] as String),
              ),
            );
      }
      for (final e in xp) {
        if (e['id'] is! String ||
            e['sourceType'] is! String ||
            e['sourceId'] is! String ||
            e['amount'] is! int) {
          continue;
        }
        await db
            .into(db.xpEvents)
            .insertOnConflictUpdate(
              XpEventsCompanion.insert(
                id: e['id'] as String,
                sourceType: e['sourceType'] as String,
                sourceId: e['sourceId'] as String,
                amount: e['amount'] as int,
                createdAt: Value(_dateOrNull(e['createdAt']) ?? DateTime.now()),
              ),
            );
      }
      final knownAchievements = (await db.select(db.achievements).get())
          .map((a) => a.id)
          .toSet();
      for (final a in achievementRows) {
        final id = a['achievementId'];
        if (id is! String || !knownAchievements.contains(id)) continue;
        await db
            .into(db.achievementProgress)
            .insertOnConflictUpdate(
              AchievementProgressCompanion.insert(
                achievementId: id,
                unlocked: Value(a['unlocked'] as bool? ?? false),
                unlockedAt: Value(_dateOrNull(a['unlockedAt'])),
                sourceSessionId: Value(a['sourceSessionId'] as String?),
              ),
            );
      }
      await _recalcLevel();
    });

    return ImportSummary(
      sessions: sessions.length,
      holdAttempts: holds.length,
      xpEvents: xp.length,
      achievements: achievementRows.length,
    );
  }

  Value<String> _stringValue(Map<String, dynamic> map, String key) =>
      map[key] is String ? Value(map[key] as String) : const Value.absent();

  Value<String?> _nullableStringValue(Map<String, dynamic> map, String key) =>
      map.containsKey(key) ? Value(map[key] as String?) : const Value.absent();

  Value<int> _intValue(Map<String, dynamic> map, String key) =>
      map[key] is int ? Value(map[key] as int) : const Value.absent();

  Value<bool> _boolValue(Map<String, dynamic> map, String key) =>
      map[key] is bool ? Value(map[key] as bool) : const Value.absent();

  DateTime? _dateOrNull(Object? value) =>
      value is String ? DateTime.tryParse(value) : null;
}
