import 'package:flutter/material.dart';

class AppColors {
  // Светлые и фоновые
  static const white = Colors.white;
  static const mint = Color(0xFFE6F7FB);        // мягкая панель
  static const lightBlue = Color(0xFFA9E3EF);   // светло-голубой для градиента

  // Средние и акцентные
  static const aqua = Color(0xFF00AEEF);        // яркий акцент
  static const seaGrass = Color(0xFF13C2C2);    // зеленовато-голубой
  static const teal = Color(0xFF007FAF);        // более глубокий

  // Тёмные и опорные
  static const deepBlue = Color(0xFF0E3A69);    // опорный тёмный
  static const ink = Color(0xFF1F2933);         // тёмный текст
  static const softInk = Color(0xFF586174);     // вторичный текст

  // универсальный градиент (слева-сверху → вправо-вниз)
  static const gradientAqua = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightBlue, aqua, teal, deepBlue],
    stops: [0.30, 0.50, 0.75, 0.90],
  );

  static const gradientOcean = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepBlue, teal, aqua],
    stops: [0.05, 0.6, 1.0],
  );
}
