import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/screens/blog/blog_detail_screen.dart';

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(blog.imageUrl, fit: BoxFit.cover, width: 50, height: 50),
      title: Text(blog.title),
      trailing: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoaded) {
            final isFavorite = state.favoriteBlogs.contains(blog);
            return IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                if (isFavorite) {
                  context.read<BlogBloc>().add(RemoveFavoriteBlog(blog));
                } else {
                  context.read<BlogBloc>().add(AddFavoriteBlog(blog));
                }
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(blog: blog),
          ),
        );
      },
    );
  }
}