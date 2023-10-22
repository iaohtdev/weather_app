import 'package:flutter/material.dart';

class AppCommon {
  static TextStyle appTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      decoration: decoration,
      color: color ?? const Color(0xff0C4F67),
      fontWeight: fontWeight,
    );
  }
}
