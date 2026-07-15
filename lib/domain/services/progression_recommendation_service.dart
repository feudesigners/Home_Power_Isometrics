import '../entities/enums.dart';

class ProgressionInput {
  const ProgressionInput({
    required this.variantId,
    required this.easierVariantId,
    required this.harderVariantId,
    required this.targetMs,
    required this.completedMs,
    required this.perceivedEffort,
    required this.painReported,
    required this.formMaintained,
    required this.result,
    required this.recentSuccessfulCompletions,
    required this.limitationTags,
    required this.variantLimitationTags,
  });

  final String variantId;
  final String? easierVariantId;
  final String? harderVariantId;
  final int targetMs;
  final int completedMs;
  final int perceivedEffort; // 1-10
  final bool painReported;
  final bool formMaintained;
  final HoldResult result;
  final int recentSuccessfulCompletions;
  final List<String> limitationTags;
  final List<String> variantLimitationTags;
}

enum ProgressionAction { maintain, increaseTime, suggestHarder, regress }

class ProgressionRecommendation {
  const ProgressionRecommendation({
    required this.action,
    required this.explanation,
    this.suggestedHoldMs,
    this.suggestedVariantId,
  });

  final ProgressionAction action;
  final String explanation;
  final int? suggestedHoldMs;
  final String? suggestedVariantId;
}

/// Deterministic progression rules — unit tested, inspectable.
class ProgressionRecommendationService {
  const ProgressionRecommendationService();

  ProgressionRecommendation recommend(ProgressionInput input) {
    final blockedByLimitation = input.limitationTags.any(
      (t) => input.variantLimitationTags.contains(t),
    );

    if (input.painReported) {
      return ProgressionRecommendation(
        action: input.easierVariantId != null
            ? ProgressionAction.regress
            : ProgressionAction.maintain,
        explanation: input.easierVariantId != null
            ? 'Discomfort was reported. Use the supported variation next session.'
            : 'Discomfort was reported. Keep this level and prioritise control.',
        suggestedVariantId: input.easierVariantId,
      );
    }

    if (input.result == HoldResult.partial ||
        input.result == HoldResult.stopped ||
        !input.formMaintained ||
        input.perceivedEffort >= 9) {
      return ProgressionRecommendation(
        action: input.easierVariantId != null && input.perceivedEffort >= 9
            ? ProgressionAction.regress
            : ProgressionAction.maintain,
        explanation: input.perceivedEffort >= 9
            ? 'Effort was very high. Keep this level while you build control.'
            : 'Keep this level while you build control.',
        suggestedVariantId: input.perceivedEffort >= 9
            ? input.easierVariantId
            : null,
      );
    }

    if (blockedByLimitation) {
      return const ProgressionRecommendation(
        action: ProgressionAction.maintain,
        explanation: 'Keep this variation to respect your selected care areas.',
      );
    }

    final completedFully =
        input.completedMs >= input.targetMs &&
        input.result == HoldResult.completed;

    if (completedFully &&
        input.recentSuccessfulCompletions >= 2 &&
        input.perceivedEffort <= 7) {
      // Change only one variable: prefer small time bump before harder variant.
      final bumpMs = _timeBump(input.targetMs);
      final nextTime = input.targetMs + bumpMs;
      // Cap foundation band bumps before suggesting harder leverage.
      if (input.targetMs < 25000 && nextTime <= 30000) {
        return ProgressionRecommendation(
          action: ProgressionAction.increaseTime,
          explanation:
              'You completed this comfortably twice. Try ${_seconds(bumpMs)} more seconds next time.',
          suggestedHoldMs: nextTime,
        );
      }
      if (input.harderVariantId != null) {
        return ProgressionRecommendation(
          action: ProgressionAction.suggestHarder,
          explanation:
              'You completed this comfortably twice. A tougher variation is available when you are ready.',
          suggestedVariantId: input.harderVariantId,
        );
      }
      return ProgressionRecommendation(
        action: ProgressionAction.increaseTime,
        explanation:
            'You completed this comfortably twice. Try ${_seconds(bumpMs)} more seconds next time.',
        suggestedHoldMs: nextTime,
      );
    }

    return const ProgressionRecommendation(
      action: ProgressionAction.maintain,
      explanation: 'Keep this level while you build control.',
    );
  }

  int _timeBump(int targetMs) {
    if (targetMs < 15000) return 5000;
    if (targetMs < 30000) return 5000;
    return 5000;
  }

  String _seconds(int ms) => '${(ms / 1000).round()}';
}
