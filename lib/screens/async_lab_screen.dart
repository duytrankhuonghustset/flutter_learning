import 'package:flutter/material.dart';
import 'package:flutter_learning/models/product.dart';

/// Map cùng dạng Ngày 15 / list Ngày 12. Không gọi mạng.
const _fakeProductMaps = <Map<String, dynamic>>[
  {
    'id': 'p1',
    'name': 'Tai nghe',
    'price': 1290000,
    'description': 'Chụp tai, chống ồn nhẹ, pin khoảng 30 giờ.',
  },
  {
    'id': 'p2',
    'name': 'Bàn phím',
    'price': 890000,
    'description': 'Cơ, switch nâu, layout 75%.',
  },
  {
    'id': 'p3',
    'name': 'Chuột',
    'price': 450000,
    'description': 'Không dây, 6 nút, cảm biến quang.',
  },
];

/// Giả lập mạng: chờ rồi trả list hoặc ném lỗi.
///
/// `fail` để Lab 2 bật lỗi giả. Ngày 17 thay thân hàm bằng HTTP thật.
Future<List<Product>> fakeFetchProducts({bool fail = false}) async {
  await Future.delayed(const Duration(seconds: 2));
  if (fail) {
    throw Exception('Giả lập lỗi: không tải được sản phẩm');
  }
  return Product.listFromJson(_fakeProductMaps);
}

/// Ngày 16 Lab 1: nút gọi async, setState khi xong. Không FutureBuilder.
class FutureSetStateLab extends StatefulWidget {
  const FutureSetStateLab({super.key});

  @override
  State<FutureSetStateLab> createState() => _FutureSetStateLabState();
}

class _FutureSetStateLabState extends State<FutureSetStateLab> {
  bool _loading = false;
  String _status = 'Chưa tải. Bấm nút để chờ 2 giây.';
  List<Product> _products = const [];

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _status = 'Đang tải...';
      _products = const [];
    });

    try {
      final products = await fakeFetchProducts();
      // User có thể pop màn trong lúc chờ. setState lúc đó sẽ lỗi.
      if (!mounted) return;
      setState(() {
        _loading = false;
        _products = products;
        _status = 'Xong: ${products.length} sản phẩm';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _status = 'Lỗi: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lab 1 — Future + setState',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Bấm nút, chờ, rồi setState. Không dùng FutureBuilder.',
        ),
        const SizedBox(height: 12),
        FilledButton(
          // Khóa nút để không bắn hai Future chồng lên nhau.
          onPressed: _loading ? null : _load,
          child: const Text('Tải sản phẩm'),
        ),
        const SizedBox(height: 12),
        if (_loading) const CircularProgressIndicator(),
        if (_loading) const SizedBox(height: 12),
        Text(_status),
        const SizedBox(height: 8),
        for (final product in _products)
          Text('• ${product.name} — ${product.price}'),
      ],
    );
  }
}

/// Ngày 16 Lab 2: FutureBuilder. Future nằm trong State, không tạo trong build.
class FutureBuilderLab extends StatefulWidget {
  const FutureBuilderLab({super.key});

  @override
  State<FutureBuilderLab> createState() => _FutureBuilderLabState();
}

class _FutureBuilderLabState extends State<FutureBuilderLab> {
  bool _fail = false;
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = fakeFetchProducts(fail: _fail);
  }

  void _reload({bool? fail}) {
    setState(() {
      _fail = fail ?? _fail;
      // Future mới chỉ khi bấm hoặc đổi cờ. build chỉ đọc _future.
      _future = fakeFetchProducts(fail: _fail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lab 2 — FutureBuilder',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Ba trạng thái: đang chờ, lỗi, danh sách. Thử lại tạo Future mới.',
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Giả lập lỗi'),
            Switch(
              value: _fail,
              onChanged: (value) => _reload(fail: value),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () => _reload(),
          child: const Text('Thử lại'),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<Product>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Lỗi: ${snapshot.error}');
            }
            final products = snapshot.data;
            if (products == null) {
              return const Text('Chưa có dữ liệu');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thành công: ${products.length} sản phẩm'),
                const SizedBox(height: 8),
                for (final product in products)
                  Text('• ${product.name} — ${product.price}'),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Màn gộp hai lab. Mỗi lab là một widget riêng.
class AsyncLabScreen extends StatelessWidget {
  const AsyncLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 16 — Async'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          FutureSetStateLab(),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          FutureBuilderLab(),
        ],
      ),
    );
  }
}
