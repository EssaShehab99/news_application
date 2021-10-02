import 'package:flutter/material.dart';

TextStyle textStyle(
    {double fontSize = 15,
      FontWeight fontWeight = FontWeight.bold,
      String fontFamily = "Cairo",
      Color color = Colors.black}) =>
    TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        color: color,
        letterSpacing: 0.79);