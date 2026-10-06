import 'package:flutter/material.dart';
import 'package:flutter_learning/models/post.dart';
import 'package:flutter_learning/services/post_api.dart';

/// Lab 1: đúng một trạng thái. Hai bool dễ bật spinner lẫn chữ lỗi.
enum PostLoadStatus { loading, error, empty, data }

/// Ngày 18: bốn trạng thái khi tải posts. Lab 2 là nút Thử lại.
///
/// Không sửa hành vi màn Ngày 17. Fetch qua [PostApiService], không http.get.
class PostsStateScreen extends StatefulWidget {
  const PostsStateScreen({super.key});

  @override
  State<PostsStateScreen> createState() => _PostsStateScreenState();
}

class _PostsStateScreenState extends State<PostsStateScreen> {
  /// Ngày 25: State gọi service, không gọi http.get.
  final PostApiService _api = PostApiService();

  PostLoadStatus _status = PostLoadStatus.loading;
  List<Post> _posts = const [];
  String? _error;
  bool _forceEmpty = false;
  bool _forceError = false;

  /// Lần tải mới làm kết quả cũ bỏ qua, tránh hai await cùng setState.
  int _loadId = 0;

  @override
  void initState() {
    super.initState();
    // Đã là loading. _load lần đầu không setState trước await.
    _load();
  }

  Future<void> _load() async {
    final loadId = ++_loadId;
    // initState: trạng thái đã loading, setState ở đây dễ khóa cây widget.
    if (_status != PostLoadStatus.loading || _error != null) {
      setState(() {
        _status = PostLoadStatus.loading;
        _error = null;
      });
    }

    try {
      final List<Post> posts;
      if (_forceError) {
        // Lab 1: bỏ mạng. Delay để khung loading kịp vẽ trước khi vào lỗi.
        await Future<void>.delayed(const Duration(milliseconds: 400));
        throw Exception('Giả lập lỗi: không tải được bài viết');
      } else {
        posts = await _api.fetchPosts();
      }
      if (!mounted || loadId != _loadId) return;

      // Lab 1: API có bài nhưng UI cố ý rỗng khi bật công tắc.
      if (_forceEmpty || posts.isEmpty) {
        setState(() {
          _posts = const [];
          _error = null;
          _status = PostLoadStatus.empty;
        });
        return;
      }

      setState(() {
        _posts = posts;
        _error = null;
        _status = PostLoadStatus.data;
      });
    } catch (error) {
      if (!mounted || loadId != _loadId) return;
      setState(() {
        _posts = const [];
        _error = '$error';
        _status = PostLoadStatus.error;
      });
    }
  }

  void _setForceError(bool value) {
    _forceError = value;
    _load();
  }

  void _setForceEmpty(bool value) {
    _forceEmpty = value;
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 18 — Trạng thái'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lab 1 — loading / lỗi / rỗng / dữ liệu',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tắt cả hai công tắc để gọi API thật. Đổi công tắc là tải lại.',
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Giả lập lỗi'),
                  value: _forceError,
                  onChanged: _setForceError,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Giả lập rỗng'),
                  value: _forceEmpty,
                  onChanged: _setForceEmpty,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(child: _buildStatus()),
        ],
      ),
    );
  }

  /// Lab 1: một widget cho mỗi giá trị enum.
  Widget _buildStatus() {
    switch (_status) {
      case PostLoadStatus.loading:
        return const _LoadingPane();
      case PostLoadStatus.error:
        return _ErrorPane(
          message: _error ?? 'Lỗi không rõ',
          onRetry: _load,
        );
      case PostLoadStatus.empty:
        return _EmptyPane(onRetry: _load);
      case PostLoadStatus.data:
        return _PostsPane(posts: _posts);
    }
  }
}

class _LoadingPane extends StatelessWidget {
  const _LoadingPane();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('Đang tải...'),
        ],
      ),
    );
  }
}

class _ErrorPane extends StatelessWidget {
  const _ErrorPane({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            // Lab 2: lỗi thì tải lại. Tắt giả lập lỗi nếu muốn API thật.
            _RetryButton(onRetry: onRetry),
          ],
        ),
      ),
    );
  }
}

class _EmptyPane extends StatelessWidget {
  const _EmptyPane({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Không có bài viết.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Lab 2: rỗng cũng thử lại được. Tắt giả lập rỗng để thấy list.
            _RetryButton(onRetry: onRetry),
          ],
        ),
      ),
    );
  }
}

class _PostsPane extends StatelessWidget {
  const _PostsPane({required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(posts[index].title));
      },
    );
  }
}

/// Lab 2: một nút, hai chỗ gọi (lỗi và rỗng). Không hiện trên list data.
class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onRetry,
      child: const Text('Thử lại'),
    );
  }
}
