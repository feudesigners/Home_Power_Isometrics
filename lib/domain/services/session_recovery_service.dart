import '../entities/enums.dart';

enum RecoveryDisposition { resume, markPartial, discard }

/// Pure policy for deciding whether a persisted workout can be recovered.
/// Persistence itself stays behind the repository boundary.
class SessionRecoveryService {
  const SessionRecoveryService();

  bool canOfferRecovery({
    required String status,
    required String? recoveryJson,
  }) {
    final parsed = sessionStatusFromString(status);
    return recoveryJson != null &&
        recoveryJson.isNotEmpty &&
        {
          SessionStatus.active,
          SessionStatus.paused,
          SessionStatus.interrupted,
        }.contains(parsed);
  }

  WorkoutPhase resumablePhase(Object? value) {
    final name = value is String ? value : null;
    return WorkoutPhase.values.firstWhere(
      (phase) => phase.name == name && _isActivePhase(phase),
      orElse: () => WorkoutPhase.holding,
    );
  }

  bool _isActivePhase(WorkoutPhase phase) => switch (phase) {
    WorkoutPhase.preparing ||
    WorkoutPhase.holding ||
    WorkoutPhase.resting ||
    WorkoutPhase.switchingSide => true,
    _ => false,
  };
}
