import 'package:blog_explorer/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blog_explorer/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/repositories/blog_repository.dart';
import 'package:blog_explorer/firebase_options.dart';
import 'package:blog_explorer/blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_explorer/repositories/auth_repository.dart';
import 'package:blog_explorer/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox<Blog>('blogs');
  await Hive.openBox<String>('favorites');
  final themeBox = await Hive.openBox<bool>('theme');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) => BlogBloc(blogRepository: BlogRepository()),
        ),
        BlocProvider(create: (context)=> ThemeCubit(themeBox),)
      ],
      child: const App(),
    ),
  );
}
