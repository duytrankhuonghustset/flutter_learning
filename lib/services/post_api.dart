import 'dart:convert';

import 'package:flutter_learning/models/post.dart';
import 'package:http/http.dart' as http;

const postsUrl = 'https://jsonplaceholder.typicode.com/posts';

/// GET danh sách bài. Widget chỉ gọi hàm này, không gọi http.get trực tiếp.
Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse(postsUrl));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }
  final raw = jsonDecode(response.body) as List<dynamic>;
  return Post.listFromJson(raw);
}
