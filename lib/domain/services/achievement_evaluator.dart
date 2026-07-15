class AchievementDefinition {
  const AchievementDefinition({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}

class AchievementContext {
  const AchievementContext({
    required this.totalCompletedSessions,
    required this.totalHoldAttempts,
    required this.totalControlledHoldMs,
    required this.sessionsThisWeek,
    required this.categoriesThisWeek,
    required this.hadProgression,
    required this.daysSinceLastSession,
    required this.alreadyUnlocked,
  });

  final int totalCompletedSessions;
  final int totalHoldAttempts;
  final int totalControlledHoldMs;
  final int sessionsThisWeek;
  final Set<String> categoriesThisWeek;
  final bool hadProgression;
  final int? daysSinceLastSession;
  final Set<String> alreadyUnlocked;
}

class AchievementEvaluator {
  const AchievementEvaluator();

  static const definitions = <AchievementDefinition>[
    AchievementDefinition(
      id: 'first_hold',
      name: 'First Hold',
      description: 'Complete your first timed hold.',
    ),
    AchievementDefinition(
      id: 'first_complete_workout',
      name: 'First Complete Workout',
      description: 'Finish a full multi-exercise session.',
    ),
    AchievementDefinition(
      id: 'foundation_week',
      name: 'Foundation Week',
      description: 'Complete your weekly foundation target.',
    ),
    AchievementDefinition(
      id: 'core_control',
      name: 'Core Control',
      description: 'Complete a Core Control program session.',
    ),
    AchievementDefinition(
      id: 'lower_body_stability',
      name: 'Lower Body Stability',
      description: 'Complete a Lower Body Stability session.',
    ),
    AchievementDefinition(
      id: 'balanced_week',
      name: 'Balanced Week',
      description: 'Train all three categories in one week.',
    ),
    AchievementDefinition(
      id: 'ten_workouts',
      name: 'Ten Workouts',
      description: 'Complete ten full sessions.',
    ),
    AchievementDefinition(
      id: 'one_hour_holds',
      name: 'One Hour of Controlled Holds',
      description: 'Accumulate one hour of controlled hold time.',
    ),
    AchievementDefinition(
      id: 'first_progression',
      name: 'First Progression',
      description: 'Accept a suitable progression suggestion.',
    ),
    AchievementDefinition(
      id: 'welcome_back',
      name: 'Welcome Back',
      description: 'Return after a break of seven or more days.',
    ),
  ];

  /// Idempotent unlock list for the given context.
  List<String> evaluate(AchievementContext ctx) {
    final newly = <String>[];

    void unlock(String id) {
      if (!ctx.alreadyUnlocked.contains(id) && !newly.contains(id)) {
        newly.add(id);
      }
    }

    if (ctx.totalHoldAttempts >= 1) unlock('first_hold');
    // Corrected Starter Kit behaviour: full workout session required.
    if (ctx.totalCompletedSessions >= 1) unlock('first_complete_workout');
    if (ctx.sessionsThisWeek >= 3) unlock('foundation_week');
    if (ctx.categoriesThisWeek.length >= 3) unlock('balanced_week');
    if (ctx.totalCompletedSessions >= 10) unlock('ten_workouts');
    if (ctx.totalControlledHoldMs >= 3600 * 1000) unlock('one_hour_holds');
    if (ctx.hadProgression) unlock('first_progression');
    if (ctx.daysSinceLastSession != null && ctx.daysSinceLastSession! >= 7) {
      unlock('welcome_back');
    }
    return newly;
  }
}
