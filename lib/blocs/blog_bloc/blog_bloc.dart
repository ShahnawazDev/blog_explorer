import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/repositories/blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;
  final Box<String> favoriteBox;

  BlogBloc({required this.blogRepository})
      : favoriteBox = Hive.box<String>('favorites'),
        super(BlogInitial()) {
    on<FetchBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await blogRepository.fetchBlogs();
        final favoriteIds = favoriteBox.values.toList();
        final favoriteBlogs = blogs.where((blog) => favoriteIds.contains(blog.id)).toList();
        emit(BlogLoaded(blogs, favoriteBlogs: favoriteBlogs));
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });

    on<AddFavoriteBlog>((event, emit) async {
      if (state is BlogLoaded) {
        final currentState = state as BlogLoaded;
        final updatedFavorites = List<Blog>.from(currentState.favoriteBlogs)
          ..add(event.blog);
        await favoriteBox.add(event.blog.id);
        emit(BlogLoaded(currentState.blogs, favoriteBlogs: updatedFavorites));
      }
    });

    on<RemoveFavoriteBlog>((event, emit) async {
      if (state is BlogLoaded) {
        final currentState = state as BlogLoaded;
        final updatedFavorites = List<Blog>.from(currentState.favoriteBlogs)
          ..remove(event.blog);
        await favoriteBox.delete(event.blog.id);
        emit(BlogLoaded(currentState.blogs, favoriteBlogs: updatedFavorites));
      }
    });
  }
}