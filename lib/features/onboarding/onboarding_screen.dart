import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String name = 'Athlete';
  String goal = 'Build consistent strength';
  String level = 'foundation';
  int minutes = 10;
  int weekly = 3;
  final Set<String> care = {};
  String avatar = 'pulse';
  bool audio = true;
  bool haptics = true;
  bool reminders = false;
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
      final p = await ref.read(repositoriesProvider).profile();
      setState(() {
        step = p.onboardingStep.clamp(0, 8);
        name = p.displayName;
        avatar = p.selectedAvatarId;
      });
    });
  }

  Future<void> _persist({bool complete = false}) async {
    await ref
        .read(repositoriesProvider)
        .saveOnboarding(
          step: complete ? 9 : step,
          complete: complete,
          displayName: name,
          goal: goal,
          startingLevel: level,
          sessionMinutes: minutes,
          weeklyTarget: weekly,
          avatarId: avatar,
          limitationTags: care.isEmpty ? ['none'] : care.toList(),
          disclaimer: disclaimer,
          audio: audio,
          haptics: haptics,
        );
  }

  Future<void> _next() async {
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
      ref.invalidate(profileProvider);
      // GoRouter redirect sends completed profiles to /today.
      return;
    }
    setState(() => step += 1);
    await _persist();
  }

  void _back() {
    if (step == 0) return;
    setState(() => step -= 1);
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
                controller: TextEditingController(text: name)
                  ..selection = TextSelection.collapsed(offset: name.length),
                onChanged: (v) => name = v,
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
