import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/services/blog_service.dart';
import 'package:hive/hive.dart';

class BlogRepository {
  final BlogService blogService;
  final Box<Blog> blogBox;

  BlogRepository({BlogService? blogService})
      : blogService = blogService ?? BlogService(),
        blogBox = Hive.box<Blog>('blogs');

  Future<List<Blog>> fetchBlogs() async {
    if (blogBox.isNotEmpty) {
      return blogBox.values.toList();
    } else {
      final blogs = await blogService.fetchBlogs();
      await blogBox.addAll(blogs);
      return blogs;
    }
  }

  Future<void> cacheBlogs(List<Blog> blogs) async {
    await blogBox.clear();
    await blogBox.addAll(blogs);
  }

  Future<List<Blog>> fetchFavoriteBlogs(List<String> favoriteIds) async {
    return blogBox.values.where((blog) => favoriteIds.contains(blog.id)).toList();
  }
}