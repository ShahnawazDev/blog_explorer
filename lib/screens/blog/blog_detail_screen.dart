import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/blocs/blog_bloc/blog_bloc.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(blog.imageUrl),
            ),
            const SizedBox(height: 16.0),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(blog.title),
            const SizedBox(height: 16.0),
            BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is BlogLoaded) {
                  final isFavorite = state.favoriteBlogs.contains(blog);
                  return ElevatedButton(
                    onPressed: () {
                      if (isFavorite) {
                        context.read<BlogBloc>().add(RemoveFavoriteBlog(blog));
                      } else {
                        context.read<BlogBloc>().add(AddFavoriteBlog(blog));
                      }
                    },
                    child: Text(isFavorite
                        ? 'Remove from Favorites'
                        : 'Add to Favorites'),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
