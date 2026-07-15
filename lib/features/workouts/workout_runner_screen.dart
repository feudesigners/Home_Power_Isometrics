import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../app/theme/isometrix_theme.dart';
import '../../core/widgets/exercise_media_view.dart';
import '../../domain/entities/enums.dart';
import '../../domain/services/workout_state_machine.dart';
import '../avatar/companion_avatar.dart';
import 'workout_controller.dart';

class WorkoutRunnerScreen extends ConsumerStatefulWidget {
  const WorkoutRunnerScreen({super.key});

  @override
  ConsumerState<WorkoutRunnerScreen> createState() =>
      _WorkoutRunnerScreenState();
}

class _WorkoutRunnerScreenState extends ConsumerState<WorkoutRunnerScreen>
    with WidgetsBindingObserver {
  WorkoutPhase? _lastAnnounced;
  int? _lastPrecachedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ref.read(workoutControllerProvider).pause(fromBackground: true);
    }
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(1, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _phaseLabel(WorkoutPhase phase, WorkoutPlanItem? item) {
    if (phase == WorkoutPhase.holding && item != null && !item.isHold) {
      return item.kind == WorkoutItemKind.cooldown ? 'COOL-DOWN' : 'WARM-UP';
    }
    return phase.name.toUpperCase();
  }

  void _precacheCurrentAndNext(WorkoutStateMachine machine) {
    if (_lastPrecachedIndex == machine.currentItemIndex) return;
    _lastPrecachedIndex = machine.currentItemIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (final index in [
        machine.currentItemIndex,
        machine.currentItemIndex + 1,
      ]) {
        if (!mounted || index < 0 || index >= machine.items.length) continue;
        final path = machine.items[index].staticAssetPath;
        if (path == null) continue;
        try {
          await precacheImage(AssetImage(path), context);
        } catch (_) {
          // The labeled media fallback remains available.
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(workoutControllerProvider);
    final machine = ctrl.machine;
    final item = machine.currentItem;
    final prefs = ref.watch(preferencesProvider);
    final profile = ref.watch(profileProvider);
    _precacheCurrentAndNext(machine);

    if (machine.phase == WorkoutPhase.completed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/workout/complete');
      });
    }

    if (_lastAnnounced != machine.phase) {
      _lastAnnounced = machine.phase;
      // Announce phase changes only — not every tick.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final msg = 'Phase ${machine.phase.name}';
        SemanticsService.sendAnnouncement(
          View.of(context),
          msg,
          TextDirection.ltr,
        );
      });
      if (prefs.valueOrNull?.hapticsEnabled == true) {
        HapticFeedback.lightImpact();
      }
    }

    if (ctrl.awaitingResumeConfirm) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Workout paused in the background. Confirm to resume the remaining time.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => ctrl.resumeConfirmed(),
                    child: const Text('Resume'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final progress = machine.progressFraction(null);
    final sideLabel = switch (machine.currentSide) {
      HoldSide.left => 'Left side',
      HoldSide.right => 'Right side',
      HoldSide.none => 'Both / centered',
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  CompanionAvatar(
                    avatarId: profile.valueOrNull?.avatarId ?? 'pulse',
                    mood: switch (machine.phase) {
                      WorkoutPhase.holding => AvatarMood.holding,
                      WorkoutPhase.preparing => AvatarMood.preparing,
                      WorkoutPhase.resting => AvatarMood.resting,
                      WorkoutPhase.completed => AvatarMood.celebrating,
                      _ => AvatarMood.encouraging,
                    },
                    size: 56,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item?.displayName ?? 'Workout',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    '${machine.currentItemIndex + 1}/${machine.items.length}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_phaseLabel(machine.phase, item)} · $sideLabel · Set ${machine.currentSet}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              ExerciseMediaView(
                label:
                    (prefs.valueOrNull?.reducedMotion ?? false)
                    ? (item?.mediaAccessibilityLabel ??
                          '${item?.displayName ?? 'Exercise'} posture')
                    : (item?.animatedMediaAccessibilityLabel ??
                          item?.mediaAccessibilityLabel ??
                          '${item?.displayName ?? 'Exercise'} demonstration'),
                assetPath: (prefs.valueOrNull?.reducedMotion ?? false)
                    ? item?.staticAssetPath
                    : (item?.animatedAssetPath ?? item?.staticAssetPath),
                height: 120,
                reducedMotion: false,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        backgroundColor: Colors.white12,
                        color: IsometrixColors.mint,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _fmt(ctrl.lastRemaining),
                          style: const TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _phaseLabel(machine.phase, item).toLowerCase(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (item != null && item.isHold) ...[
                Text(item.breathingCue, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                for (final cue in item.formCues.take(3))
                  Text('• $cue', textAlign: TextAlign.center),
              ],
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (machine.phase == WorkoutPhase.paused)
                    FilledButton(
                      onPressed: ctrl.resumeConfirmed,
                      child: const Text('Resume'),
                    )
                  else
                    OutlinedButton(
                      onPressed: () => ctrl.pause(),
                      child: const Text('Pause'),
                    ),
                  OutlinedButton(
                    onPressed: ctrl.skip,
                    child: const Text('Skip'),
                  ),
                  OutlinedButton(
                    onPressed: item?.easierVariantId == null
                        ? null
                        : () async {
                            final changed = await ctrl.useEasierVariant();
                            if (context.mounted && changed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Switched to the supported variation. Preparation restarted.',
                                  ),
                                ),
                              );
                            }
                          },
                    child: const Text('Use easier variation'),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: IsometrixColors.coral,
                    ),
                    onPressed: () {
                      ctrl.reportPain();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pain noted. Stop if needed — this will not award bonus XP.',
                          ),
                        ),
                      );
                    },
                    child: const Text('Something hurts'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: IsometrixColors.coral,
                    ),
                    onPressed: () async {
                      await ctrl.stop();
                      if (context.mounted) context.go('/today');
                    },
                    child: const Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
