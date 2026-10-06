import 'package:flutter/material.dart';
import 'package:flutter_learning/providers/counter_notifier.dart';
import 'package:flutter_learning/providers/todo_notifier.dart';
import 'package:provider/provider.dart';

/// State cả app sẽ nằm trên MaterialApp; hôm nay Provider chỉ bọc màn lab, không chuyển dark mode.
class ProviderLabScreen extends StatefulWidget {
  const ProviderLabScreen({super.key});

  @override
  State<ProviderLabScreen> createState() => _ProviderLabScreenState();
}

/// State chỉ giữ ô nhập. List todo nằm trong TodoNotifier.
class _ProviderLabScreenState extends State<ProviderLabScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 23 — Provider'),
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
            'Mỗi lab một Provider riêng. Counter và todo không dùng chung notifier.',
          ),
          const SizedBox(height: 24),
          Text(
            'Lab 1 — Counter',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const _CounterLab(),
          const SizedBox(height: 32),
          Text(
            'Lab 2 — Todo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Danh sách nằm trong TodoNotifier. Màn này không giữ List.',
          ),
          const SizedBox(height: 12),
          _TodoLab(controller: _titleController),
        ],
      ),
    );
  }
}

/// Lab 1: provider chỉ bọc khu counter.
class _CounterLab extends StatelessWidget {
  const _CounterLab();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterNotifier(),
      child: const _CounterBody(),
    );
  }
}

class _CounterBody extends StatelessWidget {
  const _CounterBody();

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterNotifier>().count;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'watch dựng lại widget này; read không đăng ký nghe.',
        ),
        const SizedBox(height: 12),
        Text('Số: $count', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => context.read<CounterNotifier>().increment(),
          child: const Text('Tăng'),
        ),
      ],
    );
  }
}

/// Lab 2: provider todo riêng, không chia sẻ với counter.
class _TodoLab extends StatelessWidget {
  const _TodoLab({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoNotifier(),
      child: _TodoBody(controller: controller),
    );
  }
}

class _TodoBody extends StatelessWidget {
  const _TodoBody({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final items = context.watch<TodoNotifier>().items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Việc cần làm',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _add(context),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () => _add(context),
              child: const Text('Thêm'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const Text('Chưa có việc.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: item.isDone,
                title: Text(item.title),
                onChanged: (_) =>
                    context.read<TodoNotifier>().toggle(item.id),
              );
            },
          ),
      ],
    );
  }

  void _add(BuildContext context) {
    context.read<TodoNotifier>().add(controller.text);
    controller.clear();
  }
}
