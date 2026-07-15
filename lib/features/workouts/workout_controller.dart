import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../domain/entities/enums.dart';
import '../../domain/services/workout_state_machine.dart';
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

  WorkoutStateMachine get machine => _machine;
  WorkoutPhase get phase => _machine.phase;

  Future<void> startFromTemplate(String tplId, {String? progId}) async {
    final repos = _ref.read(repositoriesProvider);
    final plan = await repos.planFromTemplate(tplId);
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
    _machine.loadPlan(plan);
    final plannedMs = plan.fold<int>(
      0,
      (a, i) =>
          a +
          i.setupDuration.inMilliseconds +
          i.holdDuration.inMilliseconds +
          i.restDuration.inMilliseconds,
    );
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
    final before = _machine.phase;
    final result = _machine.evaluate();
    lastRemaining = result.remaining;

    if (result.holdCompletedFully) {
      completedHolds += 1;
      await _recordCurrentHold(
        HoldResult.completed,
        full: true,
        side: result.holdCompletedSide,
      );
    }
    if (result.sessionCompleted) {
      await WakelockPlus.disable();
      _uiTimer?.cancel();
    }
    if (before != result.phase || result.phaseCompleted != null) {
      await _persistPhaseBoundary();
    }
    notifyListeners();
  }

  Future<void> _recordCurrentHold(
    HoldResult result, {
    bool full = false,
    HoldSide? side,
  }) async {
    final item = _machine.currentItem;
    final sid = sessionId;
    if (item == null || sid == null) return;
    final target = item.holdDuration.inMilliseconds;
    final completed = full
        ? target
        : (target - lastRemaining.inMilliseconds).clamp(0, target);
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
        );
  }

  Map<String, dynamic> snapshot() => {
    'sessionId': sessionId,
    'templateId': templateId,
    'programId': programId,
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
            'unilateralMode': i.unilateralMode.name,
            'formCues': i.formCues,
            'breathingCue': i.breathingCue,
          },
        )
        .toList(),
  };

  Future<void> _persistPhaseBoundary() async {
    final sid = sessionId;
    if (sid == null) return;
    await _ref.read(repositoriesProvider).markSessionPaused(sid, snapshot());
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
      await _persistPhaseBoundary();
    }
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

  Future<void> skip() async {
    skippedHolds += 1;
    await _recordCurrentHold(HoldResult.skipped);
    _machine.skipCurrent();
    await _persistPhaseBoundary();
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

  Future<void> submitFeedback({
    required int effort,
    required bool pain,
    String? note,
  }) async {
    final sid = sessionId;
    if (sid == null) return;
    final now = _ref.read(appClockProvider).now();
    final started = sessionStartedAt ?? now;
    final actual = now.difference(started).inMilliseconds;
    await _ref
        .read(repositoriesProvider)
        .completeSession(
          sessionId: sid,
          actualDurationMs: actual,
          completedCount: completedHolds,
          skippedCount: skippedHolds,
          effort: effort,
          pain: pain || painDuringSession,
          note: note,
        );
  }

  Future<bool> tryRestoreInterrupted() async {
    final repos = _ref.read(repositoriesProvider);
    final session = await repos.interruptedSession();
    if (session == null || session.recoveryJson == null) return false;
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
            unilateralMode: unilateralModeFromString(
              i['unilateralMode'] as String? ?? 'none',
            ),
            formCues: (i['formCues'] as List?)?.cast<String>() ?? const [],
            breathingCue: i['breathingCue'] as String? ?? '',
          ),
        )
        .toList();
    _machine.loadPlan(items);
    sessionId = session.id;
    templateId = map['templateId'] as String?;
    programId = map['programId'] as String?;
    completedHolds = map['completedHolds'] as int? ?? 0;
    skippedHolds = map['skippedHolds'] as int? ?? 0;
    painDuringSession = map['painDuringSession'] as bool? ?? false;
    _machine.restoreFromSnapshot(
      restoredPhase: WorkoutPhase.paused,
      phaseBeforePause: WorkoutPhase.values.firstWhere(
        (p) => p.name == map['phaseBeforePause'],
        orElse: () => WorkoutPhase.holding,
      ),
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
