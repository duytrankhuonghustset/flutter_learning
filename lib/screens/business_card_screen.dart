import 'package:flutter/material.dart';
import 'package:flutter_learning/widgets/business_card.dart';

/// Màn Ngày 5 — hiển thị BusinessCard (styling).
class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Business Card'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // Padding quanh card; ScrollView tránh overflow dọc trên màn thấp.
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: BusinessCard(data: fakeBusinessCard),
      ),
    );
  }
}
