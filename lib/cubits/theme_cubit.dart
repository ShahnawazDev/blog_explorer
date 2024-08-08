import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box<bool> themeBox;

  ThemeCubit(this.themeBox)
      : super(themeBox.get('isDarkMode', defaultValue: true) ?? true
            ? ThemeMode.dark
            : ThemeMode.light);

  void toggleTheme() {
    final isDarkMode = state == ThemeMode.dark;
    themeBox.put('isDarkMode', !isDarkMode);
    emit(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
