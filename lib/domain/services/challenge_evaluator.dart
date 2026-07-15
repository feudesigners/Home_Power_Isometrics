class ChallengeDefinition {
  const ChallengeDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.targetCount,
  });

  final String id;
  final String name;
  final String description;
  final int targetCount;
}

class ChallengeProgressSnapshot {
  const ChallengeProgressSnapshot({
    required this.challengeId,
    required this.currentCount,
    required this.completed,
  });

  final String challengeId;
  final int currentCount;
  final bool completed;
}

class ChallengeEvaluator {
  const ChallengeEvaluator();

  static const definitions = <ChallengeDefinition>[
    ChallengeDefinition(
      id: 'first_workout',
      name: 'First Workout',
      description: 'Complete your first guided session.',
      targetCount: 1,
    ),
    ChallengeDefinition(
      id: 'three_sessions_week',
      name: 'Three Sessions in One Week',
      description: 'Train three times in a rolling seven-day window.',
      targetCount: 3,
    ),
    ChallengeDefinition(
      id: 'balanced_week',
      name: 'Balanced Week',
      description: 'Cover lower body, core, and upper/posterior work.',
      targetCount: 3,
    ),
    ChallengeDefinition(
      id: 'seven_day_starter',
      name: 'Seven-Day Starter Quest',
      description:
          'Complete sessions across seven calendar days with grace days allowed.',
      targetCount: 5,
    ),
    ChallengeDefinition(
      id: 'twenty_one_day_consistency',
      name: 'Twenty-One Day Consistency',
      description: 'Stay active across a three-week habit window.',
      targetCount: 12,
    ),
    ChallengeDefinition(
      id: 'progression_milestones',
      name: 'Exercise Progression',
      description: 'Accept three suitable progressions.',
      targetCount: 3,
    ),
    ChallengeDefinition(
      id: 'recovery_mobility',
      name: 'Recovery and Mobility',
      description: 'Complete warm-up and cooldown blocks.',
      targetCount: 3,
    ),
  ];

  ChallengeProgressSnapshot apply({
    required ChallengeDefinition def,
    required int previousCount,
    required bool alreadyCompleted,
    required int increment,
  }) {
    if (alreadyCompleted) {
      return ChallengeProgressSnapshot(
        challengeId: def.id,
        currentCount: previousCount,
        completed: true,
      );
    }
    final next = previousCount + increment;
    return ChallengeProgressSnapshot(
      challengeId: def.id,
      currentCount: next,
      completed: next >= def.targetCount,
    );
  }
}
