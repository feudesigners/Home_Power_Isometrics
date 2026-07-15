import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../core/widgets/exercise_media_view.dart';
import '../workouts/workout_controller.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  ConsumerState<ExerciseDetailScreen> createState() =>
      _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  String? selectedVariantId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(repositoriesProvider).allExercises(),
        ref.read(repositoriesProvider).allVariants(),
        ref.read(repositoriesProvider).preferences(),
        ref.read(repositoriesProvider).limitationTags(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final exercises = snapshot.data![0] as List;
        final variants = snapshot.data![1] as List;
        final preferences = snapshot.data![2] as dynamic;
        final careTags = (snapshot.data![3] as List).cast<String>();
        final exercise = exercises.cast<dynamic>().firstWhere(
          (candidate) => candidate.id == widget.exerciseId,
        );
        final available =
            variants
                .cast<dynamic>()
                .where(
                  (variant) => variant.exerciseId == widget.exerciseId,
                )
                .toList()
              ..sort(
                (a, b) => (a.difficultyRank as int).compareTo(
                  b.difficultyRank as int,
                ),
              );
        if (available.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(exercise.name as String)),
            body: const Center(child: Text('No variations are available.')),
          );
        }
        final selected = available.firstWhere(
          (variant) => variant.id == selectedVariantId,
          orElse: () => available.firstWhere(
            (variant) => variant.difficultyRank == 2,
            orElse: () => available.first,
          ),
        );
        final variantCareTags =
            (jsonDecode(selected.limitationTagsJson as String) as List)
                .cast<String>();
        final conflicts = variantCareTags
            .where(careTags.contains)
            .toList();

        return Scaffold(
          appBar: AppBar(title: Text(exercise.name as String)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              FutureBuilder(
                future: Future.wait([
                  ref
                      .read(repositoriesProvider)
                      .mediaById(selected.staticAssetId as String?),
                  ref
                      .read(repositoriesProvider)
                      .mediaById(selected.animatedAssetId as String?),
                ]),
                builder: (context, mediaSnapshot) {
                  final staticMedia = mediaSnapshot.data?[0] as dynamic;
                  final animatedMedia = mediaSnapshot.data?[1] as dynamic;
                  final reducedMotion = preferences.reducedMotion as bool;
                  return ExerciseMediaView(
                    label: reducedMotion
                        ? (staticMedia?.accessibilityLabel as String? ??
                              '${selected.displayName} posture')
                        : (animatedMedia?.accessibilityLabel as String? ??
                              staticMedia?.accessibilityLabel as String? ??
                              '${selected.displayName} demonstration'),
                    assetPath: reducedMotion
                        ? staticMedia?.assetPath as String?
                        : (animatedMedia?.assetPath as String? ??
                              staticMedia?.assetPath as String?),
                    reducedMotion: false,
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Muscles: ${(jsonDecode(exercise.primaryMusclesJson as String) as List).join(', ')}',
              ),
              const SizedBox(height: 8),
              Text('Breathing: ${selected.breathingCue}'),
              const SizedBox(height: 8),
              Text('Safety: ${selected.safetyNotes}'),
              if (conflicts.isNotEmpty)
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Review carefully: this variation overlaps your care areas: ${conflicts.join(', ')}.',
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text('Variants', style: Theme.of(context).textTheme.titleLarge),
              for (final variant in available)
                Card(
                  child: ListTile(
                    selected: variant.id == selected.id,
                    title: Text(variant.displayName as String),
                    subtitle: Text(
                      'Rank ${variant.difficultyRank} · ${(variant.targetHoldMs / 1000).round()}s provisional'
                      '${variant.gatedForBeginners == true ? ' · progression gate' : ''}',
                    ),
                    onTap: () => setState(
                      () => selectedVariantId = variant.id as String,
                    ),
                    trailing: TextButton(
                      onPressed: () async {
                        await ref
                            .read(workoutControllerProvider)
                            .startPractice(variant.id as String);
                        if (context.mounted) context.push('/workout/run');
                      },
                      child: const Text('Practice'),
                    ),
                  ),
                ),
              FutureBuilder(
                future: ref
                    .read(repositoriesProvider)
                    .formCuesFor(selected.id as String),
                builder: (context, cueSnapshot) {
                  final cues = cueSnapshot.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Form cues',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      for (final cue in cues) Text('• ${cue.cue}'),
                      const SizedBox(height: 8),
                      Text(
                        'Common mistakes: ${(jsonDecode(selected.commonMistakesJson as String) as List).join('; ')}',
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
