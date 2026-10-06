import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/home_tab.dart';
import 'package:flutter_learning/screens/profile_tab.dart';
import 'package:flutter_learning/screens/search_tab.dart';

/// Ngày 13: một shell, một index.
///
/// Lab 1 — BottomNavigationBar đổi body, không Navigator.push khi bấm tab.
/// Lab 2 — Drawer dùng cùng [_index]; pop chỉ đóng menu.
/// IndexedStack giữ State của tab Search khi đổi tab.
class MainShellPage extends StatefulWidget {
  const MainShellPage({
    super.key,
    this.isDark = false,
    this.onDarkModeChanged,
  });

  /// Ngày 19: theme vẫn do DarkModeApp giữ. Shell chỉ chuyển tiếp.
  final bool isDark;
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  static const _titles = ['Home', 'Search', 'Profile'];

  int _index = 0;

  void _selectTab(int index) {
    setState(() => _index = index);
  }

  /// Drawer là route phụ. pop gỡ drawer, không gỡ shell.
  void _selectTabFromDrawer(int index) {
    Navigator.pop(context);
    _selectTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // Ngày 26: header menu theo theme, không khóa Colors.indigo.
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _DrawerTabTile(
              icon: Icons.home,
              label: 'Home',
              selected: _index == 0,
              onTap: () => _selectTabFromDrawer(0),
            ),
            _DrawerTabTile(
              icon: Icons.search,
              label: 'Search',
              selected: _index == 1,
              onTap: () => _selectTabFromDrawer(1),
            ),
            _DrawerTabTile(
              icon: Icons.person,
              label: 'Profile',
              selected: _index == 2,
              onTap: () => _selectTabFromDrawer(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings — chỉ đóng menu')),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          const HomeTab(),
          const SearchTab(),
          ProfileTab(
            isDark: widget.isDark,
            onDarkModeChanged: widget.onDarkModeChanged,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _DrawerTabTile extends StatelessWidget {
  const _DrawerTabTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      onTap: onTap,
    );
  }
}
