import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/input_lab_screen.dart';
import 'package:flutter_learning/screens/lifecycle_lab_screen.dart';
import 'package:flutter_learning/screens/login_page.dart';

/// Stateless: không giữ isDark. Nhận value + callback từ DarkModeApp (hoist).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt — Ngày 9'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'setState chỉ rebuild widget gọi nó và con. '
              'MaterialApp đọc themeMode khi NÓ build — nên _isDark phải nằm '
              'trên DarkModeApp, không trong màn này.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SwitchListTile(
            title: const Text('Dark mode'),
            subtitle: Text(isDark ? 'Đang tối' : 'Đang sáng'),
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            value: isDark,
            onChanged: onChanged,
          ),
          ListTile(
            title: const Text('Theme.of(context).brightness'),
            subtitle: Text('$brightness — đổi Switch thì dòng này phải đổi'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.science_outlined),
            title: const Text('Lifecycle Lab'),
            subtitle: const Text('initState / build / dispose — xem Debug Console'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const LifecycleLabScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Input Lab'),
            subtitle: const Text('TextField + controller, Form một ô — Ngày 10'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const InputLabScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Đăng nhập'),
            subtitle: const Text('Form 2 ô, tài khoản cứng — Ngày 10'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
