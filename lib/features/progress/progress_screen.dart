import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/entities/enums.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: FutureBuilder(
        future: Future.wait([
          ref.read(repositoriesProvider).recentSessions(limit: 60),
          ref.read(repositoriesProvider).userLevel(),
          ref.read(repositoriesProvider).bests(),
          ref.read(repositoriesProvider).achievementProgress(),
        ]),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final sessions = (snap.data![0] as List).cast<dynamic>();
          final level = snap.data![1] as dynamic;
          final bests = (snap.data![2] as List).cast<dynamic>();
          final unlocked = (snap.data![3] as List)
              .cast<dynamic>()
              .where((a) => a.unlocked == true)
              .length;

          final now = DateTime.now();
          final d7 = sessions.where(
            (s) => (s.startedAt as DateTime).isAfter(
              now.subtract(const Duration(days: 7)),
            ),
          );
          final d28 = sessions.where(
            (s) => (s.startedAt as DateTime).isAfter(
              now.subtract(const Duration(days: 28)),
            ),
          );
          final completed = sessions
              .where((s) => s.status == SessionStatus.completed.name)
              .toList();

          final summary7 =
              'Last 7 days: ${d7.length} sessions logged, ${completed.where((s) => d7.contains(s)).length} completed.';
          final summary28 = 'Last 28 days: ${d28.length} sessions logged.';

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Progress',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(summary7),
              Text(summary28),
              Text(
                'Level ${level.level} · ${level.totalXp} XP · $unlocked achievements unlocked',
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Challenges'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/challenges'),
              ),
              Text(
                'Personal bests',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (bests.isEmpty)
                const Text(
                  'Complete full holds to record variant-specific bests.',
                ),
              for (final b in bests.take(8))
                ListTile(
                  title: Text(b.variantId as String),
                  subtitle: Text('Side: ${b.side}'),
                  trailing: Text('${(b.bestMs / 1000).round()}s'),
                ),
              Text('History', style: Theme.of(context).textTheme.titleLarge),
              for (final s in sessions)
                ListTile(
                  title: Text(
                    DateFormat.yMMMd().add_jm().format(s.startedAt as DateTime),
                  ),
                  subtitle: Text(
                    '${s.status} · effort ${s.perceivedEffort ?? '-'}'
                    '${s.painFlag == true ? ' · discomfort flagged' : ''}',
                  ),
                  onTap: () => context.push('/session/${s.id}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
