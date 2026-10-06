import 'package:flutter/material.dart';
import 'package:flutter_learning/models/post.dart';
import 'package:flutter_learning/services/post_api.dart';

/// Ngày 25 Lab 2: màn chỉ gọi PostApiService, không gọi HTTP trực tiếp.
class ApiServiceLabScreen extends StatefulWidget {
  const ApiServiceLabScreen({super.key});

  @override
  State<ApiServiceLabScreen> createState() => _ApiServiceLabScreenState();
}

class _ApiServiceLabScreenState extends State<ApiServiceLabScreen> {
  final PostApiService _api = PostApiService();

  bool _loading = true;
  String? _error;
  List<Post> _posts = const [];

  @override
  void initState() {
    super.initState();
    // Đã loading. Không setState trước await lúc mở màn.
    _fetch();
  }

  /// Lab 2: lỗi hiện một dòng. Sau await phải còn mounted.
  Future<void> _fetch() async {
    try {
      final posts = await _api.fetchPosts();
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = null;
        _posts = posts;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _posts = const [];
        _error = '$error';
      });
    }
  }

  void _reload() {
    setState(() {
      _loading = true;
      _error = null;
    });
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 25 — ApiService'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lab 2 — list chỉ gọi service',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text('Màn này không gọi http.get.'),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _loading ? null : _reload,
                  child: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Tải lại'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_posts[index].title));
              },
            ),
          ),
        ],
      ),
    );
  }
}
