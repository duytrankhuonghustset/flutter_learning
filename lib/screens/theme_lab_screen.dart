import 'package:flutter/material.dart';
import 'package:flutter_learning/theme/app_theme.dart';

/// Ngày 26 Lab 2: màu lấy từ colorScheme, tự theo sáng/tối.
class ThemeLabScreen extends StatelessWidget {
  const ThemeLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 26 — Theme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: scheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thẻ theo ColorScheme', style: theme.titleStyle),
                const SizedBox(height: 8),
                Text(
                  'Các màu này theo sáng/tối tự động.',
                  style: theme.mutedBody,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  color: scheme.primary,
                  child: Text(
                    'primary / onPrimary',
                    style: TextStyle(color: scheme.onPrimary),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'surface / onSurface',
                  style: TextStyle(color: scheme.onSurface),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
