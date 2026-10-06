import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/product_list_page.dart';

/// Ngày 13 Lab 1: nội dung tab Home. Không tự push khi đổi tab.
///
/// Nút bên dưới là stack Ngày 12: push chi tiết sản phẩm, khác với đổi tab.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.home,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          const Text(
            'Home',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Đổi tab không thêm route trên stack.'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ProductListPage(),
                ),
              );
            },
            child: const Text('Mở danh sách sản phẩm'),
          ),
        ],
      ),
    );
  }
}
