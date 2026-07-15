import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/services/workout_state_machine.dart';
import 'workout_controller.dart';

class WorkoutPreviewScreen extends ConsumerStatefulWidget {
  const WorkoutPreviewScreen({super.key, required this.templateId});

  final String templateId;

  @override
  ConsumerState<WorkoutPreviewScreen> createState() =>
      _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends ConsumerState<WorkoutPreviewScreen> {
  final Map<String, String> _variantOverrides = {};

  Future<_PreviewData> _load() async {
    final repositories = ref.read(repositoriesProvider);
    final plan = await repositories.planFromTemplate(widget.templateId);
    final templates = await repositories.allTemplates();
    final limitations = await repositories.limitationTags();
    final template = templates.firstWhere(
      (candidate) => candidate.id == widget.templateId,
    );
    return _PreviewData(
      plan: plan,
      template: template,
      limitations: limitations,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_PreviewData>(
      future: _load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final data = snapshot.data!;
        final plan = data.plan;
        final estimatedMinutes =
            (plannedWorkoutDurationMs(plan) / 60000).ceil();

        return Scaffold(
          appBar: AppBar(title: Text(data.template.name)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Estimated time ~$estimatedMinutes min'),
              Text(
                'Includes preparation, both sides, side changes, rests, warm-up, and cooldown.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              for (final item in plan)
                ListTile(
                  leading: Icon(
                    item.isHold
                        ? Icons.timer_outlined
                        : Icons.self_improvement_outlined,
                  ),
                  title: Text(item.displayName),
                  subtitle: item.isHold
                      ? Text(
                          '${item.holdDuration.inSeconds}s'
                          '${item.sideCount > 1 ? ' per side' : ''}'
                          ' · ${item.sets} set${item.sets == 1 ? '' : 's'}',
                        )
                      : Text('${item.holdDuration.inSeconds}s mobility'),
                  trailing: item.isHold && item.easierVariantId != null
                      ? IconButton(
                          tooltip: 'Use easier variation',
                          icon: const Icon(Icons.trending_down),
                          onPressed: () {
                            setState(() {
                              _variantOverrides[item.variantId] =
                                  item.easierVariantId!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Safer variation selected for this session.',
                                ),
                              ),
                            );
                          },
                        )
                      : null,
                ),
              if (data.limitations.isNotEmpty &&
                  !data.limitations.contains('none'))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Care filters active: ${data.limitations.join(', ')}. Review each setup and use a supported variation whenever needed.',
                  ),
                ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () async {
                  await ref
                      .read(workoutControllerProvider)
                      .startFromTemplate(
                        widget.templateId,
                        progId: data.template.programId,
                        variantOverrides: _variantOverrides,
                      );
                  if (context.mounted) context.push('/workout/run');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreviewData {
  const _PreviewData({
    required this.plan,
    required this.template,
    required this.limitations,
  });

  final List<WorkoutPlanItem> plan;
  final dynamic template;
  final List<String> limitations;
}
