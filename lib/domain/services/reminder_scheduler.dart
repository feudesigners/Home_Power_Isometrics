/// Abstraction for optional local reminders (no exact-alarm for workout timers).
abstract class ReminderScheduler {
  Future<bool> ensurePermission();
  Future<void> scheduleWeekly({
    required int id,
    required List<int> weekdays,
    required int hour,
    required int minute,
    required String title,
    required String body,
  });
  Future<void> cancelAll();
  Future<void> showTest({required String title, required String body});
}

class NoOpReminderScheduler implements ReminderScheduler {
  @override
  Future<bool> ensurePermission() async => false;

  @override
  Future<void> scheduleWeekly({
    required int id,
    required List<int> weekdays,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {}

  @override
  Future<void> cancelAll() async {}

  @override
  Future<void> showTest({required String title, required String body}) async {}
}
