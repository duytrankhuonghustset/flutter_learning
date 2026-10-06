import 'package:flutter/material.dart';
import 'package:flutter_learning/services/prefs_store.dart';

/// Ngày 19: Lab 1 lưu tên, Lab 2 Switch dark mode.
///
/// Theme không nằm ở màn này. Switch chỉ ghi prefs rồi gọi callback lên DarkModeApp.
class PrefsLabScreen extends StatefulWidget {
  const PrefsLabScreen({
    super.key,
    required this.isDark,
    required this.onDarkModeChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<PrefsLabScreen> createState() => _PrefsLabScreenState();
}

class _PrefsLabScreenState extends State<PrefsLabScreen> {
  final _nameController = TextEditingController();

  /// Lab 1: chuỗi đọc lại từ prefs, không phải chữ đang gõ.
  String _readBackName = '';
  bool _loading = true;

  /// Lab 2: Switch giữ local vì route push không nhận isDark mới từ cha.
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _load();
  }

  @override
  void didUpdateWidget(PrefsLabScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      _isDark = widget.isDark;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Mở màn: đọc tên và cờ dark đã lưu.
  Future<void> _load() async {
    final name = await getUserName();
    final isDark = await getIsDark();
    if (!mounted) return;
    setState(() {
      _readBackName = name;
      _nameController.text = name;
      _isDark = isDark;
      _loading = false;
    });
  }

  /// Lab 1: ghi rồi đọc lại để chứng minh vòng khứ hồi.
  Future<void> _saveName() async {
    await setUserName(_nameController.text);
    final readBack = await getUserName();
    if (!mounted) return;
    setState(() => _readBackName = readBack);
  }

  /// Lab 2: ghi bool, báo app đổi themeMode ngay.
  Future<void> _onDarkChanged(bool value) async {
    setState(() => _isDark = value);
    await setIsDark(value);
    if (!mounted) return;
    widget.onDarkModeChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 19 — Lưu trữ'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Lab 1 — Tên',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lưu một String. Dòng dưới là giá trị đọc lại từ máy.',
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên hiển thị',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    _saveName();
                  },
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    _saveName();
                  },
                  child: const Text('Lưu'),
                ),
                const SizedBox(height: 12),
                Text(
                  _readBackName.isEmpty
                      ? 'Đã đọc: (chưa có tên)'
                      : 'Đã đọc: $_readBackName',
                ),
                const SizedBox(height: 32),
                Text(
                  'Lab 2 — Dark mode',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Switch ghi bool và báo DarkModeApp đổi theme. Tắt hẳn app rồi mở lại để thấy còn lưu.',
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Chế độ tối'),
                  value: _isDark,
                  onChanged: (value) {
                    _onDarkChanged(value);
                  },
                ),
              ],
            ),
    );
  }
}
