/// Idempotent XP awards keyed by durable event IDs.
class XpService {
  const XpService();

  static const sessionCompleteBase = 50;
  static const feedbackBonus = 10;
  static const weeklyGoalBonus = 40;
  static const progressionAttemptBonus = 15;
  static const balancedWeekBonus = 30;
  static const welcomeBackBonus = 20;

  /// Returns XP granted this call (0 if duplicate).
  int award({
    required Set<String> existingEventIds,
    required String eventId,
    required int amount,
    required bool painReported,
  }) {
    if (painReported) return 0;
    if (amount <= 0) return 0;
    if (existingEventIds.contains(eventId)) return 0;
    return amount;
  }

  int levelForXp(int totalXp) {
    // Soft curve: every 200 XP ≈ one level after level 1.
    if (totalXp < 0) return 1;
    return 1 + (totalXp ~/ 200);
  }

  int xpIntoLevel(int totalXp) => totalXp % 200;

  int xpRequiredForNextLevel() => 200;
}
