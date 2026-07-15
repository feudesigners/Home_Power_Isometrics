import 'package:flutter_test/flutter_test.dart';
import 'package:isometrix/core/time/app_clock.dart';
import 'package:isometrix/domain/entities/enums.dart';
import 'package:isometrix/domain/services/workout_state_machine.dart';

void main() {
  late FakeAppClock clock;
  late WorkoutStateMachine machine;

  setUp(() {
    clock = FakeAppClock();
    machine = WorkoutStateMachine(clock);
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'wall_sit_easier',
        exerciseId: 'E001',
        displayName: 'Wall Sit',
        holdDuration: const Duration(seconds: 10),
        setupDuration: const Duration(seconds: 3),
        restDuration: const Duration(seconds: 5),
      ),
      WorkoutPlanItem(
        variantId: 'plank_easier',
        exerciseId: 'E006',
        displayName: 'Plank',
        holdDuration: const Duration(seconds: 8),
        setupDuration: const Duration(seconds: 2),
        restDuration: const Duration(seconds: 4),
        unilateralMode: UnilateralMode.leftRight,
      ),
    ]);
  });

  test('start enters preparing with deadline from clock', () {
    machine.start();
    expect(machine.phase, WorkoutPhase.preparing);
    expect(machine.remaining(clock.now()), const Duration(seconds: 3));
    clock.advance(const Duration(seconds: 1));
    expect(machine.remaining(clock.now()), const Duration(seconds: 2));
  });

  test('UI tick is not source of truth — advancing clock drives phase', () {
    machine.start();
    clock.advance(const Duration(seconds: 3));
    final r = machine.evaluate();
    expect(r.phase, WorkoutPhase.holding);
    expect(r.phaseCompleted, WorkoutPhase.preparing);
  });

  test('pause and resume does not lose or add time', () {
    machine.start();
    clock.advance(const Duration(seconds: 3)); // into hold
    machine.evaluate();
    clock.advance(const Duration(seconds: 4)); // 6s left of 10
    machine.pause();
    final rem = machine.remaining(clock.now());
    clock.advance(const Duration(seconds: 30)); // wall time while paused
    machine.resume();
    expect(machine.remaining(clock.now()).inSeconds, rem.inSeconds);
  });

  test('completion fires exactly once', () {
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'a',
        exerciseId: 'E001',
        displayName: 'A',
        holdDuration: const Duration(seconds: 5),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
      ),
    ]);
    machine.start();
    clock.advance(const Duration(seconds: 1));
    machine.evaluate(); // hold
    clock.advance(const Duration(seconds: 5));
    final first = machine.evaluate();
    expect(first.sessionCompleted, isTrue);
    expect(machine.completionFired, isTrue);
    final second = machine.evaluate();
    expect(second.sessionCompleted, isFalse);
    expect(machine.phase, WorkoutPhase.completed);
  });

  test('side switch for unilateral leftRight', () {
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'lunge',
        exerciseId: 'E003',
        displayName: 'Lunge',
        holdDuration: const Duration(seconds: 5),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
        sideSwitchDuration: const Duration(seconds: 2),
        unilateralMode: UnilateralMode.leftRight,
      ),
    ]);
    machine.start();
    clock.advance(const Duration(seconds: 1));
    machine.evaluate();
    expect(machine.currentSide, HoldSide.left);
    clock.advance(const Duration(seconds: 5));
    final r = machine.evaluate();
    expect(r.phase, WorkoutPhase.switchingSide);
    expect(machine.currentSide, HoldSide.right);
  });

  test('background interrupt marks interrupted after pause', () {
    machine.start();
    machine.pause();
    machine.markInterrupted();
    expect(machine.phase, WorkoutPhase.interrupted);
  });

  test('interrupted workout resumes from its preserved deadline', () {
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'a',
        exerciseId: 'E001',
        displayName: 'A',
        holdDuration: const Duration(seconds: 10),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
      ),
    ]);
    machine.start();
    clock.advance(const Duration(seconds: 1));
    machine.evaluate();
    clock.advance(const Duration(seconds: 4));
    machine.pause();
    final remainingBeforeInterrupt = machine.remaining(clock.now());
    machine.markInterrupted();

    clock.advance(const Duration(seconds: 30));
    machine.resume();

    expect(machine.phase, WorkoutPhase.holding);
    expect(machine.remaining(clock.now()), remainingBeforeInterrupt);
  });

  test('alternating unilateral work completes both sides', () {
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'bird_dog',
        exerciseId: 'E010',
        displayName: 'Bird Dog',
        holdDuration: const Duration(seconds: 5),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 1),
        sideSwitchDuration: const Duration(seconds: 2),
        unilateralMode: UnilateralMode.alternating,
      ),
    ]);
    machine.start();
    clock.advance(const Duration(seconds: 1));
    machine.evaluate();
    expect(machine.currentSide, HoldSide.left);

    clock.advance(const Duration(seconds: 5));
    final result = machine.evaluate();

    expect(result.phase, WorkoutPhase.switchingSide);
    expect(result.holdCompletedSide, HoldSide.left);
    expect(machine.currentSide, HoldSide.right);
  });

  test('multiple sets repeat the current item before advancing', () {
    machine.loadPlan([
      WorkoutPlanItem(
        variantId: 'a',
        exerciseId: 'E001',
        displayName: 'A',
        holdDuration: const Duration(seconds: 2),
        setupDuration: const Duration(seconds: 1),
        restDuration: const Duration(seconds: 3),
        sets: 2,
      ),
    ]);
    machine.start();
    clock.advance(const Duration(seconds: 1));
    machine.evaluate();
    clock.advance(const Duration(seconds: 2));
    machine.evaluate();

    expect(machine.phase, WorkoutPhase.resting);
    expect(machine.currentSet, 1);
    expect(machine.currentItemIndex, 0);

    clock.advance(const Duration(seconds: 3));
    machine.evaluate();

    expect(machine.phase, WorkoutPhase.preparing);
    expect(machine.currentSet, 2);
    expect(machine.currentItemIndex, 0);

    clock.advance(const Duration(seconds: 1));
    machine.evaluate();
    clock.advance(const Duration(seconds: 2));
    final completed = machine.evaluate();

    expect(completed.sessionCompleted, isTrue);
    expect(machine.phase, WorkoutPhase.completed);
  });

}
