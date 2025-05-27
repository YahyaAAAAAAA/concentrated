import 'package:flutter/material.dart';

extension IntExtensions on int {
  SizedBox get width => toWidth();

  SizedBox get height => toHeight();

  SizedBox toWidth() {
    return SizedBox(
      width: toDouble(),
    );
  }

  SizedBox toHeight() {
    return SizedBox(
      height: toDouble(),
    );
  }
}
