import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/models/product.dart';

/// Ngày 15 Lab 1: một Product → chuỗi JSON qua toJson.
class ProductToJsonLab extends StatelessWidget {
  const ProductToJsonLab({super.key});

  static const sample = Product(
    id: 'p1',
    name: 'Tai nghe',
    price: 1290000,
    description: 'Chụp tai, chống ồn nhẹ, pin khoảng 30 giờ.',
  );

  static String get jsonText {
    return const JsonEncoder.withIndent('  ').convert(sample.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lab 1 — toJson', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const Text('Product trong code → Map → chuỗi JSON.'),
        const SizedBox(height: 8),
        SelectableText(jsonText),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => debugPrint(jsonText),
          child: const Text('In JSON ra console'),
        ),
      ],
    );
  }
}

/// Ngày 15 Lab 2: Map và List hardcode → Product. Không http, không Future.
class ProductFromJsonLab extends StatelessWidget {
  const ProductFromJsonLab({super.key});

  static const oneMap = <String, dynamic>{
    'id': 'p9',
    'name': 'Sạc',
    'price': 250000,
    'description': 'USB-C, 20W.',
  };

  static const manyMaps = <Map<String, dynamic>>[
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

  @override
  Widget build(BuildContext context) {
    final one = Product.fromJson(oneMap);
    final many = Product.listFromJson(manyMaps);
    final roundTrip = Product.fromJson(ProductToJsonLab.sample.toJson());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lab 2 — fromJson', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text('Một map: ${one.name} — ${one.price}'),
        const SizedBox(height: 12),
        const Text('List map:'),
        for (final product in many)
          Text('• ${product.name} — ${product.price}'),
        const SizedBox(height: 12),
        Text(
          'Khứ hồi toJson → fromJson: ${roundTrip.name} (${roundTrip.id})',
        ),
      ],
    );
  }
}

/// Màn gộp hai lab để chạy trên app. Mỗi lab là một widget riêng.
class ProductJsonLabScreen extends StatelessWidget {
  const ProductJsonLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 15 — Model JSON'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          ProductToJsonLab(),
          SizedBox(height: 24),
          Divider(),
          SizedBox(height: 24),
          ProductFromJsonLab(),
        ],
      ),
    );
  }
}
