import 'dart:convert';

import '../../core/errors/app_exception.dart';

class ExportImportService {
  static const schemaVersion = 1;
  static const _sessionStatuses = {
    'active',
    'paused',
    'interrupted',
    'completed',
    'abandoned',
  };
  static const _holdResults = {
    'completed',
    'partial',
    'skipped',
    'stopped',
  };
  static const _sides = {'none', 'left', 'right'};
  static const _levels = {'foundation', 'control', 'endurance'};
  static const _themes = {'system', 'light', 'dark'};

  Map<String, dynamic> buildExport({
    required Map<String, dynamic> profile,
    required Map<String, dynamic> preferences,
    required List<Map<String, dynamic>> sessions,
    required List<Map<String, dynamic>> holdAttempts,
    required List<Map<String, dynamic>> xpEvents,
    required List<Map<String, dynamic>> achievements,
  }) {
    return {
      'schemaVersion': schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'profile': profile,
      'preferences': preferences,
      'sessions': sessions,
      'holdAttempts': holdAttempts,
      'xpEvents': xpEvents,
      'achievements': achievements,
    };
  }

  String toJsonString(Map<String, dynamic> data) =>
      const JsonEncoder.withIndent('  ').convert(data);

  String toCsvHistory(List<Map<String, dynamic>> sessions) {
    final buffer = StringBuffer(
      'id,startedAt,completedAt,status,effort,pain\n',
    );
    for (final session in sessions) {
      buffer.writeln(
        [
          session['id'],
          session['startedAt'],
          session['completedAt'],
          session['status'],
          session['effort'],
          session['pain'],
        ].map(_csvCell).join(','),
      );
    }
    return buffer.toString();
  }

  String _csvCell(Object? value) {
    final text = value?.toString() ?? '';
    if (!text.contains(RegExp('[,"\n\r]'))) return text;
    return '"${text.replaceAll('"', '""')}"';
  }

  Map<String, dynamic> parseAndValidate(String raw) {
    late final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (error) {
      throw ValidationException('Import JSON is not valid.', cause: error);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const ValidationException('Import root must be an object.');
    }
    if (decoded['schemaVersion'] != schemaVersion) {
      throw const ValidationException(
        'Missing or unsupported schemaVersion.',
      );
    }

    for (final key in [
      'sessions',
      'holdAttempts',
      'xpEvents',
      'achievements',
    ]) {
      final value = decoded[key];
      if (value != null &&
          (value is! List ||
              value.any((item) => item is! Map<String, dynamic>))) {
        throw ValidationException('$key must be a list of objects.');
      }
    }
    for (final key in ['profile', 'preferences']) {
      final value = decoded[key];
      if (value != null && value is! Map<String, dynamic>) {
        throw ValidationException('$key must be an object.');
      }
    }

    _validateProfile(decoded['profile'] as Map<String, dynamic>?);
    _validatePreferences(decoded['preferences'] as Map<String, dynamic>?);

    final sessionIds = <String>{};
    for (final rawSession in (decoded['sessions'] as List? ?? const [])) {
      final session = rawSession as Map<String, dynamic>;
      final id = _requireString(session, 'id', 'session');
      if (!sessionIds.add(id)) {
        throw ValidationException('Duplicate session id: $id.');
      }
      final started = _requireDate(session, 'startedAt', 'session');
      final completed = _optionalDate(session, 'completedAt', 'session');
      if (completed != null && completed.isBefore(started)) {
        throw ValidationException(
          'Session $id completes before it starts.',
        );
      }
      _requireEnum(session, 'status', 'session', _sessionStatuses);
      for (final key in [
        'plannedDurationMs',
        'actualDurationMs',
        'completedExerciseCount',
        'skippedExerciseCount',
      ]) {
        _optionalNonNegativeInt(session, key, 'session');
      }
      _optionalRpe(session, 'effort', 'session');
      _optionalBool(session, 'pain', 'session');
      _optionalString(session, 'note', 'session', maxLength: 2000);
    }

    final holdIds = <String>{};
    for (final rawHold
        in (decoded['holdAttempts'] as List? ?? const [])) {
      final hold = rawHold as Map<String, dynamic>;
      final id = _requireString(hold, 'id', 'hold attempt');
      if (!holdIds.add(id)) {
        throw ValidationException('Duplicate hold attempt id: $id.');
      }
      _requireString(hold, 'sessionId', 'hold attempt');
      _requireString(hold, 'exerciseId', 'hold attempt');
      _requireString(hold, 'variantId', 'hold attempt');
      _requireEnum(hold, 'result', 'hold attempt', _holdResults);
      if (hold.containsKey('side')) {
        _requireEnum(hold, 'side', 'hold attempt', _sides);
      }
      final target = _requireNonNegativeInt(
        hold,
        'targetMs',
        'hold attempt',
      );
      final completed = _requireNonNegativeInt(
        hold,
        'completedMs',
        'hold attempt',
      );
      if (completed > target) {
        throw ValidationException(
          'Hold attempt $id exceeds its target duration.',
        );
      }
      for (final key in ['preparationMs', 'restMs', 'pauseMs']) {
        _optionalNonNegativeInt(hold, key, 'hold attempt');
      }
      if (hold['setNumber'] != null &&
          (hold['setNumber'] is! int || (hold['setNumber'] as int) < 1)) {
        throw const ValidationException(
          'Hold attempt setNumber must be at least 1.',
        );
      }
      _optionalRpe(hold, 'effort', 'hold attempt');
      _optionalBool(hold, 'pain', 'hold attempt');
      final started = _requireDate(hold, 'startedAt', 'hold attempt');
      final ended = _requireDate(hold, 'endedAt', 'hold attempt');
      if (ended.isBefore(started)) {
        throw ValidationException(
          'Hold attempt $id ends before it starts.',
        );
      }
    }

    final xpIds = <String>{};
    for (final rawEvent in (decoded['xpEvents'] as List? ?? const [])) {
      final event = rawEvent as Map<String, dynamic>;
      final id = _requireString(event, 'id', 'XP event');
      if (!xpIds.add(id)) {
        throw ValidationException('Duplicate XP event id: $id.');
      }
      _requireString(event, 'sourceType', 'XP event');
      _requireString(event, 'sourceId', 'XP event');
      _requireNonNegativeInt(event, 'amount', 'XP event');
      _optionalDate(event, 'createdAt', 'XP event');
    }

    final achievementIds = <String>{};
    for (final rawAchievement
        in (decoded['achievements'] as List? ?? const [])) {
      final achievement = rawAchievement as Map<String, dynamic>;
      final id = _requireString(
        achievement,
        'achievementId',
        'achievement',
      );
      if (!achievementIds.add(id)) {
        throw ValidationException('Duplicate achievement id: $id.');
      }
      _optionalBool(achievement, 'unlocked', 'achievement');
      _optionalDate(achievement, 'unlockedAt', 'achievement');
      _optionalString(
        achievement,
        'sourceSessionId',
        'achievement',
        maxLength: 100,
      );
    }
    return decoded;
  }

