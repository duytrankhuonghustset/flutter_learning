import 'package:flutter/material.dart';
import 'package:flutter_learning/models/product.dart';
import 'package:flutter_learning/screens/product_detail_page.dart';

/// Ngày 12 Lab 2: tap một dòng thì push đúng Product của dòng đó.
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static const _products = <Product>[
    Product(
      id: 'p1',
      name: 'Tai nghe',
      price: 1290000,
      description: 'Chụp tai, chống ồn nhẹ, pin khoảng 30 giờ.',
    ),
    Product(
      id: 'p2',
      name: 'Bàn phím',
      price: 890000,
      description: 'Cơ, switch nâu, layout 75%.',
    ),
    Product(
      id: 'p3',
      name: 'Chuột',
      price: 450000,
      description: 'Không dây, 6 nút, cảm biến quang.',
    ),
    Product(
      id: 'p4',
      name: 'Màn hình',
      price: 4290000,
      description: '27 inch, 144 Hz, tấm IPS.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          // Lấy item TRONG builder. Nếu onTap luôn dùng _products[0]
          // thì mọi dòng mở cùng một detail.
          final item = _products[index];
          return ListTile(
            leading: Icon(Icons.onetwothree),
            title: Text(item.name),
            subtitle: Text('${item.price}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ProductDetailPage(product: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
