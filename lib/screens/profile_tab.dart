import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/api_service_lab_screen.dart';
import 'package:flutter_learning/screens/asset_lab_screen.dart';
import 'package:flutter_learning/screens/folder_map_screen.dart';
import 'package:flutter_learning/screens/async_lab_screen.dart';
import 'package:flutter_learning/screens/posts_lab_screen.dart';
import 'package:flutter_learning/screens/posts_state_screen.dart';
import 'package:flutter_learning/screens/prefs_lab_screen.dart';
import 'package:flutter_learning/screens/product_json_lab_screen.dart';
import 'package:flutter_learning/screens/provider_lab_screen.dart';
import 'package:flutter_learning/screens/setstate_limit_screen.dart';
import 'package:flutter_learning/screens/theme_lab_screen.dart';

/// Ngày 13 Lab 1: tab Profile chỉ là placeholder.
class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
    this.isDark = false,
    this.onDarkModeChanged,
  });

  /// Ngày 19: tùy chọn để call site cũ vẫn dựng được ProfileTab().
  final bool isDark;
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Cùng Scaffold với Home và Search.'),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ProductJsonLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 15 — Model JSON'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const AsyncLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 16 — Async'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const PostsLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 17 — API'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const PostsStateScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 18 — Trạng thái'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => PrefsLabScreen(
                            isDark: isDark,
                            onDarkModeChanged: onDarkModeChanged ?? (_) {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Ngày 19 — Lưu trữ'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const AssetLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 20 — Asset'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const SetStateLimitScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 22 — setState'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ProviderLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 23 — Provider'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const FolderMapScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 24 — Thư mục'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ApiServiceLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 25 — ApiService'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ThemeLabScreen(),
                        ),
                      );
                    },
                    child: const Text('Ngày 26 — Theme'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