  void _validateProfile(Map<String, dynamic>? profile) {
    if (profile == null) return;
    _optionalString(
      profile,
      'displayName',
      'profile',
      minLength: 1,
      maxLength: 40,
    );
    _optionalString(profile, 'goal', 'profile', maxLength: 120);
    if (profile.containsKey('startingLevel')) {
      _requireEnum(profile, 'startingLevel', 'profile', _levels);
    }
    _optionalIntRange(
      profile,
      'preferredSessionMinutes',
      'profile',
      5,
      60,
    );
    _optionalIntRange(profile, 'weeklyWorkoutTarget', 'profile', 1, 7);
    _optionalString(
      profile,
      'selectedAvatarId',
      'profile',
      minLength: 1,
      maxLength: 100,
    );
  }

  void _validatePreferences(Map<String, dynamic>? preferences) {
    if (preferences == null) return;
    if (preferences.containsKey('theme')) {
      _requireEnum(preferences, 'theme', 'preferences', _themes);
    }
    for (final key in [
      'audioEnabled',
      'hapticsEnabled',
      'reducedMotion',
    ]) {
      _optionalBool(preferences, key, 'preferences');
    }
  }

  String _requireString(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    final value = row[key];
    if (value is! String || value.trim().isEmpty) {
      throw ValidationException('$label $key must be a non-empty string.');
    }
    return value;
  }

  void _optionalString(
    Map<String, dynamic> row,
    String key,
    String label, {
    int minLength = 0,
    int maxLength = 1000,
  }) {
    final value = row[key];
    if (value == null) return;
    if (value is! String ||
        value.length < minLength ||
        value.length > maxLength) {
      throw ValidationException('$label $key has an invalid length.');
    }
  }

  DateTime _requireDate(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    final parsed = _optionalDate(row, key, label);
    if (parsed == null) {
      throw ValidationException('$label $key must be an ISO-8601 date.');
    }
    return parsed;
  }

  DateTime? _optionalDate(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    final value = row[key];
    if (value == null) return null;
    final parsed = value is String ? DateTime.tryParse(value) : null;
    if (parsed == null) {
      throw ValidationException('$label $key must be an ISO-8601 date.');
    }
    return parsed;
  }

  void _requireEnum(
    Map<String, dynamic> row,
    String key,
    String label,
    Set<String> allowed,
  ) {
    final value = row[key];
    if (value is! String || !allowed.contains(value)) {
      throw ValidationException('$label $key is unsupported.');
    }
  }

  int _requireNonNegativeInt(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    final value = row[key];
    if (value is! int || value < 0) {
      throw ValidationException(
        '$label $key must be a non-negative integer.',
      );
    }
    return value;
  }

  void _optionalNonNegativeInt(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    if (row[key] == null) return;
    _requireNonNegativeInt(row, key, label);
  }

  void _optionalIntRange(
    Map<String, dynamic> row,
    String key,
    String label,
    int minimum,
    int maximum,
  ) {
    final value = row[key];
    if (value == null) return;
    if (value is! int || value < minimum || value > maximum) {
      throw ValidationException(
        '$label $key must be between $minimum and $maximum.',
      );
    }
  }

  void _optionalRpe(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    _optionalIntRange(row, key, label, 1, 10);
  }

  void _optionalBool(
    Map<String, dynamic> row,
    String key,
    String label,
  ) {
    final value = row[key];
    if (value != null && value is! bool) {
      throw ValidationException('$label $key must be a boolean.');
    }
  }
}

class ImportSummary {
  const ImportSummary({
    required this.sessions,
    required this.holdAttempts,
    required this.xpEvents,
    required this.achievements,
  });

  final int sessions;
  final int holdAttempts;
  final int xpEvents;
  final int achievements;
}
