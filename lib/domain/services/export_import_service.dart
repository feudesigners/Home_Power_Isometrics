import 'dart:convert';

import '../../core/errors/app_exception.dart';

class ExportImportService {
  static const schemaVersion = 1;

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
    final buf = StringBuffer('id,startedAt,completedAt,status,effort,pain\n');
    for (final s in sessions) {
      buf.writeln(
        [
          s['id'],
          s['startedAt'],
          s['completedAt'],
          s['status'],
          s['effort'],
          s['pain'],
        ].map(_csvCell).join(','),
      );
    }
    return buf.toString();
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
    } catch (e) {
      throw ValidationException('Import JSON is not valid.', cause: e);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const ValidationException('Import root must be an object.');
    }
    final version = decoded['schemaVersion'];
    if (version != schemaVersion) {
      throw const ValidationException('Missing or unsupported schemaVersion.');
    }
    for (final key in [
      'sessions',
      'holdAttempts',
      'xpEvents',
      'achievements',
    ]) {
      final value = decoded[key];
      if (value != null && value is! List) {
        throw ValidationException('$key must be a list.');
      }
      if (value is List && value.any((item) => item is! Map<String, dynamic>)) {
        throw ValidationException('$key entries must be objects.');
      }
    }
    for (final key in ['profile', 'preferences']) {
      final value = decoded[key];
      if (value != null && value is! Map<String, dynamic>) {
        throw ValidationException('$key must be an object.');
      }
    }
    for (final rawSession in (decoded['sessions'] as List? ?? const [])) {
      final session = rawSession as Map<String, dynamic>;
      _requireString(session, 'id', 'session');
      _requireDate(session, 'startedAt', 'session');
      _requireString(session, 'status', 'session');
    }
    for (final rawHold in (decoded['holdAttempts'] as List? ?? const [])) {
      final hold = rawHold as Map<String, dynamic>;
      for (final key in [
        'id',
        'sessionId',
        'exerciseId',
        'variantId',
        'result',
      ]) {
        _requireString(hold, key, 'hold attempt');
      }
      for (final key in ['targetMs', 'completedMs']) {
        if (hold[key] is! int || (hold[key] as int) < 0) {
          throw ValidationException('$key must be a non-negative integer.');
        }
      }
      _requireDate(hold, 'startedAt', 'hold attempt');
      _requireDate(hold, 'endedAt', 'hold attempt');
    }
    return decoded;
  }

  void _requireString(Map<String, dynamic> row, String key, String label) {
    if (row[key] is! String || (row[key] as String).isEmpty) {
      throw ValidationException('$label $key must be a non-empty string.');
    }
  }

  void _requireDate(Map<String, dynamic> row, String key, String label) {
    final value = row[key];
    if (value is! String || DateTime.tryParse(value) == null) {
      throw ValidationException('$label $key must be an ISO-8601 date.');
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
