import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/bootstrap/providers.dart';
import 'app/routing/app_router.dart';
import 'app/theme/isometrix_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: IsometrixApp()));
}

class IsometrixApp extends ConsumerWidget {
  const IsometrixApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final prefs = ref.watch(preferencesProvider);

    final themeMode = prefs.when(
      data: (p) {
        switch (p.theme) {
          case 'light':
            return ThemeMode.light;
          case 'dark':
            return ThemeMode.dark;
          default:
            return ThemeMode.system;
        }
      },
      loading: () => ThemeMode.system,
      error: (_, _) => ThemeMode.system,
    );

    return MaterialApp.router(
      title: 'IsometriX',
      theme: IsometrixTheme.light(),
      darkTheme: IsometrixTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
