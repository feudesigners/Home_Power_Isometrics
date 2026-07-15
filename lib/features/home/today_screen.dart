import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../avatar/companion_avatar.dart';
import '../workouts/workout_controller.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final restored = await ref
          .read(workoutControllerProvider)
          .tryRestoreInterrupted();
      if (restored && mounted) {
        _showRecoveryDialog();
      }
    });
  }

  void _showRecoveryDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final ctrl = ref.read(workoutControllerProvider);
        return AlertDialog(
          title: const Text('Interrupted session'),
          content: const Text(
            'A workout was interrupted. Resume only after you are ready.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(repositoriesProvider)
                    .abandonSession(ctrl.sessionId!, partial: true);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Mark as partial'),
            ),
            TextButton(
              onPressed: () async {
                await ref
                    .read(repositoriesProvider)
                    .discardSession(ctrl.sessionId!);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Discard'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                context.push('/workout/run');
              },
              child: const Text('Resume'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    return SafeArea(
      child: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) {
          return FutureBuilder(
            future: Future.wait([
              ref.read(repositoriesProvider).recommendedTemplate(),
              ref.read(repositoriesProvider).quickStartTemplate(),
              ref.read(repositoriesProvider).userLevel(),
              ref.read(repositoriesProvider).recentSessions(limit: 14),
            ]),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final recommended = snap.data![0];
              final quick = snap.data![1];
              final level = snap.data![2] as dynamic;
              final sessions = snap.data![3] as List;
              final weekCount = sessions.where((s) {
                final started = (s as dynamic).startedAt as DateTime;
                return started.isAfter(
                  DateTime.now().subtract(const Duration(days: 7)),
                );
              }).length;
              final recoveryDay = weekCount >= profile.weeklyWorkoutTarget;

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Row(
                    children: [
                      CompanionAvatar(
                        avatarId: profile.selectedAvatarId,
                        mood: AvatarMood.greeting,
                        size: 64,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IsometriX',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'Hi ${profile.displayName} — level ${level.level}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Challenges',
                        onPressed: () => context.push('/challenges'),
                        icon: const Icon(Icons.emoji_events_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    recoveryDay ? 'Recovery-friendly day' : "Today's quest",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recommended == null
                                ? 'Quick Start'
                                : (recommended as dynamic).name as String,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~${recommended == null ? 5 : (recommended as dynamic).estimatedMinutes} min · Lower, core, posture',
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Weekly goal: $weekCount / ${profile.weeklyWorkoutTarget}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          if (recoveryDay)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'You already hit this week\'s target. A short session is optional.',
                              ),
                            ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: recommended == null
                                  ? null
                                  : () => context.push(
                                      '/workout/preview/${(recommended as dynamic).id}',
                                    ),
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Start workout'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (quick != null)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () => context.push(
                                  '/workout/preview/${(quick as dynamic).id}',
                                ),
                                child: const Text('Quick five-minute option'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.lock_open_outlined),
                    title: const Text('Next unlock'),
                    subtitle: const Text(
                      'Complete a full session to earn First Complete Workout.',
                    ),
                    onTap: () => context.push('/challenges'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
