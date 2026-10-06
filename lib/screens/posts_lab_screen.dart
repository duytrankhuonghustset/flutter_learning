import 'package:flutter/material.dart';
import 'package:flutter_learning/models/post.dart';
import 'package:flutter_learning/services/post_api.dart';

/// Ngày 17: Lab 1 đếm bài sau GET. Lab 2 hiện title.
///
/// Cùng một lần fetch. ListView dùng [_posts] đã có, không tạo Future trong build.
class PostsLabScreen extends StatefulWidget {
  const PostsLabScreen({super.key});

  @override
  State<PostsLabScreen> createState() => _PostsLabScreenState();
}

class _PostsLabScreenState extends State<PostsLabScreen> {
  bool _loading = false;
  String _status = 'Chưa tải.';
  String? _error;
  List<Post> _posts = const [];

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _status = 'Đang tải...';
    });

    try {
      final posts = await fetchPosts();
      if (!mounted) return;
      setState(() {
        _loading = false;
        _posts = posts;
        _status = 'Đã tải: ${posts.length} bài';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _posts = const [];
        _error = '$error';
        _status = 'Không tải được';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 17 — API'),
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
                  'Lab 1 — đếm bài',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(_status),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _loading ? null : _load,
                  child: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Tải bài viết'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Text(
              'Lab 2 — title',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
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
