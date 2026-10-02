import 'package:flutter/material.dart';
import 'package:flutter_learning/models/product.dart';

/// Nhận đúng product lúc push. AppBar back tự pop, không viết Navigator.pop.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              formatPrice(product.price),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(product.description),
          ],
        ),
      ),
    );
  }

  String formatPrice(int price) {
    final text = price.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final conLai = text.length - i;
      if (i > 0 && conLai % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }
    return '$buffer đ';
  }
}
