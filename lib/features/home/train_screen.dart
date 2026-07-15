import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../app/theme/isometrix_theme.dart';

class TrainScreen extends ConsumerStatefulWidget {
  const TrainScreen({super.key});

  @override
  ConsumerState<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends ConsumerState<TrainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  String query = '';
  String? categoryFilter;
  int? difficultyFilter;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Train',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          TabBar(
            controller: _tabs,
            tabs: const [
              Tab(text: 'Programs'),
              Tab(text: 'Library'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _ProgramsTab(),
                _LibraryTab(
                  query: query,
                  categoryFilter: categoryFilter,
                  difficultyFilter: difficultyFilter,
                  onQuery: (v) => setState(() => query = v),
                  onCategory: (v) => setState(() => categoryFilter = v),
                  onDifficulty: (v) => setState(() => difficultyFilter = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(repositoriesProvider).programs(),
      builder: (context, progSnap) {
        if (!progSnap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final programs = progSnap.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: programs.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            if (i == programs.length) {
              return const ListTile(
                title: Text('Custom workout builder'),
                subtitle: Text(
                  'Extension point — deferred in MVP. See ARCHITECTURE.md.',
                ),
                leading: Icon(Icons.construction_outlined),
              );
            }
            final p = programs[i];
            return Card(
              child: ListTile(
                title: Text(p.name),
                subtitle: Text(
                  '${p.description}\n~${p.estimatedMinutes} min · ${p.sessionsPerWeek}x/week · ${p.weeks} weeks',
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final templates = await ref
                      .read(repositoriesProvider)
                      .templatesForProgram(p.id);
                  if (!context.mounted || templates.isEmpty) return;
                  templates.sort((a, b) => a.name.compareTo(b.name));
                  await showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (sheetContext) => SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        children: [
                          Text(
                            p.name,
                            style: Theme.of(
                              sheetContext,
                            ).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose any scheduled session. Your accepted progressions are applied when the plan opens.',
                          ),
                          const SizedBox(height: 12),
                          for (final template in templates)
                            ListTile(
                              leading: const Icon(Icons.calendar_today_outlined),
                              title: Text(template.name),
                              subtitle: Text(
                                '~${template.estimatedMinutes} minutes',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.pop(sheetContext);
                                context.push(
                                  '/workout/preview/${template.id}',
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _LibraryTab extends ConsumerWidget {
  const _LibraryTab({
    required this.query,
    required this.categoryFilter,
    required this.difficultyFilter,
    required this.onQuery,
    required this.onCategory,
    required this.onDifficulty,
  });

  final String query;
  final String? categoryFilter;
  final int? difficultyFilter;
  final ValueChanged<String> onQuery;
  final ValueChanged<String?> onCategory;
  final ValueChanged<int?> onDifficulty;

  Color _catColor(String id) {
    switch (id) {
      case 'C001':
        return IsometrixColors.lowerBody;
      case 'C002':
        return IsometrixColors.core;
      default:
        return IsometrixColors.upperBody;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(repositoriesProvider).allExercises(),
        ref.read(repositoriesProvider).allVariants(),
        ref.read(repositoriesProvider).categories(),
      ]),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final exercises = snap.data![0] as List;
        final variants = snap.data![1] as List;
        final cats = snap.data![2] as List;
        final filtered = exercises.where((e) {
          final name = (e as dynamic).name as String;
          final cat = e.categoryId as String;
          if (query.isNotEmpty &&
              !name.toLowerCase().contains(query.toLowerCase())) {
            return false;
          }
          if (categoryFilter != null && cat != categoryFilter) return false;
          if (difficultyFilter != null &&
              !variants.any(
                (variant) =>
                    (variant as dynamic).exerciseId == e.id &&
                    variant.difficultyRank == difficultyFilter,
              )) {
            return false;
          }
          return true;
        }).toList();

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search exercises',
              ),
              onChanged: onQuery,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: categoryFilter == null,
                  onSelected: (_) => onCategory(null),
                ),
                for (final c in cats)
                  FilterChip(
                    label: Text((c as dynamic).name as String),
                    selected: categoryFilter == c.id,
                    onSelected: (_) => onCategory(c.id as String),
                  ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final d in [1, 2, 3])
                  FilterChip(
                    label: Text('Rank $d'),
                    selected: difficultyFilter == d,
                    onSelected: (sel) => onDifficulty(sel ? d : null),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            for (final e in filtered)
              Card(
                child: ListTile(
                  leading: Container(
                    width: 10,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _catColor((e as dynamic).categoryId as String),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  title: Text(e.name as String),
                  subtitle: Text(
                    (() {
                      final vs = variants
                          .where(
                            (v) =>
                                (v as dynamic).exerciseId == e.id &&
                                (difficultyFilter == null ||
                                    v.difficultyRank == difficultyFilter),
                          )
                          .toList();
                      if (vs.isEmpty) return 'No variants';
                      final v = vs.first;
                      final muscles =
                          (jsonDecode(e.primaryMusclesJson as String) as List)
                              .join(', ');
                      return '${(v.targetHoldMs / 1000).round()}s provisional · $muscles';
                    })(),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/exercise/${e.id}'),
                ),
              ),
          ],
        );
      },
    );
  }
}
