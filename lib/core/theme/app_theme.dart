import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/color_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Abel',
    scaffoldBackgroundColor: GColors.white,
    appBarTheme: appbarTheme(),
    pageTransitionsTheme: appPageTransitionsTheme(),
    dividerTheme: appDividerTheme(),
    iconButtonTheme: appIconButtonTheme(),
    radioTheme: appRadioTheme(),
    dialogTheme: appDialogTheme(),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: GColors.white,
      dragHandleColor: GColors.black,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kOuterRadius),
          topRight: Radius.circular(kOuterRadius),
        ),
      ),
    ),
  );
}

RadioThemeData appRadioTheme() {
  return RadioThemeData(
    fillColor: WidgetStatePropertyAll(GColors.black),
    splashRadius: 5,
  );
}

DialogThemeData appDialogTheme() {
  return DialogThemeData(
    backgroundColor: GColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kOuterRadius),
    ),
    titleTextStyle: TextStyle(
      color: GColors.black,
      fontSize: kNormalFontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Abel',
    ),
    contentTextStyle: TextStyle(
      color: GColors.black,
      fontSize: kSmallFontSize,
      fontWeight: FontWeight.normal,
      fontFamily: 'Abel',
    ),
  );
}

IconButtonThemeData appIconButtonTheme() {
  return IconButtonThemeData(
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
  );
}

DividerThemeData appDividerTheme() {
  return DividerThemeData(
    color: GColors.black.shade900,
    thickness: 0.2,
  );
}

AppBarTheme appbarTheme() {
  return AppBarTheme(
    backgroundColor: GColors.white,
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
