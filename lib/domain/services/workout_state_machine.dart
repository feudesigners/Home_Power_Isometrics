import '../../core/time/app_clock.dart';
import '../entities/enums.dart';

/// Deadline-based workout timer. UI repaint interval is never the source of truth.
class WorkoutStateMachine {
  WorkoutStateMachine(this._clock);

  final AppClock _clock;

  WorkoutPhase phase = WorkoutPhase.idle;
  WorkoutPhase? _phaseBeforePause;
  WorkoutPhase? get phaseBeforePause => _phaseBeforePause;

  DateTime? phaseStartedAt;
  DateTime? deadlineAt;
  Duration remainingWhenPaused = Duration.zero;
  Duration pausedAccumulated = Duration.zero;
  DateTime? pauseStartedAt;

  int currentItemIndex = 0;
  int currentSet = 1;
  HoldSide currentSide = HoldSide.none;
  bool _completionFired = false;
  bool get completionFired => _completionFired;

  /// Planned items: each maps one hold item in the workout.
  List<WorkoutPlanItem> items = const [];

  void loadPlan(List<WorkoutPlanItem> plan) {
    items = List.unmodifiable(plan);
    reset();
  }

  void reset() {
    phase = WorkoutPhase.idle;
    _phaseBeforePause = null;
    phaseStartedAt = null;
    deadlineAt = null;
    remainingWhenPaused = Duration.zero;
    pausedAccumulated = Duration.zero;
    pauseStartedAt = null;
    currentItemIndex = 0;
    currentSet = 1;
    currentSide = HoldSide.none;
    _completionFired = false;
  }

  WorkoutPlanItem? get currentItem =>
      currentItemIndex >= 0 && currentItemIndex < items.length
      ? items[currentItemIndex]
      : null;

