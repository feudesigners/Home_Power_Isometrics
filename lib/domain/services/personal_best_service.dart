import '../entities/enums.dart';

class PersonalBestCandidate {
  const PersonalBestCandidate({
    required this.variantId,
    required this.side,
    required this.completedMs,
    required this.result,
  });

  final String variantId;
  final HoldSide side;
  final int completedMs;
  final HoldResult result;
}

class PersonalBestRecord {
  const PersonalBestRecord({
    required this.variantId,
    required this.side,
    required this.bestMs,
  });

  final String variantId;
  final HoldSide side;
  final int bestMs;
}

class PersonalBestService {
  const PersonalBestService();

  /// Partial holds never become personal bests.
  PersonalBestRecord? consider({
    required PersonalBestCandidate attempt,
    required int? existingBestMs,
  }) {
    if (attempt.result != HoldResult.completed) return null;
    if (attempt.completedMs <= 0) return null;
    if (existingBestMs != null && attempt.completedMs <= existingBestMs) {
      return null;
    }
    return PersonalBestRecord(
      variantId: attempt.variantId,
      side: attempt.side,
      bestMs: attempt.completedMs,
    );
  }
}
