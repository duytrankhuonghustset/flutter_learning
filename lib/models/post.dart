/// Bài viết từ JSONPlaceholder. Ngày 17, không dùng cho Product.
class Post {
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  /// Số JSON decode ra `int` hoặc `double`. `num` nhận cả hai.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  static List<Post> listFromJson(List<dynamic> raw) {
    return raw
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
