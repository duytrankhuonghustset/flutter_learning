import 'dart:convert';

import 'package:flutter_learning/models/post.dart';
import 'package:http/http.dart' as http;

/// Ngày 25 Lab 1: HTTP và parse nằm trong class. Widget không gọi http.get.
class PostApiService {
  static const _postsUrl = 'https://jsonplaceholder.typicode.com/posts';

  /// GET danh sách bài. Status khác 200 thì throw — màn bắt và hiện chữ.
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(_postsUrl));
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }
    final raw = jsonDecode(response.body) as List<dynamic>;
    return Post.listFromJson(raw);
  }
}
