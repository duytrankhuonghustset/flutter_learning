import 'package:flutter/material.dart';

/// Một hàng todo. Stateless: không giữ isDone.
///
/// Cha truyền isDone và onChanged. Cha setState thì widget này build lại với bool mới.
class TodoTickItem extends StatelessWidget {
  const TodoTickItem({
    super.key,
    required this.title,
    required this.isDone,
    required this.onChanged,
  });

  final String title;
  final bool isDone;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = TextStyle(
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
      color: isDone ? scheme.onSurfaceVariant : scheme.onSurface,
      fontStyle: isDone ? FontStyle.italic : FontStyle.normal
    );

    return Row(
      children: [
        Checkbox(
          value: isDone,
          onChanged: onChanged,
        ),
        Expanded(
          // Không bọc Checkbox bằng InkWell. Cả hai cùng nhận một cú chạm
          // thì onChanged chạy hai lần và tick bật rồi tắt ngay.
          // onLongPress hiện SnackBar chứa title. Checkbox để nguyên.
          child: GestureDetector(
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("show snack bar"))
              );
            },
            child: Text(title, style: style),
          ),
        ),
      ],
    );
  }
}
