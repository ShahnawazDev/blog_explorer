import 'package:blog_explorer/blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_explorer/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_explorer/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_explorer/screens/blog/blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onSignOutButtonPressed() {
      BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
    }

    void onThemeSwitchButtonPressed() {
      BlocProvider.of<ThemeCubit>(context).toggleTheme();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Explorer'),
        actions: [
          IconButton(
            tooltip: 'Switch Theme',
            icon: const Icon(Icons.brightness_6_rounded),
            onPressed: onThemeSwitchButtonPressed,
          ),
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.exit_to_app),
            onPressed: onSignOutButtonPressed,
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogInitial) {
            context.read<BlogBloc>().add(FetchBlogs());
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          Image.network(
                            blog.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                blog.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is BlogError) {
            return const Center(child: Text('Failed to load blogs'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
