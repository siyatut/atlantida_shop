import 'package:flutter/material.dart';

class AppTypography {
  static const _baseFamily = 'SF Pro Display'; 

  static TextTheme lightTextTheme(ColorScheme cs) => TextTheme(
        headlineSmall: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          height: 1.2,
          color: cs.onSurface,
        ),
        titleLarge: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: cs.onSurface,
        ),
        titleMedium: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 17,
          fontWeight: FontWeight.w800,
          height: 1.25,
          color: cs.onSurface,
        ),
        bodyLarge: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.35,
          color: cs.onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.35,
          color: cs.onSurface,
        ),
        labelLarge: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: cs.onSurface,
        ),
        labelMedium: TextStyle(
          fontFamily: _baseFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: cs.onSurface.withValues(alpha: .7),
        ),
      );
}
