import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../domain/entities/enums.dart';
import '../../domain/services/workout_state_machine.dart';
import '../../domain/services/session_recovery_service.dart';
import '../../app/bootstrap/providers.dart';

class WorkoutController extends ChangeNotifier {
  WorkoutController(this._ref) {
    _machine = WorkoutStateMachine(_ref.read(appClockProvider));
  }

  final Ref _ref;
  late final WorkoutStateMachine _machine;
  Timer? _uiTimer;
  String? sessionId;
  String? templateId;
  String? programId;
  bool painDuringSession = false;
  int completedHolds = 0;
  int skippedHolds = 0;
  DateTime? sessionStartedAt;
  Duration lastRemaining = Duration.zero;
  bool awaitingResumeConfirm = false;
  static const _recovery = SessionRecoveryService();
  int? _lastCountdownCue;
  bool _tickInFlight = false;
  bool _sessionFinalized = false;
  DateTime? _holdStartedAt;

  WorkoutStateMachine get machine => _machine;
  WorkoutPhase get phase => _machine.phase;

  Future<void> startFromTemplate(
    String tplId, {
    String? progId,
    Map<String, String> variantOverrides = const {},
  }) async {
    final repos = _ref.read(repositoriesProvider);
    final plan = await repos.planFromTemplate(tplId);
    for (var index = 0; index < plan.length; index++) {
      final replacementId = variantOverrides[plan[index].variantId];
      if (replacementId == null) continue;
      final replacement = await repos.planForPractice(replacementId);
      if (replacement.isNotEmpty) plan[index] = replacement.single;
    }
    templateId = tplId;
    programId = progId;
    await _begin(plan, tplId);
  }

  Future<void> startPractice(String variantId) async {
    final repos = _ref.read(repositoriesProvider);
    final plan = await repos.planForPractice(variantId);
    templateId = null;
    programId = null;
    await _begin(plan, null);
  }

  Future<void> _begin(List<WorkoutPlanItem> plan, String? tplId) async {
    painDuringSession = false;
    completedHolds = 0;
    skippedHolds = 0;
    _sessionFinalized = false;
    _holdStartedAt = null;
    _machine.loadPlan(plan);
    final plannedMs = plannedWorkoutDurationMs(plan);
    sessionId = await _ref
        .read(repositoriesProvider)
        .startSession(
          templateId: tplId,
          programId: programId,
          plannedDurationMs: plannedMs,
        );
    sessionStartedAt = _ref.read(appClockProvider).now();
    _machine.start();
    lastRemaining = _machine.remaining(null);
    _lastCountdownCue = null;
    await _playPhaseCue(_machine.phase);
    await WakelockPlus.enable();
    _startUiTicker();
    await _persistPhaseBoundary();
    notifyListeners();
  }

