import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list_app_flutter/theme/app_colors.dart';
import 'package:shopping_list_app_flutter/theme/color_helper.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
    primaryColor: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.8),
      ),

    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      ),
    )
  );

  static final darkTheme = ThemeData(
    primarySwatch: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
    primaryColor: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.8),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
      ),
    ),

    colorScheme: ColorScheme.dark(
        primary: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
        primaryVariant: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
        secondary: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
        onSecondary: ColorHelper.toMaterialColor(AppColors.APP_GREEN),
    ),
  );

  static final appBarTitleStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
}
