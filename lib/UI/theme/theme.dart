import 'package:flutter/material.dart';

///
/// Definition of App colors.
///
class AppColors {
  static Color primarys = const Color(0xFFE81F00);

  static Color backgroundColors = const Color(0xFFFFFFFF);

  static Color secondaryColors = const Color(0xFF000000);
  static Color thirdColors = const Color(0xFFF9F9F9);

  static Color white = Colors.white;

  static Color green = Color(0xff00C853);

  static Color orange = Color(0xffF9A825);

  static Color cyan = Color(0xff7FDBFF);

  static Color gold = Color(0xffFFF44F);

  static Color running = Color(0xffC7EA46);

  static Color get primary {
    return AppColors.primarys;
  }

  static Color get backGroundColor {
    return AppColors.backgroundColors;
  }

  static Color get secondaryColor {
    return AppColors.secondaryColors;
  }

  static Color get thirdColor {
    return AppColors.thirdColors;
  }
}

class AppTextStyles {
  static TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle title = TextStyle(fontSize: 26, fontWeight: FontWeight.w400);

  static TextStyle body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle label = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);

  static TextStyle dropDown = TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryColor);

  static TextStyle watch = TextStyle(fontSize: 40, fontWeight: FontWeight.w400);

  static TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

///
/// Definition of App spacings, in pixels.
/// Bascially small (S), medium (m), large (l), extra large (x), extra extra large (xxl)
///
class AppSpacings {
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 40;

  static const double radius = 7;
  static const double radiusLarge = 24;
}

class AppSize {
  static const double icon = 24;
}

///
/// Definition of App Theme......
///
ThemeData appTheme = ThemeData(
  fontFamily: 'Exo 2',

  //scaffoldBackgroundColor: AppColors.backGroundColor,
);
