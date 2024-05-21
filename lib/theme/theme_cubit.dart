import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/theme/dark_mode.dart';
import 'package:weather_app/theme/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit(this._themeData) : super(_themeData);

  ThemeData _themeData;

  bool get isDarkMode => _themeData == darkMode;

  /// update theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    emit(_themeData);
  }

  /// toggle theme based on Current theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
