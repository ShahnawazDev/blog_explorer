import 'dart:convert';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogService {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
 
  final String adminSecret = const String.fromEnvironment('ADMIN_SECRET');

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> blogsJson = jsonResponse['blogs'];

        List<Blog> blogs =
            blogsJson.map((blog) => Blog.fromJson(blog)).toList();

        return blogs;
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
