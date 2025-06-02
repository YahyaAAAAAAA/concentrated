import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

extension TextExtensions on Text {
  Text primary() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: GColors.black,
        fontSize: kBiglFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text primaryOnSurface() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: GColors.white,
        fontSize: kBiglFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text secondary({Color? color, FontWeight? fontWeight}) {
    return Text(
      data ?? '',
      style: TextStyle(
        color: color ?? GColors.black,
        fontSize: kNormalFontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }

  Text secondaryOnSurface() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: GColors.white,
        fontSize: kNormalFontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Text trinary() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: GColors.black,
        fontSize: kSmallFontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Text trinaryOnSurface() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: GColors.white,
        fontSize: kSmallFontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
