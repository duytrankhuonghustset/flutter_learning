import 'package:flutter/material.dart';

/// Ngày 20: Lab 1 ảnh asset/network, Lab 2 fontFamily.
class AssetLabScreen extends StatelessWidget {
  const AssetLabScreen({super.key});

  /// Lab 1: file đã khai báo trong pubspec, bundle cùng app.
  static const _localAsset = 'assets/images/local_mark.png';

  /// Lab 1: URL chỉ tải được khi có internet.
  static const _networkUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';

  /// Lab 2: trùng family trong pubspec, không trùng tên file ttf.
  static const _fontFamily = 'LearnDay20';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 20 — Asset'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Lab 1 — Ảnh',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Asset nằm trong app. Ảnh mạng cần internet. Mất mạng thì errorBuilder.',
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _LocalImage()),
              SizedBox(width: 12),
              Expanded(child: _NetworkImage()),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Lab 2 — Font',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Dòng dưới dùng fontFamily. Sửa asset hoặc font trong pubspec thì hot restart.',
          ),
          const SizedBox(height: 12),
          const Text(
            'Day 20 Font',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Day 20 Font',
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
    );
  }
}

/// Lab 1: Image.asset không gọi mạng.
class _LocalImage extends StatelessWidget {
  const _LocalImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Asset'),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            AssetLabScreen._localAsset,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

/// Lab 1: Image.network có errorBuilder khi URL lỗi hoặc mất mạng.
class _NetworkImage extends StatelessWidget {
  const _NetworkImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Network'),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            AssetLabScreen._networkUrl,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                height: 140,
                width: double.infinity,
                child: ColoredBox(
                  color: Color(0xFFE0E0E0),
                  child: Center(
                    child: Text(
                      'Không tải được ảnh mạng',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
