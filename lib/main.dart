import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/main_shell_page.dart';

void main() {
  runApp(const DarkModeApp());
}

/// Ngày 9: state theme nằm TRÊN MaterialApp.
///
/// setState ở đây → build lại → MaterialApp nhận themeMode mới → cả cây đổi theme.
/// Nếu _isDark chỉ nằm ở Settings, Switch đổi state con nhưng MaterialApp không rebuild.
class DarkModeApp extends StatefulWidget {
  const DarkModeApp({super.key});

  @override
  State<DarkModeApp> createState() => _DarkModeAppState();
}

class _DarkModeAppState extends State<DarkModeApp> {
  final bool _isDark = false;

  @override
  void initState() {
    super.initState();
    debugPrint('[DarkModeApp] initState  isDark=$_isDark');
  }

  @override
  void dispose() {
    debugPrint('[DarkModeApp] dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cấm setState ở đây — build chỉ ĐỌC _isDark rồi vẽ.
    debugPrint('[DarkModeApp] build  isDark=$_isDark');

    return MaterialApp(
      title: 'Ngày 13 — 3 tab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: const MainShellPage(),
    );
  }
}

/// Màn hình Profile — luyện widget cơ bản Ngày 3.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = khung màn hình (AppBar + body).
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // AppBar = thanh tiêu đề phía trên.
      appBar: AppBar(
        title: const Text('Hồ sơ của tôi'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // Container = hộp trang trí: padding, margin, màu, bo góc.
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          // Column = xếp widget theo chiều dọc.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image = ảnh đại diện (mạng); lỗi thì hiện Icon.
              ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?img=12',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.indigo.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 56,
                        color: Colors.indigo,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Text = tên.
              const Text(
                'Nguyen Van A',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Text = mô tả ngắn.
              const Text(
                'Flutter learner · Thích xây app đẹp và đơn giản',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              // Icon + Text: email, phone, địa chỉ.
              const _InfoRow(
                icon: Icons.email,
                label: 'nguyenvana@email.com',
              ),
              const SizedBox(height: 12),
              const _InfoRow(
                icon: Icons.phone,
                label: '+84 912 345 678',
              ),
              const SizedBox(height: 12),
              const _InfoRow(
                icon: Icons.location_on,
                label: 'Ha Noi, Viet Nam',
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: () {

              }, child: Text("Đăng ký"))
            ],
          ),
        ),
      ),
    );
  }
}

/// Một dòng thông tin: Icon + Text.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
