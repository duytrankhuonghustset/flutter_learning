import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/async_lab_screen.dart';
import 'package:flutter_learning/screens/product_json_lab_screen.dart';

/// Ngày 13 Lab 1: tab Profile chỉ là placeholder.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          const Text(
            'Profile',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Cùng Scaffold với Home và Search.'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ProductJsonLabScreen(),
                ),
              );
            },
            child: const Text('Ngày 15 — Model JSON'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const AsyncLabScreen(),
                ),
              );
            },
            child: const Text('Ngày 16 — Async'),
          ),
        ],
      ),
    );
  }
}
