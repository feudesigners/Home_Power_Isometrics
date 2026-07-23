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
import '../theme/isometrix_theme.dart';

final _rootKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final boot = ref.read(bootstrapProvider);
      final profileAsync = ref.read(profileProvider);
      final loc = state.matchedLocation;
      final onSplash = loc == '/splash';
      final onOnboarding = loc == '/onboarding';

      if (boot.isLoading) {
        return onSplash ? null : '/splash';
      }
      if (boot.hasError) {
        return onSplash ? null : '/splash';
      }

      final profile = profileAsync.valueOrNull;
      if (profile == null) {
        // Keep non-splash routes during profile reload to avoid flicker.
        if (profileAsync.isLoading && !onSplash) return null;
        if (profileAsync.hasError) {
          return onSplash ? null : '/splash';
        }
        return onSplash ? null : '/splash';
      }

      if (!profile.onboardingComplete) {
        return onOnboarding ? null : '/onboarding';
      }

      if (onSplash || onOnboarding) {
        return '/today';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const _SplashScreen(),
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
        builder: (context, state) => const ChallengesScreen(),
      ),
    ],
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen(bootstrapProvider, (_, _) => notifyListeners());
    ref.listen(profileProvider, (_, _) => notifyListeners());
  }
}

class _SplashScreen extends ConsumerWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(bootstrapProvider);
    final profile = ref.watch(profileProvider);

    final error = boot.asError?.error ?? profile.asError?.error;

    return GridBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'IsometriX',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: IsometrixColors.mint,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Static Strength. Dynamic Results.',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(
                        alpha: 0.55,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  if (error != null) ...[
                    Text(
                      'Startup error: $error',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        ref.invalidate(bootstrapProvider);
                        ref.invalidate(profileProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ] else
                    const CircularProgressIndicator(
                      color: IsometrixColors.mint,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
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
