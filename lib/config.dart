import 'package:flutter/material.dart';

final Color themeColor = Color(0xffF0F1F3);
final Color backColor = Color(0xff131C2D);

TextStyle getTextStyle(double fontSize, bool isBold, Color color, String fontFamily) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: isBold ? FontWeight.bold : null, 
  );
}