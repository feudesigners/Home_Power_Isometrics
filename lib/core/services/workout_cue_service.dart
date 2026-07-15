import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/enums.dart';

abstract interface class WorkoutCueService {
  Future<void> playPhase(WorkoutPhase phase);
  Future<void> playCountdown(int secondsRemaining);
  Future<void> dispose();
}

/// Plays bundled cues when present. Missing placeholder audio is intentionally
/// silent, so media handoff cannot crash or block a workout.
class BundledWorkoutCueService implements WorkoutCueService {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> playPhase(WorkoutPhase phase) async {
    final asset = switch (phase) {
      WorkoutPhase.preparing => 'audio/prep.ogg',
      WorkoutPhase.holding => 'audio/hold.ogg',
      WorkoutPhase.resting || WorkoutPhase.switchingSide => 'audio/rest.ogg',
      WorkoutPhase.completed => 'audio/complete.ogg',
      _ => null,
    };
    if (asset != null) await _playIfBundled(asset);
  }

  @override
  Future<void> playCountdown(int secondsRemaining) async {
    if (secondsRemaining >= 1 && secondsRemaining <= 3) {
      await _playIfBundled('audio/countdown.ogg');
    }
  }

  Future<void> _playIfBundled(String asset) async {
    try {
      await rootBundle.load('assets/$asset');
      await _player.play(AssetSource(asset));
    } catch (_) {
      // Audio assets are an explicit production handoff gate.
    }
  }

  @override
  Future<void> dispose() => _player.dispose();
}
