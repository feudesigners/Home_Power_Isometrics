/// Injectable clock so timer logic never depends on wall-clock UI ticks.
abstract class AppClock {
  DateTime now();
  Duration get elapsedSinceEpoch;
}

class SystemAppClock implements AppClock {
  const SystemAppClock();

  @override
  DateTime now() => DateTime.now();

  @override
  Duration get elapsedSinceEpoch =>
      Duration(milliseconds: DateTime.now().millisecondsSinceEpoch);
}

/// Deterministic clock for unit tests. Advance manually — never waits.
class FakeAppClock implements AppClock {
  FakeAppClock([DateTime? start])
    : _now = start ?? DateTime.utc(2026, 1, 1, 12);

  DateTime _now;

  @override
  DateTime now() => _now;

  @override
  Duration get elapsedSinceEpoch =>
      Duration(milliseconds: _now.millisecondsSinceEpoch);

  void advance(Duration by) {
    _now = _now.add(by);
  }

  void set(DateTime value) {
    _now = value;
  }
}
