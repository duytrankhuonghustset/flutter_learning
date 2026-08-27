import 'package:flutter/material.dart';
import 'package:flutter_learning/models/profile_data.dart';
import 'package:flutter_learning/widgets/personal_info_card.dart';

/// Màn hình Lab 2 — hiển thị PersonalInfoCard.
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Thong tin ca nhan'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView: tránh overflow dọc khi màn hình thấp / bàn phím mở.
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Center(
          child: PersonalInfoCard(data: fakeProfile),
        ),
      ),
    );
  }
}
