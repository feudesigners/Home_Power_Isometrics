import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../bootstrap/providers.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/today_screen.dart';
import '../../features/home/train_screen.dart';
import '../../features/progress/progress_screen.dart';
import '../../features/settings/you_screen.dart';
import '../../features/exercises/exercise_detail_screen.dart';
import '../../features/workouts/workout_preview_screen.dart';
import '../../features/workouts/workout_runner_screen.dart';
import '../../features/workouts/workout_completion_screen.dart';
import '../../features/progress/session_detail_screen.dart';
import '../../features/challenges/challenges_screen.dart';
import '../../core/widgets/grid_background.dart';

final _rootKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const _SplashGate(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/train',
                builder: (context, state) => const TrainScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/progress',
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/you',
                builder: (context, state) => const YouScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/exercise/:id',
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            ExerciseDetailScreen(exerciseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/workout/preview/:templateId',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => WorkoutPreviewScreen(
          templateId: state.pathParameters['templateId']!,
        ),
      ),
      GoRoute(
        path: '/workout/run',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const WorkoutRunnerScreen(),
      ),
      GoRoute(
        path: '/workout/complete',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const WorkoutCompletionScreen(),
      ),
      GoRoute(
        path: '/session/:id',
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            SessionDetailScreen(sessionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/challenges',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const ChallengesScreen(),
      ),
    ],
  );
});

class _SplashGate extends ConsumerWidget {
  const _SplashGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(bootstrapProvider);
    return boot.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Startup error: $e'))),
      data: (_) {
        return FutureBuilder(
          future: ref.read(repositoriesProvider).profile(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              if (snap.data!.onboardingComplete) {
                context.go('/today');
              } else {
                context.go('/onboarding');
              }
            });
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.today_outlined),
              selectedIcon: Icon(Icons.today),
              label: 'Today',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Train',
            ),
            NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'You',
            ),
          ],
        ),
      ),
    );
  }
}
