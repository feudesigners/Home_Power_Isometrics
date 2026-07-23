/// Injectable clock so timer logic never depends on wall-clock UI ticks.
abstract class AppClock {
  DateTime now();
}

class SystemAppClock implements AppClock {
  SystemAppClock()
    : _wallAnchor = DateTime.now(),
      _stopwatch = Stopwatch()..start();

  final DateTime _wallAnchor;
  final Stopwatch _stopwatch;

  @override
  DateTime now() => _wallAnchor.add(_stopwatch.elapsed);
}

/// Deterministic clock for unit tests. Advance manually — never waits.
class FakeAppClock implements AppClock {
  FakeAppClock([DateTime? start])
    : _now = start ?? DateTime.utc(2026, 1, 1, 12);

  DateTime _now;

  @override
  DateTime now() => _now;

  void advance(Duration by) {
    _now = _now.add(by);
  }

  void set(DateTime value) {
    _now = value;
  }
}
