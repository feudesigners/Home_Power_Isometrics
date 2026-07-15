import 'package:flutter_test/flutter_test.dart';
import 'package:isometrix/domain/entities/enums.dart';
import 'package:isometrix/domain/services/progression_recommendation_service.dart';
import 'package:isometrix/domain/services/xp_service.dart';
import 'package:isometrix/domain/services/personal_best_service.dart';
import 'package:isometrix/domain/services/achievement_evaluator.dart';
import 'package:isometrix/domain/services/export_import_service.dart';

void main() {
  group('ProgressionRecommendationService', () {
    const svc = ProgressionRecommendationService();

    test('comfortable repeats recommend time increase', () {
      final r = svc.recommend(
        const ProgressionInput(
          variantId: 'a',
          easierVariantId: 'e',
          harderVariantId: 'h',
          targetMs: 15000,
          completedMs: 15000,
          perceivedEffort: 6,
          painReported: false,
          formMaintained: true,
          result: HoldResult.completed,
          recentSuccessfulCompletions: 2,
          limitationTags: [],
          variantLimitationTags: [],
        ),
      );
      expect(r.action, ProgressionAction.increaseTime);
      expect(r.suggestedHoldMs, 20000);
    });

    test('pain prevents progression and may regress', () {
      final r = svc.recommend(
        const ProgressionInput(
          variantId: 'a',
          easierVariantId: 'e',
          harderVariantId: 'h',
          targetMs: 15000,
          completedMs: 15000,
          perceivedEffort: 5,
          painReported: true,
          formMaintained: true,
          result: HoldResult.completed,
          recentSuccessfulCompletions: 5,
          limitationTags: [],
          variantLimitationTags: [],
        ),
      );
      expect(r.action, ProgressionAction.regress);
      expect(r.suggestedVariantId, 'e');
    });

    test('partial or high effort maintains', () {
      final r = svc.recommend(
        const ProgressionInput(
          variantId: 'a',
          easierVariantId: null,
          harderVariantId: 'h',
          targetMs: 15000,
          completedMs: 8000,
          perceivedEffort: 9,
          painReported: false,
          formMaintained: false,
          result: HoldResult.partial,
          recentSuccessfulCompletions: 2,
          limitationTags: [],
          variantLimitationTags: [],
        ),
      );
      expect(r.action, ProgressionAction.maintain);
    });
  });

  group('XpService', () {
    const xp = XpService();
    test('idempotent awards', () {
      final ids = <String>{};
      final first = xp.award(
        existingEventIds: ids,
        eventId: 'xp_session_1',
        amount: 50,
        painReported: false,
      );
      ids.add('xp_session_1');
      final second = xp.award(
        existingEventIds: ids,
        eventId: 'xp_session_1',
        amount: 50,
        painReported: false,
      );
      expect(first, 50);
      expect(second, 0);
    });

    test('pain grants zero XP', () {
      final granted = xp.award(
        existingEventIds: {},
        eventId: 'xp_session_2',
        amount: 50,
        painReported: true,
      );
      expect(granted, 0);
    });
  });

  group('PersonalBestService', () {
    const pb = PersonalBestService();
    test('partial never becomes PB', () {
      final r = pb.consider(
        attempt: const PersonalBestCandidate(
          variantId: 'a',
          side: HoldSide.none,
          completedMs: 99999,
          result: HoldResult.partial,
        ),
        existingBestMs: null,
      );
      expect(r, isNull);
    });

    test('completed updates when higher', () {
      final r = pb.consider(
        attempt: const PersonalBestCandidate(
          variantId: 'a',
          side: HoldSide.left,
          completedMs: 20000,
          result: HoldResult.completed,
        ),
        existingBestMs: 15000,
      );
      expect(r?.bestMs, 20000);
    });
  });

  group('AchievementEvaluator', () {
    const eval = AchievementEvaluator();
    test('first complete workout requires a session not a single hold', () {
      final withHoldOnly = eval.evaluate(
        const AchievementContext(
          totalCompletedSessions: 0,
          totalHoldAttempts: 3,
          totalControlledHoldMs: 30000,
          sessionsThisWeek: 0,
          categoriesThisWeek: {},
          hadProgression: false,
          daysSinceLastSession: null,
          alreadyUnlocked: {},
        ),
      );
      expect(withHoldOnly, contains('first_hold'));
      expect(withHoldOnly, isNot(contains('first_complete_workout')));

      final withSession = eval.evaluate(
        const AchievementContext(
          totalCompletedSessions: 1,
          totalHoldAttempts: 3,
          totalControlledHoldMs: 30000,
          sessionsThisWeek: 1,
          categoriesThisWeek: {'C001'},
          hadProgression: false,
          daysSinceLastSession: null,
          alreadyUnlocked: {'first_hold'},
        ),
      );
      expect(withSession, contains('first_complete_workout'));
    });

    test('idempotent unlocks', () {
      final again = eval.evaluate(
        const AchievementContext(
          totalCompletedSessions: 1,
          totalHoldAttempts: 3,
          totalControlledHoldMs: 30000,
          sessionsThisWeek: 1,
          categoriesThisWeek: {},
          hadProgression: false,
          daysSinceLastSession: null,
          alreadyUnlocked: {'first_hold', 'first_complete_workout'},
        ),
      );
      expect(again, isEmpty);
    });
  });

  group('ExportImportService', () {
    final svc = ExportImportService();
    test('validates schema', () {
      expect(
        () => svc.parseAndValidate('{"schemaVersion":1,"sessions":[]}'),
        returnsNormally,
      );
      expect(
        () => svc.parseAndValidate('{"sessions":[]}'),
        throwsA(isA<Exception>()),
      );
    });

    test('CSV escapes commas and quotes', () {
      final csv = svc.toCsvHistory([
        {
          'id': 'session, "one"',
          'startedAt': '2026-01-01T12:00:00Z',
          'completedAt': null,
          'status': 'completed',
          'effort': 7,
          'pain': false,
        },
      ]);
      expect(csv, contains('"session, ""one"""'));
    });
  });
}
