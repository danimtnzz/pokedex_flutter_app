import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme(Color color) => ThemeData(
    //*General
    useMaterial3: true,
    colorSchemeSeed: color,
  );
}