part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final List<Blog> favoriteBlogs;

  const BlogLoaded(this.blogs, {this.favoriteBlogs = const []});

  @override
  List<Object> get props => [blogs, favoriteBlogs];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object> get props => [message];
}
