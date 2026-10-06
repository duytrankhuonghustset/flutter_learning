import 'package:flutter/material.dart';

/// Ngày 26: light/dark một chỗ. MaterialApp chỉ gọi hai hàm này.
class AppTheme {
  static const Color seed = Colors.indigo;

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

/// Chữ dùng lại: màu lấy từ colorScheme, không gán Colors.*.
extension AppTextStyles on ThemeData {
  TextStyle get titleStyle => (textTheme.titleLarge ?? const TextStyle()).copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      );

  TextStyle get mutedBody => (textTheme.bodyMedium ?? const TextStyle()).copyWith(
        color: colorScheme.onSurfaceVariant,
      );
}
