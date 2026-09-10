import 'package:flutter/material.dart';

/// Lab lifecycle: initState (1 lần) → build (nhiều lần) → dispose (khi rời cây).
///
/// Xem log trong Debug Console: `[Lab parent]` / `[Lab child]` / `[Lab page]`.
class LifecycleLabScreen extends StatefulWidget {
  const LifecycleLabScreen({super.key});

  @override
  State<LifecycleLabScreen> createState() => _LifecycleLabScreenState();
}

class _LifecycleLabScreenState extends State<LifecycleLabScreen> {
  int _ticks = 0;
  bool _showChild = true;

  @override
  void initState() {
    super.initState();
    debugPrint('[Lab parent] initState');
  }

  @override
  void dispose() {
    debugPrint('[Lab parent] dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[Lab parent] build  (ticks=$_ticks, showChild=$_showChild)');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle Lab'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Parent build lần: $_ticks (mỗi setState +1). '
            'initState parent chỉ khi mở màn này lần đầu.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _Card(
            title: '1) setState — chỉ build lặp lại',
            explanation:
                'setState đánh dấu State dirty rồi gọi build() ở frame sau. '
                'Không tạo State mới → không initState, không dispose. '
                'Con vẫn trên cây nên cũng chỉ build (nếu parent rebuild).',
            child: FilledButton(
              onPressed: () {
                setState(() => _ticks++);
              },
              child: const Text('setState (parent)'),
            ),
          ),
          const SizedBox(height: 16),
          _Card(
            title: '2) Hiện / ẩn widget con — dispose + initState mới',
            explanation:
                'if (_showChild) gỡ con khỏi cây → dispose. Bật lại → State mới → '
                'initState rồi build. Khác setState: đây mới “chết / sinh lại”.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Hiện widget con'),
                  value: _showChild,
                  onChanged: (value) {
                    setState(() => _showChild = value);
                  },
                ),
                if (_showChild) const _LoggedChild(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Card(
            title: '3) Navigator.push — dispose khi pop',
            explanation:
                'Màn mới có State riêng: push → initState + build. Back → dispose. '
                'Màn lab này vẫn trên stack nên parent không dispose, không initState lại.',
            child: FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const _LoggedPage(),
                  ),
                );
              },
              child: const Text('Mở màn con (rồi Back)'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.explanation,
    required this.child,
  });

  final String title;
  final String explanation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

/// Con có State riêng — ẩn/hiện để thấy dispose rồi initState mới.
class _LoggedChild extends StatefulWidget {
  const _LoggedChild();

  @override
  State<_LoggedChild> createState() => _LoggedChildState();
}

class _LoggedChildState extends State<_LoggedChild> {
  @override
  void initState() {
    super.initState();
    debugPrint('[Lab child] initState');
  }

  @override
  void dispose() {
    debugPrint('[Lab child] dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[Lab child] build');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Con còn trên cây.\n'
        'Tắt Switch → dispose; bật lại → initState mới.',
        style: TextStyle(height: 1.4),
      ),
    );
  }
}

/// Route riêng: Back gỡ State này → dispose. Lab ở dưới stack không chết.
class _LoggedPage extends StatefulWidget {
  const _LoggedPage();

  @override
  State<_LoggedPage> createState() => _LoggedPageState();
}

class _LoggedPageState extends State<_LoggedPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('[Lab page] initState');
  }

  @override
  void dispose() {
    debugPrint('[Lab page] dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[Lab page] build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn con (lifecycle)'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Console: [Lab page] initState rồi build.\n'
            'Bấm Back: [Lab page] dispose.\n'
            'Không thấy [Lab parent] dispose.',
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.5),
          ),
        ),
      ),
    );
  }
}
