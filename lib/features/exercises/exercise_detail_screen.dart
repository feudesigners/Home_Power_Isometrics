import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../core/widgets/exercise_media_view.dart';
import '../workouts/workout_controller.dart';

class ExerciseDetailScreen extends ConsumerWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(repositoriesProvider).allExercises(),
        ref.read(repositoriesProvider).allVariants(),
        ref.read(repositoriesProvider).preferences(),
      ]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final exercises = snap.data![0] as List;
        final variants = snap.data![1] as List;
        final prefs = snap.data![2] as dynamic;
        final exercise = exercises.cast<dynamic>().firstWhere(
          (e) => e.id == exerciseId,
        );
        final vs =
            variants
                .cast<dynamic>()
                .where((v) => v.exerciseId == exerciseId)
                .toList()
              ..sort(
                (a, b) => (a.difficultyRank as int).compareTo(
                  b.difficultyRank as int,
                ),
              );
        final primary = vs.firstWhere(
          (v) => v.difficultyRank == 2,
          orElse: () => vs.first,
        );

        return Scaffold(
          appBar: AppBar(title: Text(exercise.name as String)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ExerciseMediaView(
                label: '${exercise.name} posture demonstration',
                assetPath: primary.staticAssetId == null
                    ? null
                    : 'assets/images/${primary.staticAssetId}.png',
                reducedMotion: prefs.reducedMotion as bool,
              ),
              const SizedBox(height: 12),
              Text(
                'Muscles: ${(jsonDecode(exercise.primaryMusclesJson as String) as List).join(', ')}',
              ),
              const SizedBox(height: 8),
              Text('Breathing: ${primary.breathingCue}'),
              const SizedBox(height: 8),
              Text('Safety: ${primary.safetyNotes}'),
              const SizedBox(height: 12),
              Text('Variants', style: Theme.of(context).textTheme.titleLarge),
              for (final v in vs)
                ListTile(
                  title: Text(v.displayName as String),
                  subtitle: Text(
                    'Rank ${v.difficultyRank} · ${(v.targetHoldMs / 1000).round()}s provisional'
                    '${v.gatedForBeginners == true ? ' · progression gate' : ''}',
                  ),
                  trailing: TextButton(
                    onPressed: () async {
                      await ref
                          .read(workoutControllerProvider)
                          .startPractice(v.id as String);
                      if (context.mounted) context.push('/workout/run');
                    },
                    child: const Text('Practice'),
                  ),
                ),
              FutureBuilder(
                future: ref
                    .read(repositoriesProvider)
                    .formCuesFor(primary.id as String),
                builder: (context, cueSnap) {
                  final cues = cueSnap.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Form cues',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      for (final c in cues) Text('• ${c.cue}'),
                      const SizedBox(height: 8),
                      Text(
                        'Common mistakes: ${(jsonDecode(primary.commonMistakesJson as String) as List).join('; ')}',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
