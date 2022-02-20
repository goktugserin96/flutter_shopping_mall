import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialProvider extends ChangeNotifier {
  ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900]),
  );
  ThemeData dark = ThemeData.dark();

  ThemeData dark2 = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900]),
      scaffoldBackgroundColor: Colors.black54,
      brightness: Brightness.dark);

  bool _isThemeData = true;
  bool get isThemeData => _isThemeData;

  ThemeData get themeDataChoice => _isThemeData ? light : dark2;

  void toggleStatus() {
    _isThemeData = !_isThemeData;
    notifyListeners();
  }
}
