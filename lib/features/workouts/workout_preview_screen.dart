import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../workouts/workout_controller.dart';

class WorkoutPreviewScreen extends ConsumerWidget {
  const WorkoutPreviewScreen({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(repositoriesProvider).planFromTemplate(templateId),
        ref.read(repositoriesProvider).templateItems(templateId),
        ref.read(repositoriesProvider).allTemplates(),
        ref.read(repositoriesProvider).limitationTags(),
        ref.read(repositoriesProvider).allVariants(),
      ]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        var plan = List.of(snap.data![0] as List);
        final items = snap.data![1] as List;
        final templates = snap.data![2] as List;
        final limitations = (snap.data![3] as List).cast<String>();
        final variants = snap.data![4] as List;
        final tpl = templates.cast<dynamic>().firstWhere(
          (t) => t.id == templateId,
        );

        // Auto-suggest regressions for limitation conflicts.
        plan = plan.map((item) {
          final v = variants.cast<dynamic>().firstWhere(
            (x) => x.id == item.variantId,
            orElse: () => null,
          );
          if (v == null) return item;
          // parsed later in UI note
          return item;
        }).toList();

        final holdMinutes =
            (plan.fold<int>(
                      0,
                      (a, i) =>
                          a +
                          (i.holdDuration.inSeconds as int) +
                          (i.setupDuration.inSeconds as int) +
                          (i.restDuration.inSeconds as int),
                    ) /
                    60)
                .ceil();

        return Scaffold(
          appBar: AppBar(title: Text(tpl.name as String)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Estimated time ~$holdMinutes min'),
              Text(
                'Includes warm-up/cooldown blocks where configured. Hold times are provisional.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              for (final item in items.cast<dynamic>())
                ListTile(
                  leading: Icon(
                    item.itemType == 'hold'
                        ? Icons.timer_outlined
                        : Icons.self_improvement_outlined,
                  ),
                  title: Text(
                    item.itemType == 'hold'
                        ? (plan
                                      .cast<dynamic>()
                                      .firstWhere(
                                        (p) => p.variantId == item.variantId,
                                        orElse: () => null,
                                      )
                                      ?.displayName
                                  as String? ??
                              item.label as String? ??
                              'Hold')
                        : item.label as String,
                  ),
                  subtitle: item.itemType == 'hold'
                      ? Builder(
                          builder: (_) {
                            final v = variants.cast<dynamic>().firstWhere(
                              (x) => x.id == item.variantId,
                              orElse: () => null,
                            );
                            if (v == null) return const Text('');
                            return Text(
                              '${(v.targetHoldMs / 1000).round()}s · equipment noted in content',
                            );
                          },
                        )
                      : Text(
                          '${((item.durationMs as int) / 1000).round()}s mobility',
                        ),
                  trailing: item.itemType == 'hold'
                      ? IconButton(
                          tooltip: 'Use easier variation',
                          icon: const Icon(Icons.trending_down),
                          onPressed: () async {
                            final v = variants.cast<dynamic>().firstWhere(
                              (x) => x.id == item.variantId,
                            );
                            final easier = v.easierVariantId as String?;
                            if (easier == null) return;
                            // Visual only note — full swap persistence deferred to session start override
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Suggested regression: $easier (applied when you choose Use easier in the runner).',
                                ),
                              ),
                            );
                          },
                        )
                      : null,
                ),
              if (limitations.isNotEmpty && !limitations.contains('none'))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Care filters active: ${limitations.join(', ')}. Unsuitable holds can be regressed in-runner.',
                  ),
                ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () async {
                  await ref
                      .read(workoutControllerProvider)
                      .startFromTemplate(
                        templateId,
                        progId: tpl.programId as String?,
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
