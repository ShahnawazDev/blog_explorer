part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

    @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {

}


class AddFavoriteBlog extends BlogEvent {
  final Blog blog;

  const AddFavoriteBlog(this.blog);

  @override
  List<Object> get props => [blog];
}

class RemoveFavoriteBlog extends BlogEvent {
  final Blog blog;

  const RemoveFavoriteBlog(this.blog);

  @override
  List<Object> get props => [blog];
}
