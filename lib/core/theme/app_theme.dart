import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: GColors.white,
    fontFamily: 'Abel',
    pageTransitionsTheme: appPageTransitionsTheme(),
    dividerTheme: DividerThemeData(
      color: GColors.black,
      thickness: 0.2,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: GColors.white,
            fontSize: kSmallFontSize,
            fontFamily: 'Abel',
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(GColors.fern),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius),
          ),
        ),
      ),
    ),
  );
}

PageTransitionsTheme appPageTransitionsTheme() {
  return PageTransitionsTheme(
    builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
      TargetPlatform.values,
      value: (_) => const FadeForwardsPageTransitionsBuilder(),
    ),
  );
}
