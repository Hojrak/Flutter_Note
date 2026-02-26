import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  // theme data
  ThemeData _themeData = lightTheme;

  // getters and setters
  ThemeData get themeData => _themeData;

  // check if dark mode is enabled
  bool get isDarkMode => _themeData == darkTheme;

  // set theme data
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == darkTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
