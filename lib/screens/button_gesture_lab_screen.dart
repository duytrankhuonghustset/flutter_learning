import 'package:flutter/material.dart';

/// Ngày 11 Lab 1: nút Material và cử chỉ.
///
/// ElevatedButton / IconButton là nút có sẵn.
/// InkWell là vùng bấm có ripple. GestureDetector chỉ nhận cử chỉ, không vẽ hiệu ứng.
class ButtonGestureLabScreen extends StatefulWidget {
  const ButtonGestureLabScreen({super.key});

  @override
  State<ButtonGestureLabScreen> createState() => _ButtonGestureLabScreenState();
}

class _ButtonGestureLabScreenState extends State<ButtonGestureLabScreen> {
  int _taps = 0;

  void _bump() {
    setState(() => _taps++);
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 11 — Nút và cử chỉ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Số lần bấm: $_taps',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          const Text('ElevatedButton'),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _bump();
                  _notify('ElevatedButton');
                },
                child: const Text('Chạy'),
              ),
              const SizedBox(width: 12),
              // null = tắt: xám, không gọi hàm, không có ripple.
              const ElevatedButton(
                onPressed: null,
                child: Text('Tắt'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('IconButton'),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              tooltip: 'Bấm thêm 1 lần ',
              onPressed: () {
                _bump();
                _notify('IconButton');
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ),
          const SizedBox(height: 24),
          const Text('InkWell'),
          const SizedBox(height: 8),
          // Ink cần Material để vẽ mực. Scaffold có Material, nhưng hộp này
          // tự có Material để ripple nằm đúng trong bo góc.
          Material(
            color: scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                _bump();
                _notify('InkWell');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text('Bấm để thấy ripple'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('GestureDetector'),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _bump();
                _notify('Tap — chạm nhanh');
              },
              onLongPress: () {
                _notify('Long press — giữ lâu');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Chạm hoặc giữ'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
