import 'package:flutter/material.dart';

/// Ngày 24 Lab 1: năm thư mục, mỗi thư mục một việc.
class FolderMapScreen extends StatelessWidget {
  const FolderMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 24 — Thư mục'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('models — dữ liệu thuần: Product, Post, hồ sơ.'),
            SizedBox(height: 12),
            Text('screens — một màn hình, thường có Scaffold.'),
            SizedBox(height: 12),
            Text('widgets — mảnh UI dùng lại, không phải cả màn.'),
            SizedBox(height: 12),
            Text('services — gọi mạng hoặc đọc prefs, UI không gọi http.'),
            SizedBox(height: 12),
            Text('providers — ChangeNotifier; màn chỉ watch hoặc read.'),
          ],
        ),
      ),
    );
  }
}
