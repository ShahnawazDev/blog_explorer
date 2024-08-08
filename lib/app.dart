import 'package:blog_explorer/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/blog/blog_list_screen.dart';
import 'blocs/auth_bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Blog Explorer',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          routes: {
            '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthAuthenticated) {
                      return const BlogListScreen();
                    } else if (state is AuthLoading) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is AuthUnauthenticated) {
                      return const LoginScreen();
                    } else {
                      return const SplashScreen();
                    }
                  },
                ),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/blogs': (context) => const BlogListScreen(),
          },
        );
      },
    );
  }
}
