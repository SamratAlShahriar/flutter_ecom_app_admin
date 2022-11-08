import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_admin/themes/colors.dart';

final ThemeData appTheme = _buildAppThemeLight();

ThemeData _buildAppThemeLight() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.orange,
      secondary: Colors.orange,
      error: Colors.red,
    ),
    scaffoldBackgroundColor: kColorSurfaceWhite,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.deepOrange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(),
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base.copyWith().apply();
}