  Duration remaining(DateTime? at) {
    final now = at ?? _clock.now();
    if (phase == WorkoutPhase.paused ||
        phase == WorkoutPhase.interrupted) {
      return remainingWhenPaused;
    }
    if (deadlineAt == null) return Duration.zero;
    final left = deadlineAt!.difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  double progressFraction(DateTime? at) {
    final item = currentItem;
    if (item == null) return 0;
    final effectivePhase =
        phase == WorkoutPhase.paused || phase == WorkoutPhase.interrupted
        ? (_phaseBeforePause ?? phase)
        : phase;
    final total = _durationForPhase(effectivePhase, item);
    if (total.inMilliseconds <= 0) return 1;
    final rem = remaining(at);
    final done = total - rem;
    return (done.inMilliseconds / total.inMilliseconds)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  void start() {
    if (items.isEmpty) return;
    _completionFired = false;
    currentItemIndex = 0;
    currentSet = 1;
    currentSide = _initialSide(items.first);
    _enterPhase(WorkoutPhase.preparing, items.first.setupDuration);
  }

  /// Tick evaluation — call from UI timer; advances phases from deadlines.
  WorkoutTickResult evaluate() {
    final now = _clock.now();
    if (phase == WorkoutPhase.paused ||
        phase == WorkoutPhase.idle ||
        phase == WorkoutPhase.completed ||
        phase == WorkoutPhase.stopped ||
        phase == WorkoutPhase.interrupted) {
      return WorkoutTickResult(phase: phase, remaining: remaining(now));
    }

    if (deadlineAt != null && !now.isBefore(deadlineAt!)) {
      return _advanceFromDeadline();
    }
    return WorkoutTickResult(phase: phase, remaining: remaining(now));
  }

  WorkoutTickResult _advanceFromDeadline() {
    final item = currentItem;
    if (item == null) {
      return _completeOnce();
    }

    switch (phase) {
      case WorkoutPhase.preparing:
        _enterPhase(WorkoutPhase.holding, item.holdDuration);
        return WorkoutTickResult(
          phase: phase,
          remaining: remaining(_clock.now()),
          phaseCompleted: WorkoutPhase.preparing,
        );
      case WorkoutPhase.holding:
        return _onHoldFinished(item);
      case WorkoutPhase.switchingSide:
        _enterPhase(WorkoutPhase.holding, item.holdDuration);
        return WorkoutTickResult(
          phase: phase,
          remaining: remaining(_clock.now()),
          phaseCompleted: WorkoutPhase.switchingSide,
        );
      case WorkoutPhase.resting:
        return _moveToNextItem();
      default:
        return WorkoutTickResult(
          phase: phase,
          remaining: remaining(_clock.now()),
        );
    }
  }

  WorkoutTickResult _onHoldFinished(WorkoutPlanItem item) {
    final finishedSide = currentSide;
    if (item.unilateralMode != UnilateralMode.none &&
        currentSide == HoldSide.left) {
      currentSide = HoldSide.right;
      _enterPhase(WorkoutPhase.switchingSide, item.sideSwitchDuration);
      return WorkoutTickResult(
        phase: phase,
        remaining: remaining(_clock.now()),
        phaseCompleted: WorkoutPhase.holding,
        holdCompletedSide: finishedSide,
        holdCompletedFully: true,
      );
    }

    if (currentSet < item.sets) {
      _enterPhase(WorkoutPhase.resting, item.restDuration);
      return WorkoutTickResult(
        phase: phase,
        remaining: remaining(_clock.now()),
        phaseCompleted: WorkoutPhase.holding,
        holdCompletedSide: finishedSide,
        holdCompletedFully: true,
      );
    }

    // Exercise complete → rest then next, or finish.
    if (currentItemIndex + 1 >= items.length) {
      return _completeOnce(
        holdCompletedSide: finishedSide,
        holdCompletedFully: true,
      );
    }

    _enterPhase(WorkoutPhase.resting, item.restDuration);
    return WorkoutTickResult(
      phase: phase,
      remaining: remaining(_clock.now()),
      phaseCompleted: WorkoutPhase.holding,
      holdCompletedSide: finishedSide,
      holdCompletedFully: true,
    );
  }

  WorkoutTickResult _moveToNextItem() {
    final item = currentItem;
    if (item != null && currentSet < item.sets) {
      currentSet += 1;
      currentSide = _initialSide(item);
      _enterPhase(WorkoutPhase.preparing, item.setupDuration);
      return WorkoutTickResult(
        phase: phase,
        remaining: remaining(_clock.now()),
        phaseCompleted: WorkoutPhase.resting,
      );
    }

    if (currentItemIndex + 1 >= items.length) {
      return _completeOnce();
    }
    currentItemIndex += 1;
    currentSet = 1;
    final next = items[currentItemIndex];
    currentSide = _initialSide(next);
    _enterPhase(WorkoutPhase.preparing, next.setupDuration);
    return WorkoutTickResult(
      phase: phase,
      remaining: remaining(_clock.now()),
      phaseCompleted: WorkoutPhase.resting,
    );
  }

  WorkoutTickResult _completeOnce({
    HoldSide? holdCompletedSide,
    bool holdCompletedFully = false,
  }) {
    if (_completionFired) {
      phase = WorkoutPhase.completed;
      return WorkoutTickResult(
        phase: phase,
        remaining: Duration.zero,
        holdCompletedSide: holdCompletedSide,
        holdCompletedFully: holdCompletedFully,
      );
    }
    _completionFired = true;
    phase = WorkoutPhase.completed;
    deadlineAt = null;
    phaseStartedAt = _clock.now();
    return WorkoutTickResult(
      phase: phase,
      remaining: Duration.zero,
      phaseCompleted: WorkoutPhase.holding,
      sessionCompleted: true,
      holdCompletedSide: holdCompletedSide,
      holdCompletedFully: holdCompletedFully,
    );
  }

  void pause() {
    if (phase == WorkoutPhase.paused ||
        phase == WorkoutPhase.idle ||
        phase == WorkoutPhase.completed ||
        phase == WorkoutPhase.stopped) {
      return;
    }
    remainingWhenPaused = remaining(_clock.now());
    _phaseBeforePause = phase;
    pauseStartedAt = _clock.now();
    phase = WorkoutPhase.paused;
    deadlineAt = null;
  }

  /// Resume after explicit user confirmation (required after backgrounding).
  void resume() {
    if (phase != WorkoutPhase.paused &&
        phase != WorkoutPhase.interrupted) {
      return;
    }
    final restore = _phaseBeforePause ?? WorkoutPhase.holding;
    if (pauseStartedAt != null) {
      pausedAccumulated += _clock.now().difference(pauseStartedAt!);
    }
    pauseStartedAt = null;
    phase = restore;
    phaseStartedAt = _clock.now();
    deadlineAt = phaseStartedAt!.add(remainingWhenPaused);
  }

  void replaceCurrentItem(WorkoutPlanItem replacement) {
    if (currentItem == null) return;
    final mutable = items.toList();
    mutable[currentItemIndex] = replacement;
    items = List.unmodifiable(mutable);
    currentSide = _initialSide(replacement);
    _enterPhase(WorkoutPhase.preparing, replacement.setupDuration);
  }

  bool skipCurrent() {
    final item = currentItem;
    if (item == null) return false;
    if (currentItemIndex + 1 >= items.length) {
      _completeOnce();
      return true;
    }
    currentItemIndex += 1;
    currentSet = 1;
    final next = items[currentItemIndex];
    currentSide = _initialSide(next);
    _enterPhase(WorkoutPhase.preparing, next.setupDuration);
    return false;
  }

  void stop() {
    phase = WorkoutPhase.stopped;
    deadlineAt = null;
  }

  void markInterrupted() {
    if (phase == WorkoutPhase.completed || phase == WorkoutPhase.stopped) {
      return;
    }
    if (phase == WorkoutPhase.interrupted) return;
    if (phase != WorkoutPhase.paused) {
      pause();
    }
    phase = WorkoutPhase.interrupted;
  }

  /// Rebuild remaining time after process death using persisted timestamps.
  void restoreFromSnapshot({
    required WorkoutPhase restoredPhase,
    required WorkoutPhase? phaseBeforePause,
    required DateTime? phaseStartedAt,
    required DateTime? deadlineAt,
    required Duration remainingWhenPaused,
    required Duration pausedAccumulated,
    required DateTime? pauseStartedAt,
    required int currentItemIndex,
    required int currentSet,
    required HoldSide currentSide,
    required bool completionFired,
  }) {
    phase = restoredPhase;
    _phaseBeforePause = phaseBeforePause;
    this.phaseStartedAt = phaseStartedAt;
    this.deadlineAt = deadlineAt;
    this.remainingWhenPaused = remainingWhenPaused;
    this.pausedAccumulated = pausedAccumulated;
    this.pauseStartedAt = pauseStartedAt;
    this.currentItemIndex = currentItemIndex;
    this.currentSet = currentSet;
    this.currentSide = currentSide;
    _completionFired = completionFired;

    // If we restored an active phase, recompute remaining from deadline.
    if (phase != WorkoutPhase.paused &&
        phase != WorkoutPhase.interrupted &&
        deadlineAt != null) {
      final rem = deadlineAt.difference(_clock.now());
      if (rem.isNegative) {
        // Deadline passed while dead — evaluate will advance on next tick.
        this.deadlineAt = _clock.now();
      }
    }
  }

  void _enterPhase(WorkoutPhase next, Duration duration) {
    phase = next;
    phaseStartedAt = _clock.now();
    deadlineAt = phaseStartedAt!.add(duration);
    remainingWhenPaused = duration;
  }

  HoldSide _initialSide(WorkoutPlanItem item) {
    switch (item.unilateralMode) {
      case UnilateralMode.none:
        return HoldSide.none;
      case UnilateralMode.leftRight:
      case UnilateralMode.alternating:
        return HoldSide.left;
    }
  }

  Duration _durationForPhase(WorkoutPhase p, WorkoutPlanItem item) {
    switch (p) {
      case WorkoutPhase.preparing:
        return item.setupDuration;
      case WorkoutPhase.holding:
        return item.holdDuration;
      case WorkoutPhase.resting:
        return item.restDuration;
      case WorkoutPhase.switchingSide:
        return item.sideSwitchDuration;
      default:
        return Duration.zero;
    }
  }
}

class WorkoutPlanItem {
  const WorkoutPlanItem({
    required this.variantId,
    required this.exerciseId,
    required this.displayName,
    required this.holdDuration,
    required this.setupDuration,
    required this.restDuration,
    this.sideSwitchDuration = const Duration(seconds: 5),
    this.sets = 1,
    this.unilateralMode = UnilateralMode.none,
    this.formCues = const [],
    this.breathingCue = '',
    this.kind = WorkoutItemKind.hold,
    this.staticAssetPath,
    this.animatedAssetPath,
    this.mediaAccessibilityLabel,
    this.animatedMediaAccessibilityLabel,
    this.easierVariantId,
    this.harderVariantId,
  });

  final String variantId;
  final String exerciseId;
  final String displayName;
  final Duration holdDuration;
  final Duration setupDuration;
  final Duration restDuration;
  final Duration sideSwitchDuration;
  final int sets;
  final UnilateralMode unilateralMode;
  final List<String> formCues;
  final String breathingCue;
  final WorkoutItemKind kind;
  final String? staticAssetPath;
  final String? animatedAssetPath;
  final String? mediaAccessibilityLabel;
  final String? animatedMediaAccessibilityLabel;
  final String? easierVariantId;
  final String? harderVariantId;

  bool get isHold => kind == WorkoutItemKind.hold;
  int get sideCount =>
      unilateralMode == UnilateralMode.none ? 1 : 2;
}

enum WorkoutItemKind { hold, warmup, cooldown }

int plannedWorkoutDurationMs(List<WorkoutPlanItem> items) {
  var total = 0;
  for (var index = 0; index < items.length; index++) {
    final item = items[index];
    if (!item.isHold) {
      total += item.holdDuration.inMilliseconds;
      continue;
    }
    final perSet =
        item.setupDuration.inMilliseconds +
        item.holdDuration.inMilliseconds * item.sideCount +
        (item.sideCount > 1 ? item.sideSwitchDuration.inMilliseconds : 0);
    total += perSet * item.sets;
    final restCount =
        (item.sets - 1) + (index < items.length - 1 ? 1 : 0);
    total += item.restDuration.inMilliseconds * restCount;
  }
  return total;
}

class WorkoutTickResult {
  const WorkoutTickResult({
    required this.phase,
    required this.remaining,
    this.phaseCompleted,
    this.sessionCompleted = false,
    this.holdCompletedSide,
    this.holdCompletedFully = false,
  });

  final WorkoutPhase phase;
  final Duration remaining;
  final WorkoutPhase? phaseCompleted;
  final bool sessionCompleted;
  final HoldSide? holdCompletedSide;
  final bool holdCompletedFully;
}
