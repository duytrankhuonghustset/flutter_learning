import 'package:flutter/material.dart';

/// Màn đếm — Stateful vì _count đổi khi bấm nút.
class CounterHomePage extends StatefulWidget {
  const CounterHomePage({super.key});

  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  int _count = 0;
  final int _step = 5;

  void _increment() {
    setState(() {
      _count = _count + _step;
    });
  }

  void _decrement() {
    if (_count == 0) return;
    setState(() {
      _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Counter Ngày 8'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Số lần bấm:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            CounterValue(count: _count),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: _count == 0 ? null : _decrement,
                  icon: const Icon(Icons.remove),
                  tooltip: 'Giảm',
                ),
                const SizedBox(width: 16),
                IconButton.filled(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  tooltip: 'Tăng',
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Chỉ vẽ số — Stateless: không giữ biến đếm, nhận count từ cha.
class CounterValue extends StatelessWidget {
  const CounterValue({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: count > 9 ? Colors.blue : Colors.amber
      ),
    );
  }
}
