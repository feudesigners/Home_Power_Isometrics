import 'package:flutter/material.dart';

class IsometrixColors {
  static const bgDark = Color(0xFF050810);
  static const bgDark2 = Color(0xFF0A0F1E);
  static const bgLight = Color(0xFFF0F3FA);
  static const bgLight2 = Color(0xFFE4E8F4);
  static const mint = Color(0xFF00F5C4);
  static const indigo = Color(0xFF5B6EF5);
  static const coral = Color(0xFFFF4D6D);
  static const textDark = Color(0xFFE8EAF0);
  static const textLight = Color(0xFF0D1117);
  static const lowerBody = Color(0xFF5B6EF5);
  static const core = Color(0xFF00F5C4);
  static const upperBody = Color(0xFFFF4D6D);
}

class IsometrixTheme {
  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'DMSans',
      colorScheme: const ColorScheme.dark(
        primary: IsometrixColors.mint,
        secondary: IsometrixColors.indigo,
        tertiary: IsometrixColors.coral,
        surface: IsometrixColors.bgDark2,
        error: IsometrixColors.coral,
      ),
      scaffoldBackgroundColor: IsometrixColors.bgDark,
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 40,
          letterSpacing: 2,
          color: IsometrixColors.textDark,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 28,
          letterSpacing: 2,
          color: IsometrixColors.textDark,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: IsometrixColors.textDark,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 14,
          color: IsometrixColors.textDark,
        ),
        labelLarge: const TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 12,
          letterSpacing: 1,
          color: IsometrixColors.textDark,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: IsometrixColors.bgDark2.withValues(alpha: 0.95),
        indicatorColor: IsometrixColors.mint.withValues(alpha: 0.2),
        labelTextStyle: WidgetStatePropertyAll(
          base.textTheme.labelLarge?.copyWith(fontSize: 10),
        ),
      ),
    );
  }

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'DMSans',
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF009E80),
        secondary: IsometrixColors.indigo,
        tertiary: IsometrixColors.coral,
        surface: Colors.white,
        error: IsometrixColors.coral,
      ),
      scaffoldBackgroundColor: IsometrixColors.bgLight,
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 40,
          letterSpacing: 2,
          color: IsometrixColors.textLight,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 28,
          letterSpacing: 2,
          color: IsometrixColors.textLight,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: IsometrixColors.textLight,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 14,
          color: IsometrixColors.textLight,
        ),
        labelLarge: const TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 12,
          letterSpacing: 1,
          color: IsometrixColors.textLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.black.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.09)),
        ),
      ),
    );
  }
}
