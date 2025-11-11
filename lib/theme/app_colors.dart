import 'package:flutter/material.dart';

class AppColors {
  // Базовая палитра (Aqua → Teal → Mint)
  static const aqua      = Color(0xFF00AEEF); // яркий акцент
  static const teal      = Color(0xFF007FAF); // более глубокий
  static const mint      = Color(0xFFE6F7FB); // очень светлый фон
  static const seaGrass  = Color(0xFF13C2C2); // зеленовато-голубой
  static const deepBlue  = Color(0xFF0E3A69); // опорный тёмный
  static const ink       = Color(0xFF1F2933); // тёмный текст
  static const softInk   = Color(0xFF586174); // вторичный текст
  static const white     = Colors.white;
  static Color navGlassStartLight = mint.withValues(alpha: .14); // верх бара
  static Color navGlassEndTeal    = teal.withValues(alpha: .22); // низ бара

  // универсальный градиент (слева-сверху → вправо-вниз)
  static const gradientAqua = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mint, aqua, teal],
    stops: [0.05, 0.55, 1.0],
  );

  static const gradientOcean = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepBlue, teal, aqua],
    stops: [0.05, 0.6, 1.0],
  );
}
