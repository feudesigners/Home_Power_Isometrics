import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/app_clock.dart';
import '../../data/database/database.dart';
import '../../data/repositories/app_repositories.dart';
import '../../data/seed/content_seed_service.dart';
import '../../domain/services/reminder_scheduler.dart';
import '../../core/services/android_reminder_scheduler.dart';
import '../../core/services/workout_cue_service.dart';

final appClockProvider = Provider<AppClock>((ref) => const SystemAppClock());

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoriesProvider = Provider<AppRepositories>((ref) {
  return AppRepositories(ref.watch(databaseProvider));
});

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  return AndroidReminderScheduler();
});

final workoutCueServiceProvider = Provider<WorkoutCueService>((ref) {
  final service = BundledWorkoutCueService();
  ref.onDispose(service.dispose);
  return service;
});

final bootstrapProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await ContentSeedService(db).ensureSeeded();
});

final profileProvider = FutureProvider((ref) async {
  await ref.watch(bootstrapProvider.future);
  return ref.watch(repositoriesProvider).profile();
});

final preferencesProvider = FutureProvider((ref) async {
  await ref.watch(bootstrapProvider.future);
  return ref.watch(repositoriesProvider).preferences();
});
