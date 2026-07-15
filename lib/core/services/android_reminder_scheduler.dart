import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/services/reminder_scheduler.dart';

class AndroidReminderScheduler implements ReminderScheduler {
  AndroidReminderScheduler() {
    _init();
  }

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> _init() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    _ready = true;
  }

  @override
  Future<bool> ensurePermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  @override
  Future<void> scheduleWeekly({
    required int id,
    required List<int> weekdays,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    if (!_ready) await _init();
    await cancelAll();
    final android = AndroidNotificationDetails(
      'isometrix_reminders',
      'Training reminders',
      channelDescription: 'Optional local workout reminders',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final details = NotificationDetails(android: android);
    var n = id;
    for (final weekday in weekdays) {
      await _plugin.zonedSchedule(
        n++,
        title,
        body,
        _nextInstance(weekday, hour, minute),
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  tz.TZDateTime _nextInstance(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  @override
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  @override
  Future<void> showTest({required String title, required String body}) async {
    if (!_ready) await _init();
    await _plugin.show(
      9999,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'isometrix_reminders',
          'Training reminders',
        ),
      ),
    );
  }
}
