import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:isometrix/core/errors/app_exception.dart';
import 'package:isometrix/domain/services/export_import_service.dart';

void main() {
  const validSession = {
    'id': 'session-1',
    'startedAt': '2026-01-01T10:00:00.000Z',
    'completedAt': '2026-01-01T10:05:00.000Z',
    'status': 'completed',
    'plannedDurationMs': 300000,
    'actualDurationMs': 290000,
    'effort': 6,
    'pain': false,
  };

  Map<String, dynamic> payload({
    List<Map<String, dynamic>> sessions = const [validSession],
    List<Map<String, dynamic>> holds = const [],
  }) =>
      {
        'schemaVersion': 1,
        'profile': {
          'displayName': 'Athlete',
          'startingLevel': 'foundation',
          'preferredSessionMinutes': 10,
          'weeklyWorkoutTarget': 3,
          'selectedAvatarId': 'pulse',
        },
        'preferences': {
          'theme': 'system',
          'audioEnabled': true,
          'hapticsEnabled': true,
          'reducedMotion': false,
        },
        'sessions': sessions,
        'holdAttempts': holds,
        'xpEvents': <Map<String, dynamic>>[],
        'achievements': <Map<String, dynamic>>[],
      };

  test('accepts terminal session history with valid ranges', () {
    final parsed = ExportImportService().parseAndValidate(
      jsonEncode(payload()),
    );
    expect(parsed['sessions'], hasLength(1));
  });

  test('rejects resumable sessions without recovery state', () {
    final invalid = Map<String, dynamic>.from(validSession)
      ..['status'] = 'active'
      ..remove('completedAt');
    expect(
      () => ExportImportService().parseAndValidate(
        jsonEncode(payload(sessions: [invalid])),
      ),
      throwsA(isA<ValidationException>()),
    );
  });

  test('rejects impossible hold dates and duration overflow', () {
    final hold = {
      'id': 'hold-1',
      'sessionId': 'session-1',
      'exerciseId': 'E001',
      'variantId': 'wall_sit_easier',
      'side': 'none',
      'setNumber': 1,
      'targetMs': 10000,
      'completedMs': 11000,
      'result': 'completed',
      'startedAt': '2026-01-01T10:01:00.000Z',
      'endedAt': '2026-01-01T10:00:59.000Z',
    };
    expect(
      () => ExportImportService().parseAndValidate(
        jsonEncode(payload(holds: [hold])),
      ),
      throwsA(isA<ValidationException>()),
    );
  });
}
