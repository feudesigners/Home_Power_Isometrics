import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/services/progression_recommendation_service.dart';
import '../avatar/companion_avatar.dart';
import 'workout_controller.dart';

class WorkoutCompletionScreen extends ConsumerStatefulWidget {
  const WorkoutCompletionScreen({super.key});

  @override
  ConsumerState<WorkoutCompletionScreen> createState() =>
      _WorkoutCompletionScreenState();
}

class _WorkoutCompletionScreenState
    extends ConsumerState<WorkoutCompletionScreen> {
  int effort = 5;
  bool pain = false;
  final noteCtrl = TextEditingController();
  bool submitted = false;
  List<ProgressionSuggestion> suggestions = const [];

  @override
  void dispose() {
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(workoutControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Session complete')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CompanionAvatar(
              avatarId: 'pulse',
              mood: AvatarMood.celebrating,
              size: 96,
            ),
          ),
          const SizedBox(height: 16),
          Text('Holds completed: ${ctrl.completedHolds}'),
          Text('Skipped: ${ctrl.skippedHolds}'),
          Text(
            pain || ctrl.painDuringSession
                ? 'Pain/discomfort was flagged — no bonus XP for pain.'
                : 'Great controlled work.',
          ),
          const SizedBox(height: 16),
          Text('Perceived effort: $effort / 10'),
          Slider(
            value: effort.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            label: '$effort',
            onChanged: submitted
                ? null
                : (v) => setState(() => effort = v.round()),
          ),
          SwitchListTile(
            title: const Text('Pain or discomfort during session'),
            value: pain,
            onChanged: submitted ? null : (v) => setState(() => pain = v),
          ),
          TextField(
            controller: noteCtrl,
            enabled: !submitted,
            decoration: const InputDecoration(labelText: 'Optional note'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: submitted
                ? null
                : () async {
                    await ctrl.submitFeedback(
                      effort: effort,
                      pain: pain,
                      note: noteCtrl.text.trim().isEmpty
                          ? null
                          : noteCtrl.text.trim(),
                    );
                    final sessionId = ctrl.sessionId;
                    final next = sessionId == null
                        ? const <ProgressionSuggestion>[]
                        : await ref
                              .read(repositoriesProvider)
                              .progressionSuggestionsForSession(sessionId);
                    setState(() {
                      submitted = true;
                      suggestions = next;
                    });
                    ref.invalidate(profileProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Session saved. XP awarded once.'),
                        ),
                      );
                    }
                  },
            child: Text(submitted ? 'Saved' : 'Save feedback'),
          ),
          const SizedBox(height: 8),
          if (submitted && suggestions.isNotEmpty) ...[
            Text(
              'Next-session suggestions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'Suggestions never change your variation automatically.',
            ),
            for (final suggestion in suggestions.take(3))
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(suggestion.displayName),
                subtitle: Text(suggestion.recommendation.explanation),
                leading: Icon(switch (suggestion.recommendation.action) {
                  ProgressionAction.increaseTime => Icons.timer_outlined,
                  ProgressionAction.suggestHarder => Icons.trending_up,
                  ProgressionAction.regress => Icons.trending_down,
                  ProgressionAction.maintain => Icons.horizontal_rule,
                }),
              ),
          ],
          OutlinedButton(
            onPressed: () => context.go('/today'),
            child: const Text('Back to Today'),
          ),
          FutureBuilder(
            future: ref.read(repositoriesProvider).userLevel(),
            builder: (context, snap) {
              if (!snap.hasData) return const SizedBox.shrink();
              final lvl = snap.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Level ${lvl.level} · ${lvl.totalXp} XP',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
