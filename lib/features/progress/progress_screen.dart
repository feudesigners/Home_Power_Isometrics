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
          int completedOn(DateTime day) => completed.where((session) {
            final started = session.startedAt as DateTime;
            return started.year == day.year &&
                started.month == day.month &&
                started.day == day.day;
          }).length;
          final last7 = List.generate(
            7,
            (index) => now.subtract(Duration(days: 6 - index)),
          );
          final last28 = List.generate(
            28,
            (index) => now.subtract(Duration(days: 27 - index)),
          );

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
              const SizedBox(height: 12),
              _ActivityBars(
                days: last7,
                counts: last7.map(completedOn).toList(),
                semanticLabel: summary7,
              ),
              const SizedBox(height: 16),
              Text(
                '28-day activity calendar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _ActivityCalendar(
                days: last28,
                counts: last28.map(completedOn).toList(),
                semanticLabel: summary28,
              ),
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

class _ActivityBars extends StatelessWidget {
  const _ActivityBars({
    required this.days,
    required this.counts,
    required this.semanticLabel,
  });

  final List<DateTime> days;
  final List<int> counts;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final maxCount = counts.fold<int>(
      1,
      (max, value) => value > max ? value : max,
    );
    return Semantics(
      label: semanticLabel,
      image: true,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 96,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var index = 0; index < days.length; index++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${counts[index]}'),
                        const SizedBox(height: 3),
                        Container(
                          height: 12 + (52 * counts[index] / maxCount),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat.E().format(days[index]).substring(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityCalendar extends StatelessWidget {
  const _ActivityCalendar({
    required this.days,
    required this.counts,
    required this.semanticLabel,
  });

  final List<DateTime> days;
  final List<int> counts;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Semantics(
      label: semanticLabel,
      image: true,
      child: ExcludeSemantics(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for (var index = 0; index < days.length; index++)
              Tooltip(
                message:
                    '${DateFormat.yMMMd().format(days[index])}: ${counts[index]} completed',
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: counts[index] == 0
                        ? Theme.of(context).dividerColor.withValues(alpha: 0.2)
                        : primary.withValues(
                            alpha: (0.35 + counts[index] * 0.2)
                                .clamp(0.35, 1)
                                .toDouble(),
                          ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${days[index].day}'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
