import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isometrix/core/widgets/exercise_media_view.dart';
import 'package:isometrix/features/avatar/companion_avatar.dart';
import 'package:isometrix/app/theme/isometrix_theme.dart';

void main() {
  testWidgets('companion avatars expose semantics for three starters', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: IsometrixTheme.dark(),
        home: const Scaffold(
          body: Row(
            children: [
              CompanionAvatar(avatarId: 'pulse'),
              CompanionAvatar(avatarId: 'nova'),
              CompanionAvatar(avatarId: 'atlas'),
            ],
          ),
        ),
      ),
    );
    expect(find.byType(CompanionAvatar), findsNWidgets(3));
  });

  testWidgets('missing media shows accessible fallback', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExerciseMediaView(
            label: 'Wall Sit posture',
            assetPath: 'assets/images/does_not_exist.png',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Placeholder media'), findsOneWidget);
  });

  testWidgets('large text does not overflow critical timer label area', (
    tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
        child: MaterialApp(
          theme: IsometrixTheme.dark(),
          home: const Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text(
                    'PREPARING',
                    style: TextStyle(fontFamily: 'JetBrainsMono'),
                  ),
                  Text(
                    '0:12',
                    style: TextStyle(fontSize: 42, fontFamily: 'JetBrainsMono'),
                  ),
                  FilledButton(onPressed: null, child: Text('Pause')),
                  FilledButton(onPressed: null, child: Text('Stop')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Pause'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);
  });
}
