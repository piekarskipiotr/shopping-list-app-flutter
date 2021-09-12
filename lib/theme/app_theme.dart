import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      ),
    )
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
      ),
    ),

    colorScheme: ColorScheme.dark(
        primary: Colors.green,
        primaryVariant: Colors.green,
        secondary: Colors.green,
        onSecondary: Colors.green,
    ),
  );

  static final appBarTitleStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
}
