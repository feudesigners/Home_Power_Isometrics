import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bootstrap/providers.dart';
import '../../core/widgets/grid_background.dart';
import '../avatar/companion_avatar.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int step = 0;
  final TextEditingController _nameController = TextEditingController(
    text: 'Athlete',
  );
  String goal = 'Build consistent strength';
  String level = 'foundation';
  int minutes = 10;
  int weekly = 3;
  final Set<String> care = {};
  String avatar = 'pulse';
  bool audio = true;
  bool haptics = true;
  bool reminders = false;
  bool reducedMotion = false;
  bool disclaimer = false;

  static const careOptions = [
    'knees',
    'wrists',
    'shoulders',
    'lower_back',
    'balance',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repositories = ref.read(repositoriesProvider);
      final profile = await repositories.profile();
      final preferences = await repositories.preferences();
      final limitations = await repositories.limitationTags();
      final reminder = await repositories.reminderSchedule();
      if (!mounted) return;
      setState(() {
        step = profile.onboardingStep.clamp(0, 8).toInt();
        _nameController.text = profile.displayName;
        goal = profile.goal ?? goal;
        level = profile.startingLevel;
        minutes = profile.preferredSessionMinutes;
        weekly = profile.weeklyWorkoutTarget;
        avatar = profile.selectedAvatarId;
        disclaimer = profile.disclaimerAccepted;
        audio = preferences.audioEnabled;
        haptics = preferences.hapticsEnabled;
        reducedMotion = preferences.reducedMotion;
        reminders = reminder.enabled;
        care
          ..clear()
          ..addAll(limitations.where((tag) => tag != 'none'));
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _persist({bool complete = false}) async {
    await ref
        .read(repositoriesProvider)
        .saveOnboarding(
          step: complete ? 9 : step,
          complete: complete,
          displayName: _nameController.text.trim(),
          goal: goal,
          startingLevel: level,
          sessionMinutes: minutes,
          weeklyTarget: weekly,
          avatarId: avatar,
          limitationTags: care.isEmpty ? ['none'] : care.toList(),
          disclaimer: disclaimer,
          audio: audio,
          haptics: haptics,
          reducedMotion: reducedMotion,
        );
  }

  Future<void> _next() async {
    if (step == 1 &&
        (_nameController.text.trim().isEmpty ||
            _nameController.text.trim().length > 40)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a display name between 1 and 40 characters.'),
        ),
      );
      return;
    }
    if (step == 5 && !disclaimer) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please acknowledge the safety guidance to continue.'),
        ),
      );
      return;
    }
    if (step >= 8) {
      await _persist(complete: true);
      final repositories = ref.read(repositoriesProvider);
      final scheduler = ref.read(reminderSchedulerProvider);
      if (reminders && await scheduler.ensurePermission()) {
        const weekdays = [DateTime.monday, DateTime.wednesday, DateTime.friday];
        await scheduler.scheduleWeekly(
          id: 100,
          weekdays: weekdays,
          hour: 9,
          minute: 0,
          title: 'IsometriX',
          body: 'Your short strength session is ready.',
        );
        await repositories.saveReminderSchedule(
          enabled: true,
          weekdays: weekdays,
          hour: 9,
          minute: 0,
        );
      } else {
        await scheduler.cancelAll();
        await repositories.saveReminderSchedule(
          enabled: false,
          weekdays: const [1, 3, 5],
          hour: 9,
          minute: 0,
        );
      }
      ref.invalidate(profileProvider);
      ref.invalidate(preferencesProvider);
      if (mounted) context.go('/today');
      return;
    }
    setState(() => step += 1);
    await _persist();
  }

  Future<void> _back() async {
    if (step == 0) return;
    setState(() => step -= 1);
    await _persist();
  }

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Setup ${step + 1}/9'),
          leading: step > 0
              ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: _back)
              : null,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: SingleChildScrollView(child: _stepBody())),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _next,
                  child: Text(step == 8 ? 'See today\'s quest' : 'Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepBody() {
    switch (step) {
      case 0:
        return _block(
          title: 'IsometriX',
          subtitle: 'Static Strength. Dynamic Results.',
          child: const Text(
            'A short guided isometric coach for home. Offline-first, no account required. Not a medical or rehabilitation service.',
          ),
        );
      case 1:
        return _block(
          title: 'Your goal',
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Display name'),
                controller: _nameController,
                maxLength: 40,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children:
                    [
                          'Build consistency',
                          'Core control',
                          'Lower-body stability',
                          'Posture support',
                        ]
                        .map(
                          (g) => ChoiceChip(
                            label: Text(g),
                            selected: goal == g,
                            onSelected: (_) => setState(() => goal = g),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        );
      case 2:
        return _block(
          title: 'Starting level',
          child: RadioGroup<String>(
            groupValue: level,
            onChanged: (value) {
              if (value != null) setState(() => level = value);
            },
            child: Column(
              children: [
                for (final entry in {
                  'foundation': 'Foundation — accessible regressions',
                  'control': 'Control — standard holds',
                  'endurance': 'Endurance — longer controlled holds',
                }.entries)
                  RadioListTile<String>(
                    title: Text(entry.value),
                    value: entry.key,
                  ),
              ],
            ),
          ),
        );
      case 3:
        return _block(
          title: 'Session length and weekly target',
          child: Column(
            children: [
              Text('Preferred session: $minutes minutes'),
              Slider(
                value: minutes.toDouble(),
                min: 5,
                max: 20,
                divisions: 3,
                label: '$minutes min',
                onChanged: (v) => setState(() => minutes = v.round()),
              ),
              Text('Weekly workouts: $weekly'),
              Slider(
                value: weekly.toDouble(),
                min: 2,
                max: 5,
                divisions: 3,
                label: '$weekly / week',
                onChanged: (v) => setState(() => weekly = v.round()),
              ),
            ],
          ),
        );
      case 4:
        return _block(
          title: 'Areas requiring care',
          subtitle: 'Preference filters only — not a diagnosis.',
          child: Column(
            children: [
              for (final tag in careOptions)
                CheckboxListTile(
                  title: Text(tag.replaceAll('_', ' ')),
                  value: care.contains(tag),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      care.add(tag);
                    } else {
                      care.remove(tag);
                    }
                  }),
                ),
              CheckboxListTile(
                title: const Text('None selected'),
                value: care.isEmpty,
                onChanged: (v) => setState(() {
                  if (v == true) care.clear();
                }),
              ),
            ],
          ),
        );
      case 5:
        return _block(
          title: 'Safety acknowledgement',
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '• Breathe continuously; do not deliberately hold your breath.',
                  ),
                  Text(
                    '• Stop for chest pain, dizziness, faintness, unusual shortness of breath, or sharp pain.',
                  ),
                  Text(
                    '• Use a stable, non-rolling chair and a clear non-slip area.',
                  ),
                  Text(
                    '• Seek professional advice before demanding holds if you have relevant health conditions.',
                  ),
                  Text(
                    '• Hold times are provisional coaching targets, not medical prescriptions.',
                  ),
                  SizedBox(height: 12),
                ],
              ).andCheckbox(
                value: disclaimer,
                onChanged: (v) => setState(() => disclaimer = v ?? false),
              ),
        );
      case 6:
        return _block(
          title: 'Choose a companion',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final id in ['pulse', 'nova', 'atlas'])
                GestureDetector(
                  onTap: () => setState(() => avatar = id),
                  child: Column(
                    children: [
                      CompanionAvatar(
                        avatarId: id,
                        mood: AvatarMood.greeting,
                        size: avatar == id ? 88 : 72,
                      ),
                      const SizedBox(height: 8),
                      Text(id[0].toUpperCase() + id.substring(1)),
                      if (avatar == id)
                        const Icon(Icons.check_circle, size: 18),
                    ],
                  ),
                ),
            ],
          ),
        );
      case 7:
        return _block(
          title: 'Audio, haptics, reminders',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Audio cues'),
                value: audio,
                onChanged: (v) => setState(() => audio = v),
              ),
              SwitchListTile(
                title: const Text('Haptic cues'),
                value: haptics,
                onChanged: (v) => setState(() => haptics = v),
              ),
              SwitchListTile(
                title: const Text('Reduce motion'),
                subtitle: const Text(
                  'Use static posture art instead of animated demonstrations.',
                ),
                value: reducedMotion,
                onChanged: (v) => setState(() => reducedMotion = v),
              ),
              SwitchListTile(
                title: const Text('Optional local reminders'),
                subtitle: const Text('You can configure details later in You.'),
                value: reminders,
                onChanged: (v) => setState(() => reminders = v),
              ),
            ],
          ),
        );
      default:
        return _block(
          title: 'Your first recommended workout',
          subtitle: 'Quick Start — about five accessible minutes.',
          child: const Text(
            'We will open a balanced beginner-friendly session using regressions. Harder gated holds stay locked until you progress.',
          ),
        );
    }
  }

  Widget _block({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: 20),
        child,
      ],
    );
  }
}

extension on Column {
  Widget andCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...children,
        CheckboxListTile(
          title: const Text('I understand and wish to continue'),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
