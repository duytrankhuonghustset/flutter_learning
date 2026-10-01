import 'package:flutter/material.dart';
import 'package:flutter_learning/widgets/todo_tick_item.dart';

/// Ngày 11 Lab 2: cha Stateful giữ isDone, mỗi hàng là Stateless.
///
/// Title cố định. Chỉ tick đổi trạng thái.
class TodoTickScreen extends StatefulWidget {
  const TodoTickScreen({super.key});

  @override
  State<TodoTickScreen> createState() => _TodoTickScreenState();
}

class _TodoTickScreenState extends State<TodoTickScreen> {
  static const _titles = <String>[
    'Đọc về lifting state',
    'Tách TodoTickItem',
    'Gạch chữ khi xong',
  ];

  final List<bool> _done = [false, false, false];

  void _toggle(int index, bool? value) {
    setState(() => _done[index] = value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 11 — Todo tick'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _titles.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return TodoTickItem(
            title: _titles[index],
            isDone: _done[index],
            onChanged: (value) => _toggle(index, value),
          );
        },
      ),
    );
  }
}
