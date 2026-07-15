enum UnilateralMode { none, leftRight, alternating }

enum SessionStatus {
  planned,
  active,
  paused,
  completed,
  abandoned,
  interrupted,
}

enum HoldResult { completed, partial, skipped, stopped }

enum HoldSide { none, left, right }

enum WorkoutPhase {
  idle,
  preparing,
  holding,
  resting,
  switchingSide,
  paused,
  completed,
  stopped,
  interrupted,
}

enum ThemePreference { system, light, dark }

enum StartingLevel { foundation, control, endurance }

UnilateralMode unilateralModeFromString(String value) {
  return UnilateralMode.values.firstWhere(
    (e) => e.name == value,
    orElse: () => UnilateralMode.none,
  );
}

SessionStatus sessionStatusFromString(String value) {
  return SessionStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => SessionStatus.planned,
  );
}

HoldResult holdResultFromString(String value) {
  return HoldResult.values.firstWhere(
    (e) => e.name == value,
    orElse: () => HoldResult.partial,
  );
}

HoldSide holdSideFromString(String value) {
  return HoldSide.values.firstWhere(
    (e) => e.name == value,
    orElse: () => HoldSide.none,
  );
}
