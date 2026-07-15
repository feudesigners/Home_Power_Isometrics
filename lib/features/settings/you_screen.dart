import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/bootstrap/providers.dart';
import '../../domain/services/export_import_service.dart';
import '../avatar/companion_avatar.dart';

class YouScreen extends ConsumerWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final prefsAsync = ref.watch(preferencesProvider);

    return SafeArea(
      child: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) {
          return prefsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (prefs) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    'You',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CompanionAvatar(
                        avatarId: profile.selectedAvatarId,
                        mood: AvatarMood.idle,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${profile.displayName}\nGoal: ${profile.goal ?? '-'}\nWeekly target: ${profile.weeklyWorkoutTarget}',
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: ref.read(repositoriesProvider).avatars(),
                    builder: (context, snapshot) {
                      final avatars = snapshot.data ?? const [];
                      if (avatars.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            'Companion',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Text(
                            'Pulse, Nova, and Atlas are included starter companions.',
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final avatar in avatars)
                                ChoiceChip(
                                  avatar: CompanionAvatar(
                                    avatarId: avatar.id,
                                    size: 32,
                                  ),
                                  label: Text(avatar.name),
                                  selected:
                                      profile.selectedAvatarId == avatar.id,
                                  onSelected: (_) async {
                                    await ref
                                        .read(repositoriesProvider)
                                        .selectAvatar(avatar.id);
                                    ref.invalidate(profileProvider);
                                  },
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const Divider(height: 32),
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'system', label: Text('System')),
                      ButtonSegment(value: 'light', label: Text('Light')),
                      ButtonSegment(value: 'dark', label: Text('Dark')),
                    ],
                    selected: {prefs.theme},
                    onSelectionChanged: (s) async {
                      await ref.read(repositoriesProvider).updateTheme(s.first);
                      ref.invalidate(preferencesProvider);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Audio cues'),
                    value: prefs.audioEnabled,
                    onChanged: (v) async {
                      await ref
                          .read(repositoriesProvider)
                          .saveOnboarding(
                            step: profile.onboardingStep,
                            complete: profile.onboardingComplete,
                            audio: v,
                          );
                      ref.invalidate(preferencesProvider);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Haptics'),
                    value: prefs.hapticsEnabled,
                    onChanged: (v) async {
                      await ref
                          .read(repositoriesProvider)
                          .saveOnboarding(
                            step: profile.onboardingStep,
                            complete: profile.onboardingComplete,
                            haptics: v,
                          );
                      ref.invalidate(preferencesProvider);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Reduced motion'),
                    value: prefs.reducedMotion,
                    onChanged: (v) async {
                      await ref
                          .read(repositoriesProvider)
                          .saveOnboarding(
                            step: profile.onboardingStep,
                            complete: profile.onboardingComplete,
                            reducedMotion: v,
                          );
                      ref.invalidate(preferencesProvider);
                    },
                  ),
                  ListTile(
                    title: const Text('Reminders'),
                    subtitle: const Text(
                      'Choose days and time for optional device-local notifications.',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _configureReminders(context, ref),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Safety information'),
                    subtitle: const Text(
                      'Breathe continuously. Stop for sharp pain, dizziness, or chest pain. Not medical advice.',
                    ),
                  ),
                  ListTile(
                    title: const Text('Export data (JSON)'),
                    onTap: () async {
                      final data = await ref
                          .read(repositoriesProvider)
                          .exportUserData();
                      final dir = await getApplicationDocumentsDirectory();
                      final file = File('${dir.path}/isometrix_export.json');
                      await file.writeAsString(
                        const JsonEncoder.withIndent('  ').convert(data),
                      );
                      await Share.shareXFiles([
                        XFile(file.path),
                      ], text: 'IsometriX data export');
                    },
                  ),
                  ListTile(
                    title: const Text('Export history (CSV)'),
                    onTap: () async {
                      final data = await ref
                          .read(repositoriesProvider)
                          .exportUserData();
                      final csv = ExportImportService().toCsvHistory(
                        (data['sessions'] as List).cast<Map<String, dynamic>>(),
                      );
                      final dir = await getApplicationDocumentsDirectory();
                      final file = File('${dir.path}/isometrix_history.csv');
                      await file.writeAsString(csv);
                      await Share.shareXFiles([XFile(file.path)]);
                    },
                  ),
                  ListTile(
                    title: const Text('Import data (JSON)'),
                    subtitle: const Text(
                      'Validates the file before merging sessions and progress.',
                    ),
                    onTap: () async {
                      final picked = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: const ['json'],
                        withData: true,
                      );
                      if (picked == null || picked.files.isEmpty) return;
                      final selected = picked.files.single;
                      try {
                        final bytes =
                            selected.bytes ??
                            (selected.path == null
                                ? null
                                : await File(selected.path!).readAsBytes());
                        if (bytes == null) {
                          throw const FormatException(
                            'The selected file could not be read.',
                          );
                        }
                        final summary = await ref
                            .read(repositoriesProvider)
                            .importUserData(utf8.decode(bytes));
                        ref.invalidate(profileProvider);
                        ref.invalidate(preferencesProvider);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Imported ${summary.sessions} sessions and ${summary.holdAttempts} holds.',
                              ),
                            ),
                          );
                        }
                      } catch (error) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Import rejected: $error')),
                          );
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Reset / delete local data'),
                    textColor: Colors.redAccent,
                    onTap: () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete all local data?'),
                          content: const Text(
                            'This clears history, XP, and progress. Seeded exercise content remains.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (ok == true) {
                        await ref
                            .read(repositoriesProvider)
                            .deleteAllUserData();
                        await ref.read(reminderSchedulerProvider).cancelAll();
                        ref.invalidate(profileProvider);
                        ref.invalidate(preferencesProvider);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Local user data deleted'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const ListTile(
                    title: Text('About'),
                    subtitle: Text(
                      'IsometriX MVP · Offline-first · No analytics SDK · No ads',
                    ),
                  ),
                  const ListTile(
                    title: Text('Privacy'),
                    subtitle: Text(
                      'All user data stays on this device unless you export it. See PRIVACY.md.',
                    ),
                  ),
                  const ListTile(
                    title: Text('Licences'),
                    subtitle: Text(
                      'Fonts: OFL (Bebas Neue, DM Sans, JetBrains Mono). See assets/fonts/FONT_LICENSES.txt',
                    ),
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

Future<void> _configureReminders(
  BuildContext context,
  WidgetRef ref,
) async {
  final repositories = ref.read(repositoriesProvider);
  final current = await repositories.reminderSchedule();
  if (!context.mounted) return;
  var enabled = current.enabled;
  final weekdays = current.weekdaysCsv
      .split(',')
      .map(int.tryParse)
      .whereType<int>()
      .toSet();
  var time = TimeOfDay(hour: current.hour, minute: current.minute);

  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Training reminders'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Enable reminders'),
                value: enabled,
                onChanged: (value) => setState(() => enabled = value),
              ),
              Wrap(
                spacing: 6,
                children: [
                  for (final entry in const {
                    1: 'Mon',
                    2: 'Tue',
                    3: 'Wed',
                    4: 'Thu',
                    5: 'Fri',
                    6: 'Sat',
                    7: 'Sun',
                  }.entries)
                    FilterChip(
                      label: Text(entry.value),
                      selected: weekdays.contains(entry.key),
                      onSelected: enabled
                          ? (selected) => setState(() {
                              if (selected) {
                                weekdays.add(entry.key);
                              } else {
                                weekdays.remove(entry.key);
                              }
                            })
                          : null,
                    ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Time'),
                subtitle: Text(time.format(context)),
                trailing: const Icon(Icons.schedule),
                enabled: enabled,
                onTap: () async {
                  final selected = await showTimePicker(
                    context: dialogContext,
                    initialTime: time,
                  );
                  if (selected != null) setState(() => time = selected);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: enabled && weekdays.isEmpty
                ? null
                : () => Navigator.pop(dialogContext, true),
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
  if (shouldSave != true || !context.mounted) return;

  final scheduler = ref.read(reminderSchedulerProvider);
  final selectedDays = weekdays.toList()..sort();
  if (enabled) {
    final allowed = await scheduler.ensurePermission();
    if (!allowed) {
      enabled = false;
    } else {
      await scheduler.scheduleWeekly(
        id: 100,
        weekdays: selectedDays,
        hour: time.hour,
        minute: time.minute,
        title: 'IsometriX',
        body: 'Your short strength session is ready.',
      );
    }
  }
  if (!enabled) await scheduler.cancelAll();
  await repositories.saveReminderSchedule(
    enabled: enabled,
    weekdays: selectedDays.isEmpty ? const [1, 3, 5] : selectedDays,
    hour: time.hour,
    minute: time.minute,
  );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          enabled
              ? 'Reminder schedule saved in your device timezone.'
              : 'Reminders are off.',
        ),
      ),
    );
  }
}
