import 'package:flutter/material.dart';

/// 20 title cứng. Lab không gọi mạng.
const _titles = <String>[
  'Widget mô tả UI',
  'Element giữ vị trí trên cây',
  'State sống lâu hơn build',
  'setState chỉ dirty một State',
  'build cha chạy lại',
  'Con nhận widget mới thì build',
  'const cùng instance thì bỏ qua',
  'List và nút chung build',
  'Đổi loading vẫn dựng list',
  'PostsLabScreen là ví dụ',
  'Tách Stateless chưa đủ',
  'setState phải rời khỏi list',
  'TapCounter giữ số lần bấm',
  'TitleList chỉ nhận title',
  'Badge list đứng yên',
  'Badge counter tăng',
  'UI cục bộ thì setState đủ',
  'Nhiều màn thì chưa đủ',
  'isDark đang truyền tay',
  'Ngày 23 mới tới Provider',
];

/// Ngày 22: Lab 1 cho thấy setState ở cha dựng lại list.
/// Lab 2 để TapCounter tự setState, list không nằm trong State đó.
///
/// PostsLabScreen: setState đầu _load chỉ đổi loading, nhưng ListView
/// title cùng build nên vẫn dựng lại. Màn này dùng title cứng để đếm build.
class SetStateLimitScreen extends StatelessWidget {
  const SetStateLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 22 — setState'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Lab 1 và Lab 2',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'setState đủ cho UI cục bộ trên một màn. Không đủ khi cùng một dữ liệu hiện trên nhiều màn — Ngày 23 mới dùng Provider, hôm nay không thêm.',
          ),
          const SizedBox(height: 24),
          Text(
            'Lab 1 — setState ở cha',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Nút và list cùng một State. Bấm tăng chỉ đổi số, badge list vẫn tăng.',
          ),
          const SizedBox(height: 12),
          const _WideRebuildLab(titles: _titles),
          const SizedBox(height: 32),
          Text(
            'Lab 2 — setState ở TapCounter',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Counter tự setState. List là anh em, không nằm trong build của counter.',
          ),
          const SizedBox(height: 12),
          const _NarrowRebuildLab(),
        ],
      ),
    );
  }
}

/// Lab 1: cha giữ _tapCount và dựng TitleList trong cùng build.
class _WideRebuildLab extends StatefulWidget {
  const _WideRebuildLab({required this.titles});

  final List<String> titles;

  @override
  State<_WideRebuildLab> createState() => _WideRebuildLabState();
}

class _WideRebuildLabState extends State<_WideRebuildLab> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Lab 1: không const badge — instance mới thì build chạy và số tăng.
        RebuildBadge(id: 'lab1-counter', label: 'Counter Lab 1'),
        Text('Số lần bấm: $_tapCount'),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => setState(() => _tapCount++),
          child: const Text('Tăng — Lab 1'),
        ),
        const SizedBox(height: 8),
        // Lab 1: không const TitleList. const cùng instance thì badge không tăng.
        TitleList(titles: widget.titles, badgeId: 'lab1-list'),
      ],
    );
  }
}

/// Lab 2: State của counter không chứa list.
class _NarrowRebuildLab extends StatelessWidget {
  const _NarrowRebuildLab();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TapCounter(),
        SizedBox(height: 8),
        TitleList(titles: _titles, badgeId: 'lab2-list'),
      ],
    );
  }
}

/// Lab 2: chỉ State này setState khi tăng. List không được dựng ở đây.
class TapCounter extends StatefulWidget {
  const TapCounter({super.key});

  @override
  State<TapCounter> createState() => _TapCounterState();
}

class _TapCounterState extends State<TapCounter> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Lab 2: không const, để mỗi setState của counter làm badge tăng.
        RebuildBadge(id: 'lab2-counter', label: 'Counter Lab 2'),
        Text('Số lần bấm: $_tapCount'),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => setState(() => _tapCount++),
          child: const Text('Tăng — Lab 2'),
        ),
      ],
    );
  }
}

/// Lab 2: nhận list, không giữ số lần bấm.
class TitleList extends StatelessWidget {
  const TitleList({super.key, required this.titles, required this.badgeId});

  final List<String> titles;
  final String badgeId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RebuildBadge(id: badgeId, label: 'List $badgeId'),
        SizedBox(
          height: 140,
          child: ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(titles[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Đếm số lần build. Field trên widget mất vì cha tạo instance mới mỗi lần,
/// nên số nằm ở map tĩnh theo [id].
class RebuildBadge extends StatelessWidget {
  const RebuildBadge({super.key, required this.id, required this.label});

  final String id;
  final String label;

  static final Map<String, int> _counts = {};

  @override
  Widget build(BuildContext context) {
    final count = (_counts[id] ?? 0) + 1;
    _counts[id] = count;
    debugPrint('RebuildBadge $id: $count');
    return Text('$label — build lần $count');
  }
}
