import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  // Светлая тема (Aqua Light)
  static ThemeData light() {
    final cs = ColorScheme.fromSeed(
      seedColor: AppColors.aqua,
      primary: AppColors.aqua,
      secondary: AppColors.seaGrass,
      // базовые плоскости интерфейса
      surface: AppColors.white, // карточки/поля
      onSurface: AppColors.ink, // текст на поверхностях
      surfaceContainerLowest: AppColors.mint, // мягкие панели/«блоки»
      surfaceContainer: AppColors.lightBlue, // светлая голубая подложка
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // chipTheme: ChipThemeData(
      //   side: BorderSide.none,
      //   labelStyle: const TextStyle(fontWeight: FontWeight.w700),
      //   backgroundColor: cs.surfaceContainer.withValues(alpha: .25),
      //   selectedColor: cs.primary,
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.aqua,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF5BE41), // жёлтая кнопка
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.aqua.withValues(alpha: .35)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor:
            Colors.transparent, // низ прозрачен — под ним тот же градиент
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.aqua.withValues(
          alpha: .18,
        ), // мягкая подсветка активного
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 26,
            color: states.contains(WidgetState.selected)
                ? AppColors
                      .white // выбранный — тёмный
                : AppColors.lightBlue, // невыбранный — белый
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.white
                : AppColors.lightBlue,
          ),
        ),
      ),
      dividerColor: AppColors.aqua.withValues(alpha: .2),
    );
  }

  // Тёмная тема (Deep Ocean)
  static ThemeData dark() {
    final cs = ColorScheme.fromSeed(
      seedColor: AppColors.deepBlue,
      brightness: Brightness.dark,
      primary: AppColors.aqua,
      secondary: AppColors.seaGrass,
      surface: const Color(0xFF0F1B2D),
      onSurface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: const Color(0xFF081524),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF0F1B2D),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.aqua,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF5BE41),
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        indicatorColor: Color(0x3300AEEF),
      ),
      dividerColor: Colors.white24,
    );
  }
}