  void _startUiTicker() {
    _uiTimer?.cancel();
    _uiTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      _onTick();
    });
  }

  Future<void> _onTick() async {
    if (_tickInFlight) return;
    _tickInFlight = true;
    try {
      final before = _machine.phase;
      final result = _machine.evaluate();
      lastRemaining = result.remaining;
      if (before != WorkoutPhase.holding &&
          result.phase == WorkoutPhase.holding) {
        _holdStartedAt = _ref.read(appClockProvider).now();
      }

      if (_machine.phase == WorkoutPhase.holding) {
        final seconds =
            result.remaining.inSeconds +
            (result.remaining.inMilliseconds.remainder(1000) > 0 ? 1 : 0);
        if (seconds >= 1 && seconds <= 3 && seconds != _lastCountdownCue) {
          _lastCountdownCue = seconds;
          await _playCountdownCue(seconds);
        }
      }

      if (result.holdCompletedFully) {
        final completedItem = _machine.currentItem;
        if (completedItem?.isHold == true) {
          completedHolds += 1;
          await _recordCurrentHold(
            HoldResult.completed,
            full: true,
            side: result.holdCompletedSide,
          );
        }
      }
      if (result.sessionCompleted) {
        await _finalizeSession();
        await WakelockPlus.disable();
        _uiTimer?.cancel();
      }
      if (before != result.phase || result.phaseCompleted != null) {
        _lastCountdownCue = null;
        await _playPhaseCue(result.phase);
        if (!result.sessionCompleted) {
          await _persistPhaseBoundary();
        }
      }
      notifyListeners();
    } finally {
      _tickInFlight = false;
    }
  }

  Future<void> _recordCurrentHold(
    HoldResult result, {
    bool full = false,
    HoldSide? side,
  }) async {
    final item = _machine.currentItem;
    final sid = sessionId;
    if (item == null || sid == null || !item.isHold) return;
    final target = item.holdDuration.inMilliseconds;
    final completed = full
        ? target
        : (target - lastRemaining.inMilliseconds).clamp(0, target).toInt();
    await _ref
        .read(repositoriesProvider)
        .recordHoldAttempt(
          sessionId: sid,
          exerciseId: item.exerciseId,
          variantId: item.variantId,
          side: side ?? _machine.currentSide,
          setNumber: _machine.currentSet,
          targetMs: target,
          completedMs: completed,
          preparationMs: item.setupDuration.inMilliseconds,
          restMs: item.restDuration.inMilliseconds,
          pauseMs: _machine.pausedAccumulated.inMilliseconds,
          result: result,
          painFlag: painDuringSession,
          startedAt: _holdStartedAt,
        );
  }

  Map<String, dynamic> snapshot() => {
    'sessionId': sessionId,
    'templateId': templateId,
    'programId': programId,
    'sessionStartedAt': sessionStartedAt?.toIso8601String(),
    'holdStartedAt': _holdStartedAt?.toIso8601String(),
    'phase': _machine.phase.name,
    'phaseBeforePause': _machine.phaseBeforePause?.name,
    'phaseStartedAt': _machine.phaseStartedAt?.toIso8601String(),
    'deadlineAt': _machine.deadlineAt?.toIso8601String(),
    'remainingWhenPausedMs': _machine.remainingWhenPaused.inMilliseconds,
    'pausedAccumulatedMs': _machine.pausedAccumulated.inMilliseconds,
    'currentItemIndex': _machine.currentItemIndex,
    'currentSet': _machine.currentSet,
    'currentSide': _machine.currentSide.name,
    'completionFired': _machine.completionFired,
    'completedHolds': completedHolds,
    'skippedHolds': skippedHolds,
    'painDuringSession': painDuringSession,
    'items': _machine.items
        .map(
          (i) => {
            'variantId': i.variantId,
            'exerciseId': i.exerciseId,
            'displayName': i.displayName,
            'holdMs': i.holdDuration.inMilliseconds,
            'setupMs': i.setupDuration.inMilliseconds,
            'restMs': i.restDuration.inMilliseconds,
            'sideSwitchMs': i.sideSwitchDuration.inMilliseconds,
            'sets': i.sets,
            'unilateralMode': i.unilateralMode.name,
            'formCues': i.formCues,
            'breathingCue': i.breathingCue,
            'kind': i.kind.name,
            'staticAssetPath': i.staticAssetPath,
            'animatedAssetPath': i.animatedAssetPath,
            'mediaAccessibilityLabel': i.mediaAccessibilityLabel,
            'animatedMediaAccessibilityLabel':
                i.animatedMediaAccessibilityLabel,
            'easierVariantId': i.easierVariantId,
            'harderVariantId': i.harderVariantId,
          },
        )
        .toList(),
  };

  Future<void> _persistPhaseBoundary({bool paused = false}) async {
    final sid = sessionId;
    if (sid == null || _sessionFinalized) return;
    final repositories = _ref.read(repositoriesProvider);
    if (paused) {
      await repositories.markSessionPaused(sid, snapshot());
    } else {
      await repositories.markSessionActive(sid, snapshot());
    }
  }

  Future<void> _playPhaseCue(WorkoutPhase phase) async {
    final prefs = await _ref.read(repositoriesProvider).preferences();
    if (prefs.audioEnabled) {
      await _ref.read(workoutCueServiceProvider).playPhase(phase);
    }
  }

  Future<void> _playCountdownCue(int seconds) async {
    final prefs = await _ref.read(repositoriesProvider).preferences();
    if (prefs.audioEnabled) {
      await _ref.read(workoutCueServiceProvider).playCountdown(seconds);
    }
  }

  Future<void> pause({bool fromBackground = false}) async {
    if (_machine.phase == WorkoutPhase.interrupted) return;
    _machine.pause();
    if (fromBackground) {
      _machine.markInterrupted();
      awaitingResumeConfirm = true;
      final sid = sessionId;
      if (sid != null) {
        await _ref.read(repositoriesProvider).persistRecovery(sid, snapshot());
      }
    } else {
      await _persistPhaseBoundary(paused: true);
    }
    _uiTimer?.cancel();
    await WakelockPlus.disable();
    notifyListeners();
  }

  Future<void> resumeConfirmed() async {
    awaitingResumeConfirm = false;
    _machine.resume();
    await WakelockPlus.enable();
    _startUiTicker();
    await _persistPhaseBoundary();
    notifyListeners();
  }

  Future<bool> useEasierVariant() async {
    if (_machine.phase == WorkoutPhase.paused ||
        _machine.phase == WorkoutPhase.interrupted) {
      return false;
    }
    final current = _machine.currentItem;
    final easierId = current?.easierVariantId;
    if (current == null || !current.isHold || easierId == null) return false;
    if (_machine.phase == WorkoutPhase.holding) {
      await _recordCurrentHold(HoldResult.partial);
    }
    final easierPlan = await _ref
        .read(repositoriesProvider)
        .planForPractice(easierId);
    if (easierPlan.isEmpty) return false;
    _machine.replaceCurrentItem(easierPlan.single);
    lastRemaining = _machine.remaining(null);
    _lastCountdownCue = null;
    await _playPhaseCue(_machine.phase);
    await _persistPhaseBoundary();
    notifyListeners();
    return true;
  }

  Future<void> skip() async {
    if (_machine.phase == WorkoutPhase.paused ||
        _machine.phase == WorkoutPhase.interrupted) {
      return;
    }
    if (_machine.currentItem?.isHold == true) {
      skippedHolds += 1;
      await _recordCurrentHold(HoldResult.skipped);
    }
    final completed = _machine.skipCurrent();
    if (completed) {
      await _finalizeSession();
      await WakelockPlus.disable();
      _uiTimer?.cancel();
    } else {
      await _persistPhaseBoundary();
    }
    notifyListeners();
  }

  Future<void> stop() async {
    _machine.stop();
    await _recordCurrentHold(HoldResult.stopped);
    await WakelockPlus.disable();
    _uiTimer?.cancel();
    final sid = sessionId;
    if (sid != null) {
      await _ref.read(repositoriesProvider).abandonSession(sid);
    }
    notifyListeners();
  }

  void reportPain() {
    painDuringSession = true;
    notifyListeners();
  }

  Future<void> _finalizeSession() async {
    final sid = sessionId;
    if (sid == null || _sessionFinalized) return;
    final now = _ref.read(appClockProvider).now();
    final started = sessionStartedAt ?? now;
    final elapsed = now.difference(started) - _machine.pausedAccumulated;
    final actual = elapsed.isNegative ? 0 : elapsed.inMilliseconds;
    await _ref.read(repositoriesProvider).finalizeSession(
      sessionId: sid,
      actualDurationMs: actual,
      completedCount: completedHolds,
      skippedCount: skippedHolds,
      pain: painDuringSession,
    );
    _sessionFinalized = true;
  }

  Future<void> submitFeedback({
    required int effort,
    required bool pain,
    String? note,
  }) async {
    final sid = sessionId;
    if (sid == null) return;
    await _finalizeSession();
    await _ref.read(repositoriesProvider).saveSessionFeedback(
      sessionId: sid,
      effort: effort,
      pain: pain || painDuringSession,
      note: note,
    );
  }

  Future<bool> tryRestoreInterrupted() async {
    final repos = _ref.read(repositoriesProvider);
    final session = await repos.interruptedSession();
    if (session == null ||
        !_recovery.canOfferRecovery(
          status: session.status,
          recoveryJson: session.recoveryJson,
        )) {
      return false;
    }
    final map = jsonDecode(session.recoveryJson!) as Map<String, dynamic>;
    final items = (map['items'] as List)
        .cast<Map<String, dynamic>>()
        .map(
          (i) => WorkoutPlanItem(
            variantId: i['variantId'] as String,
            exerciseId: i['exerciseId'] as String,
            displayName: i['displayName'] as String,
            holdDuration: Duration(milliseconds: i['holdMs'] as int),
            setupDuration: Duration(milliseconds: i['setupMs'] as int),
            restDuration: Duration(milliseconds: i['restMs'] as int),
            sideSwitchDuration: Duration(
              milliseconds: i['sideSwitchMs'] as int? ?? 5000,
            ),
            sets: i['sets'] as int? ?? 1,
            unilateralMode: unilateralModeFromString(
              i['unilateralMode'] as String? ?? 'none',
            ),
            formCues: (i['formCues'] as List?)?.cast<String>() ?? const [],
            breathingCue: i['breathingCue'] as String? ?? '',
            kind: WorkoutItemKind.values.firstWhere(
              (kind) => kind.name == i['kind'],
              orElse: () => WorkoutItemKind.hold,
            ),
            staticAssetPath: i['staticAssetPath'] as String?,
            animatedAssetPath: i['animatedAssetPath'] as String?,
            mediaAccessibilityLabel: i['mediaAccessibilityLabel'] as String?,
            animatedMediaAccessibilityLabel:
                i['animatedMediaAccessibilityLabel'] as String?,
            easierVariantId: i['easierVariantId'] as String?,
            harderVariantId: i['harderVariantId'] as String?,
          ),
        )
        .toList();
    _machine.loadPlan(items);
    sessionId = session.id;
    templateId = map['templateId'] as String?;
    programId = map['programId'] as String?;
    sessionStartedAt = map['sessionStartedAt'] != null
        ? DateTime.parse(map['sessionStartedAt'] as String)
        : session.startedAt;
    _sessionFinalized = false;
    _holdStartedAt = map['holdStartedAt'] != null
        ? DateTime.parse(map['holdStartedAt'] as String)
        : null;
    completedHolds = map['completedHolds'] as int? ?? 0;
    skippedHolds = map['skippedHolds'] as int? ?? 0;
    painDuringSession = map['painDuringSession'] as bool? ?? false;
    _machine.restoreFromSnapshot(
      restoredPhase: WorkoutPhase.paused,
      phaseBeforePause: _recovery.resumablePhase(map['phaseBeforePause']),
      phaseStartedAt: map['phaseStartedAt'] != null
          ? DateTime.parse(map['phaseStartedAt'] as String)
          : null,
      deadlineAt: map['deadlineAt'] != null
          ? DateTime.parse(map['deadlineAt'] as String)
          : null,
      remainingWhenPaused: Duration(
        milliseconds: map['remainingWhenPausedMs'] as int? ?? 0,
      ),
      pausedAccumulated: Duration(
        milliseconds: map['pausedAccumulatedMs'] as int? ?? 0,
      ),
      currentItemIndex: map['currentItemIndex'] as int? ?? 0,
      currentSet: map['currentSet'] as int? ?? 1,
      currentSide: holdSideFromString(map['currentSide'] as String? ?? 'none'),
      completionFired: map['completionFired'] as bool? ?? false,
    );
    awaitingResumeConfirm = true;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }
}

final workoutControllerProvider = ChangeNotifierProvider<WorkoutController>((
  ref,
) {
  return WorkoutController(ref);
});
