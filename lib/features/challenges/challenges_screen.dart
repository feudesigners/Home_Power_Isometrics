import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/services/achievement_evaluator.dart';
import '../../domain/services/challenge_evaluator.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenges & achievements')),
      body: FutureBuilder(
        future: Future.wait([
          ref.read(repositoriesProvider).achievementProgress(),
          ref.read(repositoriesProvider).challengeProgress(),
        ]),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final achProg = (snap.data![0] as List).cast<dynamic>();
          final chProg = (snap.data![1] as List).cast<dynamic>();
          final unlocked = {
            for (final a in achProg.where((a) => a.unlocked == true))
              a.achievementId as String,
          };
          final chMap = {for (final c in chProg) c.challengeId as String: c};

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Achievements',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (final def in AchievementEvaluator.definitions)
                ListTile(
                  leading: Icon(
                    unlocked.contains(def.id)
                        ? Icons.emoji_events
                        : Icons.lock_outline,
                  ),
                  title: Text(def.name),
                  subtitle: Text(def.description),
                  trailing: Text(
                    unlocked.contains(def.id) ? 'Unlocked' : 'Locked',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              const SizedBox(height: 16),
              Text('Challenges', style: Theme.of(context).textTheme.titleLarge),
              for (final def in ChallengeEvaluator.definitions)
                ListTile(
                  title: Text(def.name),
                  subtitle: Text(def.description),
                  trailing: Text(
                    '${chMap[def.id]?.currentCount ?? 0}/${def.targetCount}'
                    '${chMap[def.id]?.completed == true ? ' ✓' : ''}',
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
