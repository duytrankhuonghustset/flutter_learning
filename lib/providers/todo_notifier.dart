import 'package:flutter/foundation.dart';

/// Ngày 23 Lab 2: một việc. List không nằm trong State của màn.
class TodoItem {
  TodoItem({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final String id;
  final String title;
  bool isDone;
}

/// Danh sách nằm trong notifier. add/toggle xong phải notifyListeners.
class TodoNotifier extends ChangeNotifier {
  final List<TodoItem> _items = [];
  int _nextId = 0;

  List<TodoItem> get items => List.unmodifiable(_items);

  void add(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    _nextId++;
    _items.add(TodoItem(id: '$_nextId', title: trimmed));
    notifyListeners();
  }

  void toggle(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    _items[index].isDone = !_items[index].isDone;
    notifyListeners();
  }
}
