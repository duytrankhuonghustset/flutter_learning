import 'package:flutter/material.dart';

/// Lab Ngày 8 — StatelessWidget vs StatefulWidget + setState.
class WidgetTypeLabScreen extends StatelessWidget {
  const WidgetTypeLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Widget Type Lab'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExperimentCard(
            title: '1) Không giữ counter trong StatelessWidget',
            explanation:
                'StatelessWidget bất biến: không có setState, Flutter không rebuild '
                'khi bạn sửa biến. Bấm nút: số trong RAM có thể tăng, Text trên UI thì không.',
            child: _BrokenStatelessCounter(),
          ),
          const SizedBox(height: 16),
          const _ExperimentCard(
            title: '2) Counter nhỏ — StatefulWidget + setState',
            explanation:
                'Đưa count vào State, tăng bên trong setState. Flutter đánh dấu dirty '
                'rồi gọi build() lại ở frame sau — số trên màn hình mới đổi.',
            child: _SmallStatefulCounter(),
          ),
          const SizedBox(height: 16),
          const _ExperimentCard(
            title: '3) CountLabel (Stateless) nhận count từ cha',
            explanation:
                'Con không cần state: chỉ vẽ theo props. Cha Stateful gọi setState, '
                'build lại, truyền count mới xuống — pattern đúng: UI tĩnh tách Stateless.',
            child: _ParentWithCountLabel(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card bọc mỗi thí nghiệm
// ---------------------------------------------------------------------------

class _ExperimentCard extends StatelessWidget {
  const _ExperimentCard({
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1) Cố tình sai: biến đếm trong StatelessWidget
// ---------------------------------------------------------------------------

/// Cố tình mutable — StatelessWidget không phải chỗ giữ counter.
// ignore: must_be_immutable
class _BrokenStatelessCounter extends StatelessWidget {
  _BrokenStatelessCounter();

  // Không final: analyzer sẽ phàn nàn (must_be_immutable). Đó là bài học.
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Bấm + : biến tăng, UI đứng yên (không setState).',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => count++,
          child: const Text('+ Tăng (không rebuild)'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 2) Cùng UI, đúng chỗ: count nằm trong State
// ---------------------------------------------------------------------------

class _SmallStatefulCounter extends StatefulWidget {
  const _SmallStatefulCounter();

  @override
  State<_SmallStatefulCounter> createState() => _SmallStatefulCounterState();
}

class _SmallStatefulCounterState extends State<_SmallStatefulCounter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$_count',
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'setState → build() lại → Text nhận số mới.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('+ Tăng'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 3) Cha Stateful, con Stateless nhận count
// ---------------------------------------------------------------------------

class _ParentWithCountLabel extends StatefulWidget {
  const _ParentWithCountLabel();

  @override
  State<_ParentWithCountLabel> createState() => _ParentWithCountLabelState();
}

class _ParentWithCountLabelState extends State<_ParentWithCountLabel> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountLabel(count: _count),
        const SizedBox(height: 8),
        const Text(
          'CountLabel không setState; cha truyền count mới mỗi lần rebuild.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            setState(() => _count++);
          },
          child: const Text('+ Tăng (cha)'),
        ),
      ],
    );
  }
}

/// Chỉ hiển thị số — UI theo props, không giữ state.
class CountLabel extends StatelessWidget {
  const CountLabel({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    );
  }
}
