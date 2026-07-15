import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/services/reminder_scheduler.dart';

class AndroidReminderScheduler implements ReminderScheduler {
  AndroidReminderScheduler() {
    _initialization = _init();
  }

  final _plugin = FlutterLocalNotificationsPlugin();
  late final Future<void> _initialization;

  Future<void> _init() async {
    tz.initializeTimeZones();
    try {
      final deviceTimezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(deviceTimezone.identifier));
    } catch (_) {
      // tz.local remains UTC only if the OS timezone cannot be resolved.
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
  }

  @override
  Future<bool> ensurePermission() async {
    await _initialization;
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
    await _initialization;
    for (var offset = 0; offset < 7; offset++) {
      await _plugin.cancel(id + offset);
    }
    const android = AndroidNotificationDetails(
      'isometrix_reminders',
      'Training reminders',
      channelDescription: 'Optional local workout reminders',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: android);
    var notificationId = id;
    for (final weekday in weekdays.toSet()) {
      if (weekday < DateTime.monday || weekday > DateTime.sunday) continue;
      await _plugin.zonedSchedule(
        notificationId++,
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
    while (scheduled.weekday != weekday || !scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  @override
  Future<void> cancelAll() async {
    await _initialization;
    await _plugin.cancelAll();
  }

  @override
  Future<void> showTest({required String title, required String body}) async {
    await _initialization;
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
